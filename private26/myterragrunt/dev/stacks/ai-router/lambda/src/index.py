import json
import os
import urllib.request
import urllib.error

OLLAMA_URL = os.environ["OLLAMA_URL"]
API_SHARED_SECRET = os.environ["API_SHARED_SECRET"]
MODEL = "llama3.2:1b"


def handler(event, context):
    try:
        # HTTP API (v2) normalizes header names to lowercase
        provided_secret = event.get("headers", {}).get("x-api-key")
        if provided_secret != API_SHARED_SECRET:
            return _response(401, {"error": "Unauthorized"})

        # API Gateway (HTTP API) puts the body as a JSON string
        body = json.loads(event.get("body") or "{}")
        prompt = body.get("prompt")

        if not prompt:
            return _response(400, {"error": "Missing 'prompt' in request body"})

        payload = json.dumps({
            "model": MODEL,
            "prompt": prompt,
            "stream": False  # get one full response instead of streamed chunks
        }).encode("utf-8")

        req = urllib.request.Request(
            OLLAMA_URL,
            data=payload,
            headers={"Content-Type": "application/json"},
            method="POST"
        )

        with urllib.request.urlopen(req, timeout=30) as res:
            ollama_result = json.loads(res.read().decode("utf-8"))

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
