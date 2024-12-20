#!/bin/bash

module load miniforge
module load gcc/9.3.0
module load openmpi/4.0.5

python3 -m venv .venv_centos7
source .venv_centos7/bin/activate

pip install mpi4py
pip install numpy