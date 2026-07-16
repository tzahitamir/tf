import base64
import json
import os
import urllib.request
import urllib.error

import pg8000.native

OLLAMA_URL = os.environ["OLLAMA_URL"]  # generate endpoint, e.g. http://host:11434/api/generate
OLLAMA_EMBEDDINGS_URL = OLLAMA_URL.rsplit("/api/", 1)[0] + "/api/embeddings"
API_SHARED_SECRET = os.environ["API_SHARED_SECRET"]
MODEL = "llama3.2:1b"
EMBEDDING_MODEL = "nomic-embed-text"

DB_CREDENTIALS = json.loads(os.environ["DB_CREDENTIALS_JSON"])
DB_HOST, DB_PORT = os.environ["DB_ENDPOINT"].split(":")


def get_embedding(text):
    payload = json.dumps({"model": EMBEDDING_MODEL, "prompt": text}).encode("utf-8")
    req = urllib.request.Request(
        OLLAMA_EMBEDDINGS_URL, data=payload,
        headers={"Content-Type": "application/json"}, method="POST"
    )
    with urllib.request.urlopen(req, timeout=20) as res:
        result = json.loads(res.read().decode("utf-8"))
    return result["embedding"]


def retrieve_context(query_embedding, top_k=3):
    vector_literal = "[" + ",".join(map(str, query_embedding)) + "]"

    conn = pg8000.native.Connection(
        user=DB_CREDENTIALS["username"],
        password=DB_CREDENTIALS["password"],
        host=DB_HOST,
        port=int(DB_PORT),
        database=DB_CREDENTIALS["dbname"],
    )
    try:
        rows = conn.run(
            """
            SELECT d.name, c.content
            FROM document_chunks c
            JOIN documents d ON d.id = c.document_id
            ORDER BY c.embedding <=> :query_vector
            LIMIT :top_k
            """,
            query_vector=vector_literal,
            top_k=top_k,
        )
    finally:
        conn.close()
    return rows  # list of [document_name, content]


def build_augmented_prompt(question, retrieved_chunks):
    if not retrieved_chunks:
        return question

    context_text = "\n\n".join(f"[{name}] {content}" for name, content in retrieved_chunks)
    return (
        "Answer the question using the context below if it's relevant. "
        "If the context doesn't contain the answer, say you don't know.\n\n"
        f"Context:\n{context_text}\n\n"
        f"Question: {question}"
    )


def handler(event, context):
    print(f"Incoming event: {json.dumps(event)}")
    try:
        # HTTP API (v2) normalizes header names to lowercase
        provided_secret = event.get("headers", {}).get("x-api-key")
        if provided_secret != API_SHARED_SECRET:
            return _response(401, {"error": "Unauthorized"})

        # API Gateway (HTTP API) puts the body as a string; it may be
        # base64-encoded depending on the request's Content-Type
        raw_body = event.get("body") or "{}"
        if event.get("isBase64Encoded"):
            raw_body = base64.b64decode(raw_body).decode("utf-8")
        body = json.loads(raw_body)
        prompt = body.get("prompt")

        if not prompt:
            return _response(400, {"error": "Missing 'prompt' in request body"})

        # RAG: embed the question, retrieve relevant chunks, augment the prompt
        query_embedding = get_embedding(prompt)
        retrieved_chunks = retrieve_context(query_embedding, top_k=3)
        augmented_prompt = build_augmented_prompt(prompt, retrieved_chunks)

        payload = json.dumps({
            "model": MODEL,
            "prompt": augmented_prompt,
            "stream": False,  # get one full response instead of streamed chunks
            "keep_alive": "30m"  # keep the model resident in memory between calls
        }).encode("utf-8")

        req = urllib.request.Request(
            OLLAMA_URL,
            data=payload,
            headers={"Content-Type": "application/json"},
            method="POST"
        )

        with urllib.request.urlopen(req, timeout=20) as res:
            raw_response = res.read().decode("utf-8")
            print(f"Ollama raw response (status={res.status}): {raw_response!r}")
            ollama_result = json.loads(raw_response)

        return _response(200, {
            "response": ollama_result.get("response"),
            "model": MODEL,
            "sources": [name for name, _ in retrieved_chunks]
        })

    except urllib.error.URLError as e:
        return _response(502, {"error": f"Could not reach Ollama: {str(e)}"})
    except Exception as e:
        return _response(500, {"error": str(e)})


def _response(status_code, body_dict):
    return {
        "statusCode": status_code,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps(body_dict)
    }
