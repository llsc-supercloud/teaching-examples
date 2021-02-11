#!/bin/bash

# Run with: LLsub ./submit_LLsub.sh [1,4,1]

# Initialize Modules
source /etc/profile

# Load Anaconda Module
module load anaconda/2020a

echo "My task ID: " $LLSUB_RANK
echo "Number of Tasks: " $LLSUB_SIZE

python top5each.py $LLSUB_RANK $LLSUB_SIZE
