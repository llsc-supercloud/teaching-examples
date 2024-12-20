# MPI.jl Parallel Word Count

This directory contains an example of how to submit a Julia MPI Parallel Job.

Please note that the MIT Supercloud is available for researchers who are part of the Massachusetts Green High Performance Computing Center and/or are working in collaboration with MIT.  This example was created with the MIT Supercloud and Lincoln Laboratory Supercomputing Center (LLSC) in mind, and so the instructions for submission may be different for your system. We provide instructions for both LLSC specific commands and for Slurm. Keep in mind that your system may use a different scheduler or may require additional Slurm options to submit effectively.

There are a number of data files containing text. The goal is to get the top 5 words by normalized count (see the `Serial` directory for the serial version of this example).

There are three programming schemes to calculate the normalized counts. All three split up the set of books across all processes which then calculate their own raw word counts. In the first these counts are gathered on process 0 (the root), who calculates the overall word count and sends that to the rest of the processes who then calculate the normalized count for the books assigned to them, we refer to this as "Fork-Join" (files ending with forkjoin). The second is similar to the first, but process 0 never sends the overall counts and computes the normalized counts itself, we refer to this as Map-Reduce-like (files ending with mresque). In the final example, which is referred to as "All-To-All" (single program multiple data), the original word counts are sent to all processes using an all-to-all communication (an allgather). Then each process computes its own overall word count and normalized word scores for its set of books. There is an additional script similar to "Fork-Join" which only uses Send/Recieves (files ending with "forkjoin_sendrecv")

This example uses the MPI.jl Julia package. To install the MPI.jl package you must first have access to an MPI istallation. On Supercloud this can be done by loading an MPI module before you add the MPI.jl package.

The code and respective submit scripts are:

```bash
top5norm_forkjoin.jl; submit_forkjoin.sh
top5norm_forkjoin_sendrecv.jl; submit_forkjoin_sendrecv.sh
top5norm_MapReduce.jl; submit_MapReduce.sh
top5norm_alltoall.jl; submit_alltoall.sh
```

To run this example, execute one of the following two commands in this directory (using the Fork-Join example):

```bash
LLsub submit_forkjoin.sh
sbatch submit_forkjoin.sh
```

The file `submit_forkjoin.sh` is the submission script. It contains the SLURM arguments in the script. The options are:

- `-o`: indicates the name of the file where the output (the top 5 words) is written
- `-n`: indicates the number of processes in the job, by default each will get one core/CPU

In this example you do not want to have more than 13 tasks/processes, which is the number of files. If you ask for more you will get an error.
