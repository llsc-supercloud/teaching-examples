#!/bin/bash

# Scheduler Options
#SBATCH -o myout.log-%A-%a
#SBATCH -a 1-4

# Load Anaconda module
module load anaconda/2023a

# Specify Input File
INPUT_FILE=../../../data/fibonacci/inputFile_200

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "Number of Tasks: " $SLURM_ARRAY_TASK_COUNT

# Run the Wrapper Script
python wrapper.py $INPUT_FILE $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT
