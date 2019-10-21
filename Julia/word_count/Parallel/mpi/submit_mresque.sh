#!/bin/sh

# Slurm sbatch options
#SBATCH -o top5norm_mresque.log-%j
#SBATCH -n 4

#Initialize Modules
source /etc/profile

# Load Julia and MPI Modules
module load julia-latest
module load mpi/mpich-x86_64

# Call your script as you would from the command line
mpirun julia top5norm_mresque.jl
