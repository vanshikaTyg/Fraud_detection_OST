DATA_DIR="./data"
MODEL_DIR="./models"
NEW_MODEL_PATH="$MODEL_DIR/new_model.pkl"
CURRENT_MODEL_PATH="$MODEL_DIR/current_model.pkl"
ARCHIVE_DIR="$MODEL_DIR/archive"

mkdir -p "$MODEL_DIR" "$ARCHIVE_DIR"

if [ -z "$(ls -A $DATA_DIR)" ]; then
    echo "No new data found. Exiting..."
    exit 0
fi

echo "Training new model..."
python train.py --data_dir "$DATA_DIR" --output_model "$NEW_MODEL_PATH"

if [ ! -f "$CURRENT_MODEL_PATH" ]; then
    echo "No previous model found. Deploying new model as baseline."
    mv "$NEW_MODEL_PATH" "$CURRENT_MODEL_PATH"
    echo "Deployment complete."
    exit 0
fi

echo "Evaluating new model..."
python evaluate.py --new_model "$NEW_MODEL_PATH" --old_model "$CURRENT_MODEL_PATH"

if [ $? -eq 0 ]; then
    TIMESTAMP=$(date +"%Y%m%d%H%M%S")
    ARCHIVED_MODEL="$ARCHIVE_DIR/model_$TIMESTAMP.pkl"
    mv "$CURRENT_MODEL_PATH" "$ARCHIVED_MODEL"
    mv "$NEW_MODEL_PATH" "$CURRENT_MODEL_PATH"
    echo "New model deployed successfully. Old model archived at $ARCHIVED_MODEL."
else
    echo "New model did not perform better. Keeping the current model."
    rm "$NEW_MODEL_PATH"
fi

echo "Deployment process completed."
