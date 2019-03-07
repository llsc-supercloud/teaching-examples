# Parallel Word Count

This directory contains an example of how to submit a Parallel Job.

There are a number of data files containing text. The goal is to get the top 5 words by normalized count.

There are three programming schemes to calculate the normalized counts. The first uses a Fork-Join methodology, the second a Map-Reduce-like methodology, and the third a SPMD (Single Program Multiple Data) methodology. The code and respective submit scripts are:

To run this example, execute one of the following two commands in this directory (using the Fork-Join example):

LLsub submit_forkjoin.sh
sbatch submit_forkjoin.sh

The file submit_forkjoin.sh is the submission script. It contains the SLURM arguments in the script. The -o argument indicates the name of the file where the output (the top 5 words) is written. The -n arguement indicates the number of cores or cpus allocated to the job. The cores will be added as workers by the lead process using the SlurmManager from the Julia ClusterManager package. In this way, cores that are allocated, despite residing on a different node, can be added as workers. This example requires both the DistributedArrays and ClusterManagers Julia packages.
