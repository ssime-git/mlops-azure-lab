import importlib
import json
import os
import sys
from pathlib import Path

import pytest

sys.path.insert(0, "mlops/data-science/src")
from prep import main as prep_main  # noqa: E402
from train import main as train_main  # noqa: E402


class PrepArgs:
    def __init__(self, output_dir):
        self.output_dir = output_dir


class TrainArgs:
    def __init__(self, data_dir, model_dir, max_iter=200):
        self.data_dir = data_dir
        self.model_dir = model_dir
        self.max_iter = max_iter


@pytest.fixture()
def endpoint_client(tmp_path):
    data_dir = tmp_path / "data"
    model_dir = tmp_path / "model"
    prep_main(PrepArgs(str(data_dir)))
    train_main(TrainArgs(str(data_dir), str(model_dir)))

    app_dir = Path("mlops/data-science").resolve()
    original_cwd = Path.cwd()
    previous_model_dir = os.environ.get("AZUREML_MODEL_DIR")
    os.environ["AZUREML_MODEL_DIR"] = str(model_dir)

    try:
        if str(app_dir) not in sys.path:
            sys.path.insert(0, str(app_dir))
        os.chdir(app_dir)
        if "server" in sys.modules:
            del sys.modules["server"]
        server = importlib.import_module("server")
        yield server.app.test_client()
    finally:
        os.chdir(original_cwd)
        if previous_model_dir is None:
            os.environ.pop("AZUREML_MODEL_DIR", None)
        else:
            os.environ["AZUREML_MODEL_DIR"] = previous_model_dir


def test_health_endpoint(endpoint_client):
    response = endpoint_client.get("/health")
    assert response.status_code == 200
    assert response.get_json() == {"status": "ok"}


def test_score_endpoint_contract(endpoint_client):
    payload = {"data": [[5.1, 3.5, 1.4, 0.2]]}
    response = endpoint_client.post(
        "/score",
        data=json.dumps(payload),
        content_type="application/json",
    )

    assert response.status_code == 200
    body = json.loads(response.get_data(as_text=True))
    assert isinstance(body, list)
    assert len(body) == 1
    assert set(body[0].keys()) == {"prediction", "class_id", "probabilities"}
    assert isinstance(body[0]["prediction"], str)
    assert isinstance(body[0]["class_id"], int)
    assert isinstance(body[0]["probabilities"], list)
    assert len(body[0]["probabilities"]) == 3
