#!/bin/sh

# Initialize Modules
source /etc/profile

# Load Julia Module
module load anaconda3-5.0.1

# Call your script as you would from the command line
python top5each.py
