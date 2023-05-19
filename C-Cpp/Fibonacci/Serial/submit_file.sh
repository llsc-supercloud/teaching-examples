#!/bin/bash

# Load the Anaconda Module
module load anaconda/2023a

# Specify Input File
INPUT_FILE=../../../data/fibonacci/inputFile_10

# Run the Wrapper Script
python wrapper.py $INPUT_FILE
