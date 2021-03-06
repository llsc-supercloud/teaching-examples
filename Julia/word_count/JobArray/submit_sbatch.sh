#!/bin/bash

#SBATCH -o top5.out-%A-%a
#SBATCH -a 0-3

# run with: sbatch submit_sbatch.sh

# Initialize Modules
source /etc/profile

# Load Julia Module
module load julia/1.5.2

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "Number of Tasks: " $SLURM_ARRAY_TASK_COUNT

julia top5each.jl $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT
