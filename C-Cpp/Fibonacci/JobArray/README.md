# Submitting the Serial Fibonacci Example

This example intended to provide the learner with a brief introduction to submitting a Job Array. Job Arrays are an excellent option for throughput jobs, as it requires little to no editing of the underlying source code. In this example we create a wrapper script to iterate over a subset of inputs from a file, those subsets depending on inputs from the scheduler. The wrapper script provided is written in Python, but could be written in the language you are most comfortable with.

Please note that Engaging is available for MIT researchers.  This example was adapted with Engaging in mind, and so the instructions for compiling may be different for your system. We provide instructions for Slurm. Keep in mind that your system may use a different scheduler or may require additional Slurm options to submit effectively.

Note: You may see Job Array examples that are simpler than this without the wrapper script. These examples will usually create one task, or sub-job, per input and usually work okay for a small number of inputs. However, for a large number of inputs, particularly for short running jobs, this is heavy for the scheduler to manage, slowing down the scheduling process for everyone using the system, creates a lot of small files, which isn't great for the filesystem, and increases the amount of time your jobs take starting up. The wrapper provided allows you to process multiple inputs per task, which is lighter on the scheduler, better for the filesystem, and reduces overall startup time.

## Requirements

Running this code assumes you have:

1. A directory structure identical to this repository
    1. Input files in `../../../data/fibonacci/`
    2. Executable `fibonacci` in `../bin/`
2. Python to run the wrapper code (written for Python 3, should run with Python 2)

## Testing the Serial Code Interactively

Before you submit as a batch job, you may want to run the code interactively to make sure you are getting the result you expect. On Engaging you can run the following to get an interactive session:

```bash
salloc -p mit_normal
```

To run the wrapper code, first load the proper Anaconda module then run the wrapper, specifying the input file, task ID, and number of tasks:

```bash
module load miniforge
python wrapper.py ../../../data/fibonacci/inputFile_10 1 1
```

Feel free to try out different values for task ID and number of tasks. The code also runs with only the input file name as an argument.

## Submitting a Job Array

Since we have included the Slurm options we want in our submission script, we can call `sbatch` without any additional flags:

```bash
sbatch submit.sh
```

In the submission script, the `-o` argument indicates the name of the file where the output (the top 5 words) is written. The `-a` argument indicates which indices to create tasks for. In this example, 1-4 creates task IDs 1,2,3,4 and the Python script determines which indices the task iterates over.