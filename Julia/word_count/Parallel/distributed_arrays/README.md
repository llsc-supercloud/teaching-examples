# Parallel Word Count

This directory contains an example of how to submit a Parallel Job.

Please note that Engaging is available for MIT researchers.  This example was adapted with Engaging in mind, and so the instructions for compiling may be different for your system. Keep in mind that your system may use a different scheduler or may require additional Slurm options to submit effectively.

There are a number of data files containing text. The goal is to get the top 5 words by normalized count. (see the `Serial` directory for the serial version of this example).

This example splits up the set of books across all processes which then calculate their own raw word counts. These counts are gathered on process 0 (the root), who calculates the overall word count and sends that to the rest of the processes who then calculate the normalized count for the books assigned to them.

Before running this example you will first need to install the `ClusterManagers` and `DistributedArrays` packages. Be sure you are on a login node with the same operating system you are submitting jobs to (CentOS 7 vs Rocky 8). First load the Julia module (`module load julia`). Then start julia with the `julia` command and run:

```julia
import Pkg
Pkg.add("ClusterManagers")
Pkg.add("DistributedArrays")
```

To run this example, execute the following in this directory:

```bash
sbatch submit.sh
```

The file `submit.sh` is the submission script. It contains the SLURM arguments in the script. The options are:

- `-o`: indicates the name of the file where the output (the top 5 words) is written
- `-n`: indicates the number of cores or cpus allocated to the job

The cores will be added as workers by the lead process using the SlurmManager from the Julia `ClusterManager` package. In this way, cores that are allocated, despite residing on a different node, can be added as workers. This example requires both the `DistributedArrays` and `ClusterManagers` Julia packages.
