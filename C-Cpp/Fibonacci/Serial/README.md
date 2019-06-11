# Submitting the Serial Fibonacci Example

This example intended to provide the learner with a brief introduction to submitting a simple, serial compiled code using a scheduler. We provide two examples: submitting by calling the fibonacci executable directly on a single input, and submitting a wrapper that reads in a file of inputs. This is for the case where you want to run an executable on multiple input parameters in turn, but either do not have the source code or do not want to edit the source code. The wrapper script provided is written in Python, but could be written in the language you are most comfortable with, it could even be incorporated in the submission script if you are comfortable with bash scripting.

Please note that the MIT Supercloud is available for researchers who are part of the Massachusetts Green High Performance Computing Center and/or are working in collaboration with MIT.  This example was created with the MIT Supercloud and Lincoln Laboratory Supercomputing Center (LLSC) in mind, and so the instructions for submission may be different for your system. We provide instructions for both LLSC specific commands and for Slurm. Keep in mind that your system may use a different scheduler or may require additional Slurm options to submit effectively.

## Requirements

Running this code assumes you have:

1. A directory structure identical to this repository
    1. Input files in `../../../data/fibonacci/`
    2. Executable `fibonacci` in `../bin/`
2. Python to run the wrapper code (written for Python 3, should run with Python 2)

## Testing the Serial Code Interactively

Before you submit as a batch job, you may want to run the code interactively to make sure you are getting the result you expect. On the MIT Supercloud you can run the following to get an interactive session:

```bash
LLsub -i
```

The equivalent in Slurm is roughly:

```bash
salloc --immediate=60 srun --pty bash -i
```

The `LLsub` command also contains MIT Supercloud-specific options for partition (`-p`), CPU-type (`--constraint`), and qos (`--qos`).

Once you have started your interactive session you can test a single input fibonacci example (here we are using the input 5):

```bash
../../bin/fibonacci 5
```

To run on multiple inputs using the wrapper code, first load the proper Anaconda module then run the wrapper, specifying the input file:

```bash
module load anaconda3-2019a
python wrapper.py ../../../data/fibonacci/inputFile_10
```

## Submitting a Batch Job

To submit as a batch job you can use `LLsub` on the MIT Supercloud or LLSC:

```bash
LLsub submit_num.sh
LLsub submit_file.sh
```

Or, on any Slurm system, the equivalent would be `sbatch` with the `-o` option:

```bash
sbatch -o submit_num.sh.log-%j submit_num.sh
sbatch -o submit_file.sh.log-%j submit_file.sh
```