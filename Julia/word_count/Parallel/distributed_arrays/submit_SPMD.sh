#!/bin/bash

# Slurm sbatch options
#SBATCH -o top5norm_SPMD.log-%j
#SBATCH -n 14

# Initialize Modules
source /etc/profile

#Load Julia module
module load julia/1.3.0

# Call your script as you would from the command line
julia top5norm_SPMD.jl
