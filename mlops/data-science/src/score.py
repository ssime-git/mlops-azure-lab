"""Inference script for AML online endpoint and AKS Flask server."""

import json
import os

import joblib
import numpy as np

MODEL = None
CLASSES = ["setosa", "versicolor", "virginica"]


def init():
    global MODEL
    model_path = os.path.join(
        os.environ.get("AZUREML_MODEL_DIR", "/app/model"), "model.joblib"
    )
    MODEL = joblib.load(model_path)
    print(f"Model loaded from {model_path}")


def run(raw_data: str) -> str:
    data = json.loads(raw_data)
    features = np.array(data["data"])
    preds = MODEL.predict(features).tolist()
    probas = MODEL.predict_proba(features).tolist()
    result = [
        {"prediction": CLASSES[p], "class_id": p, "probabilities": prob}
        for p, prob in zip(preds, probas)
    ]
    return json.dumps(result)
