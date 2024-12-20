# Serial Word Count

This example shows how to submit a simple serial job that does not require any special resources beyond a single core and about 4GB of memory.

Please note that Engaging is available for MIT researchers.  This example was adapted with Engaging in mind, and so the instructions for compiling may be different for your system. Keep in mind that your system may use a different scheduler or may require additional Slurm options to submit effectively.

This directory contains the serial version of several word count examples of varying complexity. The purpose is to provide baseline examples for different methods of submitting jobs and parallelizing code.

The three examples are:
    1. Basic word count and rank: What are the top 5 words in each file?
    2. Global/Overall word count and rank: What are the top 5 words in the entire corpus?
    3. Normalized word count and rank: What are the top 5 words in each file, normalized by the global counts?

The .sh files will submit a batch job to one process that iterates through each of the input files, rather than executing any step in parallel. Each of the three examples are done serially. It is good practice to make sure your code runs in serial on this system before attempting to run anything in parallel.

To run on Engaging, submit with:

```bash
sbatch submit_each.sh
sbatch submit_overall.sh
sbatch submit_norm.sh
```

