# Job Array Word Count

This directory contains an example of how to submit a Job Array.

Please note that the MIT Supercloud is available for researchers who are part of the Massachusetts Green High Performance Computing Center and/or are working in collaboration with MIT.  This example was created with the MIT Supercloud and Lincoln Laboratory Supercomputing Center (LLSC) in mind, and so the instructions for submission may be different for your system. We provide instructions for both LLSC specific commands and for Slurm. Keep in mind that your system may use a different scheduler or may require additional Slurm options to submit effectively.

There are a number of data files containing text. The goal is to get the top 5 words used in each file. The job array run the same operation in the script `top5each.py` for each index 1-13 (the number of data files). The task ID for each task is used to determine which indices that task iterates over.

This directory shows two ways to submit this job, using LLsub with triples mode and using sbatch. LLsub is available on Supercloud and LLSC Systems, whereas sbatch is available on any system that uses the SLURM scheduler. The same Python script can be used for each submission type, only the names of the environment variables that you pass into it in the submission scripts need to change.

To run this example with LLsub triples on one node, 4 processes per node, and 1 thread per process, execute:

```bash
LLsub ./submit_LLsub.sh [1,4,1]
```

The file `submit_LLsub.sh` is the submission script for LLsub with triples. A triple is expressed as `[Nodes,NPPN,NThreads]`, where

- `Nodes` is number of compute nodes
- `NPPN` is number of processes per node
- `NThreads` is number of threads per process (default is 1)

In this example, [1,4,1] creates 4 processes on one node with IDs 0,1,2,3 and the Python script determines which indices the process iterates over. The environment variable `$LLSUB_RANK` is the rank, or process ID (the equivalent of Task ID in Slurm Job Array terminology), and `$LLSUB_SIZE` is the total number of processes (4 in this example).

To run this example with sbatch, execute:

```bash
sbatch submit.sh
```

The file `submit.sh` is the submission script for sbatch. It contains the SLURM arguments in the script:

- `-o` indicates the name of the file where the output (the top 5 words) is written
- `-a` indicates which indices to create tasks for

In this example, 0-3 creates task IDs 0,1,2,3 and the Python script determines which indices the task iterates over. The environment variable `$SLURM_ARRAY_TASK_ID` is the task/process ID, and `$SLURM_ARRAY_TASK_COUNT` is the total number of processes/tasks (4 in this example).