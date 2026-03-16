"""Register the trained model in AML Model Registry."""

import argparse
import os

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
    model = Model(
        path=args.model_dir,
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
    print(f"Registered: {registered.name} v{registered.version}")


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
