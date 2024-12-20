#!/bin/bash

# Slurm sbatch options
#SBATCH -o top5norm_forkjoin.log-%j
#SBATCH -n 4

# Load Julia and MPI Modules
module load julia/1.7.3
module load mpi/openmpi-4.1.3

# Call your script as you would from the command line
mpirun julia top5norm_forkjoin.jl
