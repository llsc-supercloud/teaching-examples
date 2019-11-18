#!/bin/sh

# Slurm sbatch options
#SBATCH -o top5norm_forkjoin.log-%j
#SBATCH -n 14


# Initialize Modules
source /etc/profile

# Load Julia Module
module load julia-latest

# Call your script as you would from the command line
julia top5norm_forkjoin.jl
