# MPI.jl Parallel Word Count

This directory contains an example of how to submit a Julia MPI Parallel Job.

Please note that Engaging is available for MIT researchers.  This example was adapted with Engaging in mind, and so the instructions for compiling may be different for your system. Keep in mind that your system may use a different scheduler or may require additional Slurm options to submit effectively.

There are a number of data files containing text. The goal is to get the top 5 words by normalized count (see the `Serial` directory for the serial version of this example).

This example splits up the set of books across all processes which then calculate their own raw word counts. These counts are gathered on process 0 (the root), who calculates the overall word count and sends that to the rest of the processes who then calculate the normalized count for the books assigned to them. There is an additional script which only uses Send/Recieves (files ending with `sendrecv`)

This example uses the `MPI.jl` Julia package. To install the MPI.jl package you must first have access to an MPI installation. On Engaging this can be done by loading an MPI module before you add the MPI.jl package.

To run this example, execute one of the following two commands in this directory (using the Fork-Join example):

```bash
sbatch submit.sh
```

The file `submit.sh` is the submission script. It contains the SLURM arguments in the script. The options are:

- `-o`: indicates the name of the file where the output (the top 5 words) is written
- `-n`: indicates the number of processes in the job, by default each will get one core/CPU

In this example you do not want to have more than 13 tasks/processes, which is the number of files. If you ask for more you will get an error.
