#!/bin/sh

# Initialize Modules
source /etc/profile

# Load Julia Module
module load julia-1.0

# Call your script as you would from the command line
julia top5each.jl
