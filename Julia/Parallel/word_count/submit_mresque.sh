#!/bin/sh

# Slurm sbatch options
#SBATCH -o top5norm_mresque.log-%j
#SBATCH -n 14

#Initialize Modules
source /usr/share/Modules/init/sh

# Load Julia Module
module load julia-1.0

# Call your script as you would from the command line
julia top5norm_mresque.jl
