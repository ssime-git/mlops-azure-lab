import os
import sys
import tempfile

import pandas as pd

sys.path.insert(0, "mlops/data-science/src")
from prep import main as prep_main


class A:
    def __init__(self, d):
        self.output_dir = d


def test_files_created():
    with tempfile.TemporaryDirectory() as tmp:
        prep_main(A(tmp))
        assert os.path.exists(f"{tmp}/train.csv")
        assert os.path.exists(f"{tmp}/test.csv")


def test_split_ratio():
    with tempfile.TemporaryDirectory() as tmp:
        prep_main(A(tmp))
        tr = pd.read_csv(f"{tmp}/train.csv")
        te = pd.read_csv(f"{tmp}/test.csv")
        assert len(tr) + len(te) == 150
        assert abs(len(te) / 150 - 0.2) < 0.02
