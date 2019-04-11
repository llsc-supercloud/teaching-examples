# Teaching Examples

This repository contains several examples for learning how to write scalable code in various languages and how to submit that code on an HPC System. These examples were written with the MIT Supercloud and Lincoln Laboratory Supercomputing Center (LLSC) in mind, however they may be relevant to other HPC Systems.

The MIT Supercloud and LLSC use Slurm as a scheduler, and so submission scripts and instructions in these examples use Slurm. If you are intending to use these on another system you may need to add additional submission flags or submit them differently. Please refer to the documentation for your system and adjust accordingly.

We have organized these examples first by language, then by type (serial, throughput/job array, map reduce, fully parallel), and finally by example problem. Data used by multiple examples sits in the top level directory, and other supporting scripts used by multiple examples resides at the Language level. The paths in the examples reflect this directory structure.

To run the examples you have a few options:
1. **MIT Supercloud and LLSC Only**: Copy these examples to your home directory from the shared location (ask the Supercloud or LLSC team for the path)
    1. Log into the system (ssh or Jupyter)
    2. If using Jupyter, open a terminal window
    3. Run: `cp -r ~/path/to/shared/examples/teaching-examples ~`
1. **Any system with git installed**: Use git clone to clone the repository onto the system where you want to run the examples
    3. In a terminal window, log into the system where you want the examples (on MIT Supercloud you must be on the login node)
    4. Run: `git clone https://github.com/llsc-supercloud/teaching-examples.git`
1. **Any system:** Download the repository and transfer:
    1. Click the "Clone and Download" button on the top right
    2. Click "Download Zip"
    3. Transfer the zipped repo to the system you are working on (refer to the documentation for your system for instructions on how to do this)
    4. Log into your system (ssh or Jupyter on MIT Supercloud or LLSC)
    5. Unzip your examples: `unzip teaching-examples-master.zip`
