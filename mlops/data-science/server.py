"""Minimal Flask server wrapping score.py for AKS deployment."""

import os
import sys

from flask import Flask, request

sys.path.insert(0, "src")
from score import init, run  # noqa: E402

if os.environ.get("APPLICATIONINSIGHTS_CONNECTION_STRING"):
    try:
        from azure.monitor.opentelemetry import configure_azure_monitor
    except ImportError as exc:
        print(f"App Insights instrumentation disabled: {exc}")
    else:
        configure_azure_monitor()

app = Flask(__name__)
init()


@app.route("/score", methods=["POST"])
def score():
    return (
        run(request.get_data(as_text=True)),
        200,
        {"Content-Type": "application/json"},
    )


@app.route("/health", methods=["GET"])
def health():
    return {"status": "ok"}, 200
