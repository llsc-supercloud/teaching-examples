#!/bin/bash

# Load Julia Module
module load julia/1.7.3

# Call your script as you would from the command line, passing in $1 and $2 as arugments
# Note that $1 and $2 are the arguments passed into this script
julia top5overall_map.jl $1 $2
