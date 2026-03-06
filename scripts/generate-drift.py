"""Send normal + drifted requests to endpoint. Used in J4 monitoring exercise."""
import argparse
import json
import random

import requests

NORMAL = {
    "sepal_length": (4.3, 7.9),
    "sepal_width": (2.0, 4.4),
    "petal_length": (1.0, 6.9),
    "petal_width": (0.1, 2.5),
}


def sample(drifted=False):
    return [
        round(random.uniform(lo, hi) * (random.uniform(1.5, 2.5) if drifted else 1.0), 2)
        for lo, hi in NORMAL.values()
    ]


def main(args):
    hdrs = {"Content-Type": "application/json", "Authorization": f"Bearer {args.api_key}"}
    for i in range(args.n_normal):
        r = requests.post(args.endpoint, data=json.dumps({"data": [sample(False)]}), headers=hdrs)
        if i % 10 == 0:
            print(f"Normal  [{i:3d}] -> {r.status_code}")
    for i in range(args.n_drifted):
        r = requests.post(args.endpoint, data=json.dumps({"data": [sample(True)]}), headers=hdrs)
        print(f"DRIFTED [{i:3d}] -> {r.status_code}: {r.text[:60]}")


if __name__ == "__main__":
    p = argparse.ArgumentParser()
    p.add_argument("--endpoint", required=True)
    p.add_argument("--api_key", default="")
    p.add_argument("--n_normal", type=int, default=50)
    p.add_argument("--n_drifted", type=int, default=20)
    main(p.parse_args())
