#!/bin/bash

# Slurm sbatch options
#SBATCH -o top5norm_mresque.log-%j
#SBATCH -n 4

# Load Julia Module
module load julia/1.7.3

# Call your script as you would from the command line
julia top5norm_mresque.jl
