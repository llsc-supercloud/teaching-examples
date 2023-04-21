#!/bin/bash


#SBATCH -o top5.out-%A-%a
#SBATCH -a 0-3

# run with: sbatch submit_sbatch.sh

# Load Anaconda Module
module load anaconda/2023a

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "Number of Tasks: " $SLURM_ARRAY_TASK_COUNT

python top5each.py $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT
