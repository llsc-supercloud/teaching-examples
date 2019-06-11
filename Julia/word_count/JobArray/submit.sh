#!/bin/sh

#SBATCH -o top5.out-%j-%a
#SBATCH -a 1-4

# run with: sbatch submit.sh
# or run with: LLsub submit.sh

# Initialize Modules
source /etc/profile

# Load Julia Module
module load julia-1.0

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "Number of Tasks: " $SLURM_ARRAY_TASK_COUNT

julia top5each.jl $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT
