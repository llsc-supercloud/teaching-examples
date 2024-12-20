#!/bin/bash

#SBATCH -o top5.out-%A-%a
#SBATCH -a 0-3
#SBATCH -p mit_normal

# run with: sbatch submit.sh

# Load Julia Module
module load julia/1.9.1

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "Number of Tasks: " $SLURM_ARRAY_TASK_COUNT

julia top5each.jl $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT
