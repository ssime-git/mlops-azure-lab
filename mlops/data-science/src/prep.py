"""Data preparation: load Iris from sklearn, split 80/20, save as CSV."""

import argparse
import os

import pandas as pd
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split


def main(args):
    iris = load_iris(as_frame=True)
    df = iris.frame
    df.columns = [c.replace(" (cm)", "").replace(" ", "_") for c in df.columns]
    X = df.drop("target", axis=1)
    y = df["target"]
    X_tr, X_te, y_tr, y_te = train_test_split(
        X, y, test_size=0.2, random_state=42, stratify=y
    )
    os.makedirs(args.output_dir, exist_ok=True)
    pd.concat([X_tr, y_tr], axis=1).to_csv(f"{args.output_dir}/train.csv", index=False)
    pd.concat([X_te, y_te], axis=1).to_csv(f"{args.output_dir}/test.csv", index=False)
    print(f"Prep done - train: {len(X_tr)}, test: {len(X_te)}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--output_dir", default="data/processed")
    main(parser.parse_args())
