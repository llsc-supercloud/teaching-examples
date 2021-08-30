#!/bin/bash
#SBATCH --job-name pytorch
#SBATCH -o %j.log
#SBATCH -N 2
#SBATCH --tasks-per-node=2
#SBATCH --gres=gpu:volta:2

# Initialize the module command
source /etc/profile

# Load modules
module load anaconda/2021a
module load mpi/openmpi-4.0
module load cuda/10.1
module load nccl/2.5.6-cuda10.1

# These flags tell MPI how to set up communication
export MPI_FLAGS="--tag-output --bind-to socket -map-by core -mca btl ^openib -mca pml ob1 -x PSM2_GPUDIRECT=1 -x NCCL_NET_GDR_LEVEL=5 -x NCCL_P2P_LEVEL=5 -x NCCL_NET_GDR_READ=1"

# Set some environment variables needed by torch.distributed 
export MASTER_ADDR=$(hostname -s)
# Get unused port
export MASTER_PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')

echo "MASTER_ADDR : ${MASTER_ADDR}"
echo "MASTER_PORT : ${MASTER_PORT}"

# Do not use the torch.distributed.launch utility. Use mpirun as shown below
# to launch your code. The file torch_test.py has additional setup code needed to the
# distributed training capability 
mpirun ${MPI_FLAGS} python torch_test.py


