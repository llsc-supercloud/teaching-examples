#!/bin/bash

# run with: LLsub ./submit_LLsub.sh [1,4,1]

# Load Julia Module
module load julia/1.7.3

echo "My SLURM_ARRAY_TASK_ID: " $LLSUB_RANK
echo "Number of Tasks: " $LLSUB_SIZE

julia top5each.jl $LLSUB_RANK $LLSUB_SIZE
