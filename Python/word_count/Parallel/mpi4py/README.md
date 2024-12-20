# Parallel Word Count

This directory contains an example of how to submit a Parallel Job.

There are a number of data files containing text. The goal is to get the top 5 words by normalized count (see the `Serial` directory for the serial version of this example).

There are three programming schemes to calculate the normalized counts. All three split up the set of books across all processes which then calculate their own raw word counts. In the first these counts are gathered on process 0 (the root), who calculates the overall word count and sends that to the rest of the processes who then calculate the normalized count for the books assigned to them, we refer to this as "Fork-Join" (files ending with forkjoin). The second is similar to the first, but process 0 never sends the overall counts and computes the normalized counts itself, we refer to this as Map-Reduce-like (files ending with mresque). In the final example, which is referred to as SPMD (single program multiple data), the original word counts are sent to all processes using an all-to-all communication (an allgather). Then each process computes its own overall word count and normalized word scores for its set of books.

The code and respective submit scripts are:

```bash
top5norm_forkjoin.py; submit_forkjoin.sh
top5norm_MapReduce.py; submit_MapReduce.sh
top5norm_SPMD.py; submit_SPMD.py
```

To run this example, execute one of the following two commands in this directory (using the Fork-Join example):

```bash
LLsub submit_forkjoin.sh
sbatch submit_forkjoin.sh
```

The file `submit_forkjoin.sh` is the submission script. It contains the SLURM arguments in the script. The options are:

- `-o`: indicates the name of the file where the output (the top 5 words) is written
- `-n`: indicates the number of cores or cpus allocated to the job
