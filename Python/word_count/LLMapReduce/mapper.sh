#!/bin/sh

# Initialize Modules
source /etc/profile

# Load Julia Module
module load anaconda3-5.0.1

# Call your script as you would from the command line, passing in $1 and $2 as arugments
# Note that $1 and $2 are the arguments passed into this script
python top5overall_map.py $1 $2
