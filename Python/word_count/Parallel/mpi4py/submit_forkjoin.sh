#!/bin/sh

# Slurm sbatch options
#SBATCH -o top5norm_forkjoin.log-%j
#SBATCH -n 14


# Initialize the module command first
source /etc/profile

# load MPI module
module load mpi/mpich-x86_64

# load anaconda module
module load anaconda3-5.0.1

# Call your script as you would from the command line
mpirun python top5norm_forkjoin.py


