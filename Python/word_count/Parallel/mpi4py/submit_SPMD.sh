#!/bin/bash

# Slurm sbatch options
#SBATCH -o top5norm_SPMD.log-%j
#SBATCH -n 4

# Load Anaconda and MPI module
module load anaconda/2023a
module load mpi/openmpi-4.1.3

# Call your script as you would from the command line
mpirun python top5norm_SPMD.py
