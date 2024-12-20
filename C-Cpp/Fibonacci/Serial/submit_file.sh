#!/bin/bash

# TODO: Rewrite in loop in bash to remove need for wrapper

# Load the Anaconda Module
module load miniforge

# Specify Input File
INPUT_FILE=../../../data/fibonacci/inputFile_10

# Run the Wrapper Script
python wrapper.py $INPUT_FILE
