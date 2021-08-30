import os
import argparse
import socket
import torch
import torch.distributed as dist
from torch.multiprocessing import Process

# run() will be the training function
def run(rank, size, hostname):
    print(f"{hostname}: {rank} of {size}")
    # See this : https://pytorch.org/docs/stable/nn.html#torch.nn.parallel.DistributedDataParallel
    # your code will probably look like this -
    # model = DistributedDataParallel(model, device_ids=[rank%2], output_device=None)
    # Here device_ids=rank%2 because we launch two python processes per node.
    # (rank%2) assigns GPU 0 or 1 uniquely to each. This is the LOCAL rank of each process, whereas the
    # variable "rank" contains the GLOBAL rank which ranges from 0:(N-1). The LOCAL rank of each python
    # process is 0 or 1 and we use this to assign a unique GPU per process.
    # 
    return

def get_dist_env():
    if 'OMPI_COMM_WORLD_SIZE' in os.environ:
        world_size = int(os.getenv('OMPI_COMM_WORLD_SIZE'))
    else:
        world_size = int(os.getenv('SLURM_NTASKS'))

    if 'OMPI_COMM_WORLD_RANK' in os.environ:
        global_rank = int(os.getenv('OMPI_COMM_WORLD_RANK'))
    else:
        global_rank = int(os.getenv('SLURM_PROCID'))
    return global_rank, world_size

if __name__ == "__main__":
    # Dont change the following :
    global_rank, world_size = get_dist_env()
    
    hostname = socket.gethostname()

    # You have run dist.init_process_group to initialize the distributed environment
    # Always use NCCL as the backend. Gloo performance is pretty bad and MPI is currently
    # unsupported (for a number of reasons).     
    dist.init_process_group(backend='nccl', rank=global_rank, world_size=world_size)

    # now run your distributed training code
    run(global_rank, world_size, hostname)
    
    # following is just for demo purposes (and a sanity check)
    # you don't need this:
    if global_rank > 0 :
        print(f'printing NCCL variables on {global_rank} on {hostname}')
        for key in os.environ:
            if key.find('NCCL')>-1:
                print(f'{hostname} {key} : {os.getenv(key)}')
    
