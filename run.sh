#!/bin/bash
figlet "LSTM-Intrusion-Detection"
printf "Operation: [1] Train [2] Test\n>> "
read choice
if [ "$choice" -eq "1" ] &>/dev/null; then
	echo "Training LSTM model for intrusion detection"
	if [ ! -d "./models/checkpoint" ] &>/dev/null; then
		mkdir models/checkpoint_path
	fi
	python3 LSTM_main.py --operation "train" \
    --train_dataset /datasets/KDDTrain.csv \
    --test_dataset /datasets/KDDTest.csv \
    --checkpoint_path /model/CheckPoints/weights.hdf5" \
    --save_model modelSaves/  \
    --result_path results/
elif [ "$choice" -eq "2" ] &>/dev/null; then
	if [ -d "./models/checkpoint/" ] &>/dev/null; then
		echo "Testing LSTM model for intrusion detection"
		python3 LSTM_main.py --operation "test" \
        --test_dataset dataset/KDDTest.csv \
        --load_model modelsSaves/model_file.h5 \
        --result_path results/
	else
		echo "Train the model first!"
		exit
	fi
else
	echo "Invalid input"
	exit
fi