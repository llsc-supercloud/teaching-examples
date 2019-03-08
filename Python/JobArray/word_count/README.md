# Job Array Word Count
This directory contains an example of how to submit a Job Array.

There are a number of data files containing text. The goal is to get the top 5 words used in each file. The job array run the same operation in the script top5each.jl for each index 1-13 (the number of data files). The task ID for each task is used to determine which indices that task iterates over.

To run this example, execute one of the following two commands in this directory:

LLsub submit.sh
sbatch submit.sh

The file submit.sh is the submission script. It contains the SLURM arguments in the script. The -o argument indicates the name of the file where the output (the top 5 words) is written. The -a argument indicates which indices to create tasks for. In this example, 1-4 creates task IDs 1,2,3,4 and the Julia script determines which indices the task iterates over.
