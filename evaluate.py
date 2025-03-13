import argparse
import pickle
import random

def evaluate_model(new_model_path, old_model_path):
    with open(new_model_path, "rb") as f:
        new_model = pickle.load(f)

    if old_model_path:
        with open(old_model_path, "rb") as f:
            old_model = pickle.load(f)

       
        new_score = sum(new_model["weights"]) + random.uniform(0, 1)
        old_score = sum(old_model["weights"]) + random.uniform(0, 1)

        print("New Model Score:", new_score)
        print("Old Model Score:", old_score)

        if new_score > old_score:
            print("better")
        else:
            print("worse")
    else:
        print("better")  

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--new_model", required=True, help="Path to new model")
    parser.add_argument("--old_model", help="Path to old model (if exists)")
    args = parser.parse_args()

    evaluate_model(args.new_model, args.old_model)
