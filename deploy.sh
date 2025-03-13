DATA_DIR="./data"
MODEL_DIR="./models"
ARCHIVE_DIR="./archive"
LATEST_MODEL="$MODEL_DIR/latest_model.pkl"
NEW_MODEL="$MODEL_DIR/new_model.pkl"
TRAIN_SCRIPT="train.py"
EVAL_SCRIPT="evaluate.py"

LOG_FILE="deployment.log"
echo "Starting automation..." > $LOG_FILE


if [ -z "$(ls -A $DATA_DIR)" ]; then
    echo "No new data found. Exiting..." | tee -a $LOG_FILE
    exit 1
fi


echo "Training new model..." | tee -a $LOG_FILE
python3 $TRAIN_SCRIPT --data_dir $DATA_DIR --output_model $NEW_MODEL


if [ -f "$LATEST_MODEL" ]; then
    echo "Evaluating model performance..." | tee -a $LOG_FILE
    python3 $EVAL_SCRIPT --new_model $NEW_MODEL --old_model $LATEST_MODEL > temp_eval.txt
    PERFORMANCE=$(cat temp_eval.txt)

    if [ "$PERFORMANCE" == "better" ]; then
        echo "New model is better. Deploying..." | tee -a $LOG_FILE
        mv $LATEST_MODEL $ARCHIVE_DIR/model_$(date +%Y%m%d%H%M).pkl
        mv $NEW_MODEL $LATEST_MODEL
    else
        echo "New model is not better. Discarding..." | tee -a $LOG_FILE
        rm $NEW_MODEL
    fi
else
    echo "No previous model found. Deploying new model as baseline." | tee -a $LOG_FILE
    mv $NEW_MODEL $LATEST_MODEL
fi


rm -r $DATA_DIR/*
echo "Deployment complete." | tee -a $LOG_FILE
