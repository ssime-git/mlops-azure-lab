"""Inference script for AML online endpoint and AKS Flask server."""

import json
import os
from pathlib import Path

import joblib
import numpy as np

MODEL = None
CLASSES = ["setosa", "versicolor", "virginica"]


def init():
    global MODEL
    model_root = Path(os.environ.get("AZUREML_MODEL_DIR", "/app/model"))
    model_path = model_root / "model.joblib"

    if not model_path.exists():
        matches = sorted(model_root.rglob("model.joblib"))
        if not matches:
            raise FileNotFoundError(
                f"model.joblib not found under AZUREML_MODEL_DIR={model_root}"
            )
        model_path = matches[0]

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
