# Job Array Word Count

This directory contains an example of how to submit a Job Array.

Please note that Engaging is available for MIT researchers.  This example was adapted with Engaging in mind, and so the instructions for compiling may be different for your system. Keep in mind that your system may use a different scheduler or may require additional Slurm options to submit effectively.

There are a number of data files containing text. The goal is to get the top 5 words used in each file. The job array run the same operation in the script `top5each.py` for each index 1-13 (the number of data files). The task ID for each task is used to determine which indices that task iterates over.

To run this example with `sbatch`, execute:

```bash
sbatch submit.sh
```

To execute on a specific partition, for example `mit_normal`, add this with the `-p` flag:

```bash
sbatch -p mit_normal submit.sh
```

The file `submit.sh` is the submission script. It contains the SLURM arguments in the script:

- `-o` indicates the name of the file where the output (the top 5 words) is written
- `-a` indicates which indices to create tasks for

In this example, 0-3 creates task IDs 0,1,2,3 and the Python script determines which indices the task iterates over. The environment variable `$SLURM_ARRAY_TASK_ID` is the task/process ID, and `$SLURM_ARRAY_TASK_COUNT` is the total number of processes/tasks (4 in this example).
