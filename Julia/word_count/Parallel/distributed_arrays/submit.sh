#!/bin/bash

# Slurm sbatch options
#SBATCH -o top5norm.log-%j
#SBATCH -n 4

# Load Julia Module
module load julia

# Call your script as you would from the command line
julia top5norm.jl