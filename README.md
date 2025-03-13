# Fraud Detection System - Automated Training & Deployment

## Overview
This project is an AI-powered fraud detection system for an e-commerce platform. The system is fully automated to:

- Train a fraud detection model when new data arrives.
- Evaluate model performance before deployment.
- Archive old models to maintain version history.
- Deploy the latest model automatically if it improves fraud detection.

## Project Structure
```
fraud_detection/
│-- data/              # Stores transaction data
│-- models/            # Stores trained models
│   │-- archive/       # Backup of older models
│   │-- current_model.pkl  # The latest deployed model
│-- scripts/           # Python scripts for training & evaluation
│   │-- train.py       # Model training script
│   │-- evaluate.py    # Model evaluation script
│-- deploy.sh          # Automated deployment script
│-- README.md          # Project documentation
```

## Installation & Setup
### Prerequisites
- Python 3.x
- Git
- Required Python packages (install via `requirements.txt` if available)

```bash
pip install -r requirements.txt
```

## Running the System
### Step 1: Prepare the Data
Place transaction data (`transactions.csv`) inside the `data/` directory.

### Step 2: Run the Deployment Script
```bash
./deploy.sh
```
This script will:
- Train a new model using the latest data.
- Evaluate the new model against the current model.
- Deploy the new model only if it performs better.
- Archive the previous model for versioning.

### Step 3: Push Changes to GitHub
```bash
git add .
git commit -m "Updated automation pipeline"
git push origin main
```

## Authors
- Vanshika Tyagi

