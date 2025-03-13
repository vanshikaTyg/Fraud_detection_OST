import argparse
import os
import pickle
import random

def train_model(data_dir, output_model):
    print("Training model using data from:", data_dir)

   
    model = {"weights": [random.random() for _ in range(10)]}


    with open(output_model, "wb") as f:
        pickle.dump(model, f)

    print("Model saved to:", output_model)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--data_dir", required=True, help="Path to data directory")
    parser.add_argument("--output_model", required=True, help="Path to save trained model")
    args = parser.parse_args()

    train_model(args.data_dir, args.output_model)
