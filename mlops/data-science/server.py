"""Minimal Flask server wrapping score.py for AKS deployment."""

import os
import sys

import flask

sys.path.insert(0, "src")
from score import init, run  # noqa: E402

app_insights_connection_string = os.environ.get("APPLICATIONINSIGHTS_CONNECTION_STRING")

if os.environ.get("APPLICATIONINSIGHTS_CONNECTION_STRING"):
    try:
        from azure.monitor.opentelemetry import configure_azure_monitor
        from opentelemetry.instrumentation.flask import FlaskInstrumentor
    except ImportError as exc:
        print(f"App Insights instrumentation disabled: {exc}")
    else:
        configure_azure_monitor(connection_string=app_insights_connection_string)

app = flask.Flask(__name__)

if app_insights_connection_string:
    try:
        FlaskInstrumentor().instrument_app(app)
    except NameError:
        pass

init()


@app.route("/score", methods=["POST"])
def score():
    return (
        run(flask.request.get_data(as_text=True)),
        200,
        {"Content-Type": "application/json"},
    )


@app.route("/health", methods=["GET"])
def health():
    return {"status": "ok"}, 200
