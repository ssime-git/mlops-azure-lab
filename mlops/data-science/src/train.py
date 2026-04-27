"""Train LogisticRegression on Iris. Log metrics with MLflow. Save model."""

import argparse
import os

import joblib
import mlflow
import pandas as pd
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler


def main(args):
    train_df = pd.read_csv(f"{args.data_dir}/train.csv")
    X, y = train_df.drop("target", axis=1), train_df["target"]

    with mlflow.start_run():
        model = Pipeline(
            [
                ("scaler", StandardScaler()),
                (
                    "classifier",
                    LogisticRegression(max_iter=args.max_iter, random_state=42),
                ),
            ]
        )
        model.fit(X, y)
        acc = accuracy_score(y, model.predict(X))
        mlflow.log_param("max_iter", args.max_iter)
        mlflow.log_metric("train_accuracy", acc)

    os.makedirs(args.model_dir, exist_ok=True)
    joblib.dump(model, f"{args.model_dir}/model.joblib")
    print(f"Train accuracy: {acc:.4f} - model saved to {args.model_dir}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--data_dir", default="data/processed")
    parser.add_argument("--model_dir", default="outputs/model")
    parser.add_argument("--max_iter", type=int, default=200)
    main(parser.parse_args())
