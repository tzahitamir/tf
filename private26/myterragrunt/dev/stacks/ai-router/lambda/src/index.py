import base64
import json
import os
import urllib.request
import urllib.error

OLLAMA_URL = os.environ["OLLAMA_URL"]
API_SHARED_SECRET = os.environ["API_SHARED_SECRET"]
MODEL = "llama3.2:1b"


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

        payload = json.dumps({
            "model": MODEL,
            "prompt": prompt,
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
            raw_body = res.read().decode("utf-8")
            print(f"Ollama raw response (status={res.status}): {raw_body!r}")
            ollama_result = json.loads(raw_body)

        return _response(200, {
            "response": ollama_result.get("response"),
            "model": MODEL
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
