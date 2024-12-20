#!/bin/bash

#SBATCH -o submit_norm.sh.log-%j
#SBATCH -p mit_normal

# Load Julia Module
module load julia/1.9.1

# Call your script as you would from the command line
julia top5norm.jl
