#!/bin/bash

# Slurm sbatch options
#SBATCH -o top5norm_forkjoin.log-%j
#SBATCH -n 4

# Load Anaconda and MPI module
module load gcc/9.3.0
module load openmpi/4.0.5

module load miniforge

# Call your script as you would from the command line
mpirun python top5norm.py


