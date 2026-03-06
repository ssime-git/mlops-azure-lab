"""Minimal Flask server wrapping score.py for AKS deployment."""
import sys

from flask import Flask, request

sys.path.insert(0, "src")
from score import init, run  # noqa: E402

app = Flask(__name__)
init()


@app.route("/score", methods=["POST"])
def score():
    return run(request.get_data(as_text=True)), 200, {"Content-Type": "application/json"}


@app.route("/health", methods=["GET"])
def health():
    return {"status": "ok"}, 200
