#!/bin/bash

# Slurm sbatch options
#SBATCH -o top5norm_forkjoin.log-%j
#SBATCH -n 4

# Load Anaconda and MPI module
module load miniforge
module load openmpi

# Call your script as you would from the command line
mpirun python top5norm_forkjoin.py


