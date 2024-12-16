#!/bin/bash

# Slurm sbatch options
#SBATCH -o top5norm.log-%j
#SBATCH -n 4
#SBATCH -p mit_normal

# Load Anaconda and MPI module
module load miniforge
module load openmpi

source .venv/bin/activate

# Call your script as you would from the command line
mpirun python top5norm.py


