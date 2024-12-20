#!/bin/bash

# Scheduler Options
#SBATCH -o myout.log-%A-%a
#SBATCH -a 1-4

#TODO: rewrite to run with bash without wrapper

# Load Anaconda module
module load miniforge

# Specify Input File
INPUT_FILE=../../../data/fibonacci/inputFile_200

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "Number of Tasks: " $SLURM_ARRAY_TASK_COUNT

# Run the Wrapper Script
python wrapper.py $INPUT_FILE $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT
