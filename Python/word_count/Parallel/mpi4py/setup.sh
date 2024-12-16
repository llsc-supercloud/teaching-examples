#!/bin/bash

module load miniforge
module load openmpi

python3 -m venv .venv
source .venv/bin/activate

pip install mpi4py
pip install numpy