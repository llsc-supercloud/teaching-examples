# Parallel Word Count

This directory contains an example of how to submit a Parallel Job.

There are a number of data files containing text. The goal is to get the top 5 words by normalized count (see the `Serial` directory for the serial version of this example).

This example uses mpi4py to split up the problem. It starts by splitting up the set of books across all processes which then calculate their own word counts. In the first these counts are gathered on process 0 (the root), who calculates the overall word count and sends that to the rest of the processes who then calculate the normalized count for the books assigned to them.

To run this example you will first need to install mpi4py. The easiest way to do this is to run one of the two setup scripts, which will create python virtual environments to use for these examples. Run:

```bash
bash setup.sh
```

(If you are planning to use CentOS 7 nodes run the `setup_centos7.sh` script instead)

Once you have installed mpi4py, to run the example execute the following command in this directory:

```bash
sbatch -p mit_normal submit.sh
```

The file `submit.sh` is the submission script. It contains the SLURM arguments in the script. The options are:

- `-o`: indicates the name of the file where the output (the top 5 words) is written
- `-n`: indicates the number of cores or cpus allocated to the job

If you are planning to use CentOS 7 instead run:

```bash
sbatch submit_centos7.sh
```
