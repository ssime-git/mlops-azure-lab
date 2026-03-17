"""Register the trained model in AML Model Registry."""

import argparse
import os
from pathlib import Path

from azure.ai.ml import MLClient
from azure.ai.ml.constants import AssetTypes
from azure.ai.ml.entities import Model
from azure.identity import DefaultAzureCredential


def main(args):
    client = MLClient(
        DefaultAzureCredential(),
        subscription_id=args.subscription_id,
        resource_group_name=args.resource_group,
        workspace_name=args.workspace,
    )

    model_path = Path(args.model_dir)
    nested_model_file = model_path / "model.joblib"
    if model_path.is_dir() and nested_model_file.exists():
        model_path = nested_model_file

    model = Model(
        path=str(model_path),
        type=AssetTypes.CUSTOM_MODEL,
        name="iris-classifier",
        description="LogisticRegression on Iris dataset",
        tags={
            "accuracy": args.accuracy,
            "framework": "scikit-learn",
            "env": args.environment,
        },
    )
    registered = client.models.create_or_update(model)
    print(f"Registered: {registered.name} v{registered.version} from {model_path}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--model_dir", required=True)
    parser.add_argument("--accuracy", default="unknown")
    parser.add_argument("--environment", default="dev")
    parser.add_argument(
        "--subscription_id", default=os.environ.get("AZURE_SUBSCRIPTION_ID", "")
    )
    parser.add_argument(
        "--resource_group", default=os.environ.get("AML_RESOURCE_GROUP", "")
    )
    parser.add_argument("--workspace", default=os.environ.get("AML_WORKSPACE", ""))
    main(parser.parse_args())
