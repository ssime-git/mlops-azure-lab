import os
import sys
import tempfile

sys.path.insert(0, "mlops/data-science/src")
from prep import main as prep_main
from train import main as train_main


class PA:
    def __init__(self, d):
        self.output_dir = d


class TA:
    def __init__(self, data_dir, model_dir, max_iter=50):
        self.data_dir = data_dir
        self.model_dir = model_dir
        self.max_iter = max_iter


def test_model_created():
    with tempfile.TemporaryDirectory() as tmp:
        data = f"{tmp}/data"
        model = f"{tmp}/model"
        prep_main(PA(data))
        train_main(TA(data, model))
        assert os.path.exists(f"{model}/model.joblib")
