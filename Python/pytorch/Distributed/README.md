# Pytorch DistributedDataParallel

This directory contains a simple "Hello World" level example for using DistributedDataParallel. The purpose of this example is to demonstrate how to properly submit a Pytorch DistributedDataParallel job on SuperCloud and other similar systems. This example can be used as a starting point for your own code.

The code and respective submit scripts are:

```bash
torch_test.py; batch.sh
```

To run this example, execute one of the following two commands in this directory:

```bash
LLsub batch.sh
sbatch batch.sh
```

The rest of this README explains these scripts in detail.

## The Submission Script

The file `batch.sh` is the submission script. It contains the SLURM arguments in the script. The options are:

- `--job-name`: the name of the job as displayed in `LLstat` or `squeue`
- `-o`: indicates the name of the file where the output is written
- `-N`: the number of nodes for the job, here we pick 2 to show the job is truly distributed and communicating across nodes
- `--tasks-per-node`: the number of tasks/processes/ranks per node, by default each task is allocated a single core
- `--gres=gpu:volta:2`: the type (volta) and number (2) of GPUs for the job, this is a per-node number, in this example you would get 2 GPUs per node
- `-c` or `--cpus-per-task`: this is not included in this script, but should be used if you are doing any sort of real training, as Pytorch is multithreaded and will take advantage additional cores. For Xeon-G6 GPU nodes a good number would be 20. You will also have to tell Pytorch you have allocated these cores by setting the `OMP_NUM_THREADS` environment variable in your submission script or `torch.set_num_threads()` in your Python script.

Other flags that may be needed on other LLSC systems:

- `-p`: the partition name, you may need to select a partition that has GPUs (on SuperCloud this is selected for you based on the `--gres` flag)
- `--constraint`: the CPU or node type, you may need to select a node that has GPUs (on SuperCloud this is selected for you based on the `--gres` flag)

The next portion of the script loads modules. In this example `mpirun` is used as a convenient launch mechanism to set up the processes, while NCCL is used by Pytorch for communication. Pytorch is available through the system anaconda installation, and Cuda is needed to use the GPUs:

```bash
module load anaconda/2021a
module load mpi/openmpi-4.0
module load cuda/10.1
module load nccl/2.5.6-cuda10.1
```

Before launching the code some environment variables are set for Pytorch to get the hostname and a free port for the leader process and to tell MPI how to set up communication.

Finally the code is run with:

```bash
mpirun ${MPI_FLAGS} python torch_test.py
```

## The Python Script

The `torch_test.py` script has comments throughout that explain what is going on fairly well. Here we summarize the overall structure of the example.

The Python script has two functions and a main block. The first function, `run()`, is a placeholder for a distributed training function. Since this is a Hello World example, it prints the hostname of the process along with its rank and size. There are some additional comments in this function to point you in the right direction for what to in this place. The second function, `get_dist_env()`, gets the rank and world size, needed from MPI and/or Slurm for Pytorch Distributed to set itself up.

The first three lines of the main block should not be changed. These set up Pytorch's Distributed environment by calling `get_dist_env()` and running `init_process_group()`. After this the example calls `run()`, which you can replace with your distributed training code. For demonstration and debugging purposes we follow that with printing the NCCL variables.
