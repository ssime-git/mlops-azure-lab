"""Evaluate model on test set. Exit code 1 if accuracy < threshold (CI quality gate)."""
import argparse
import sys

import joblib
import mlflow
import pandas as pd
from sklearn.metrics import accuracy_score, classification_report, f1_score


def main(args):
    test_df = pd.read_csv(f"{args.data_dir}/test.csv")
    X, y = test_df.drop("target", axis=1), test_df["target"]
    model = joblib.load(f"{args.model_dir}/model.joblib")
    preds = model.predict(X)
    acc = accuracy_score(y, preds)
    f1 = f1_score(y, preds, average="weighted")

    with mlflow.start_run():
        mlflow.log_metric("test_accuracy", acc)
        mlflow.log_metric("test_f1_weighted", f1)

    print(classification_report(y, preds, target_names=["setosa", "versicolor", "virginica"]))
    print(f"Accuracy: {acc:.4f} | F1 (weighted): {f1:.4f} | Threshold: {args.min_accuracy}")

    if acc < args.min_accuracy:
        print(f"FAIL: {acc:.4f} < {args.min_accuracy}")
        sys.exit(1)
    print("PASS: model meets quality threshold")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--data_dir", default="data/processed")
    parser.add_argument("--model_dir", default="outputs/model")
    parser.add_argument("--min_accuracy", type=float, default=0.90)
    main(parser.parse_args())
