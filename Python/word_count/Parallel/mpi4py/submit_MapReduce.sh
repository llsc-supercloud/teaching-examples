#!/bin/bash

# Slurm sbatch options
#SBATCH -o top5norm_MapReduce.log-%j
#SBATCH -n 14

# Initialize the module command first
source /etc/profile

# Load Anaconda and MPI module
module load anaconda/2020a
module load mpi/openmpi-4.0

# Call your script as you would from the command line
mpirun python top5norm_MapReduce.py
