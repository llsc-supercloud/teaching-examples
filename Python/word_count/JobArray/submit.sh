#!/bin/bash

#SBATCH -o top5.out-%j-%a
#SBATCH -a 1-4

# run with: sbatch jobArray.sh
# or run with: LLsub jobArray.sh

# Initialize Modules
source /etc/profile

# Load Anaconda Module
module load anaconda/2020a

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "Number of Tasks: " $SLURM_ARRAY_TASK_COUNT

python top5each.py $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT
