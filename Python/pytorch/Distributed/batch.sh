#!/bin/bash
#SBATCH --job-name pytorch
#SBATCH -o %j.log
#SBATCH -N 2
#SBATCH --ntasks-per-node=2
#SBATCH --gres=gpu:volta:2
#SBATCH --distribution=nopack

# Load modules
source /etc/profile
module load anaconda/2023a
module load mpi/openmpi-4.1.5
module load cuda/11.6
module load nccl/2.11.4-cuda11.6

# These flags tell MPI how to set up communication
export MPI_FLAGS="--tag-output --bind-to socket -map-by core -x PSM2_GPUDIRECT=1 -x NCCL_NET_GDR_LEVEL=5 -x NCCL_P2P_LEVEL=5 -x NCCL_NET_GDR_READ=1"

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


