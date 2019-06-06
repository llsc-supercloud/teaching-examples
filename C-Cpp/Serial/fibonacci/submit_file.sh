#!/bin/bash

# Initialize Modules
source /etc/profile

# Load the Anaconda Module
module load anaconda3-2019a

# Specify Input File
INPUT_FILE=../../../data/fibonacci/inputFile_10

# Run the Wrapper Script
python wrapper.py $INPUT_FILE
