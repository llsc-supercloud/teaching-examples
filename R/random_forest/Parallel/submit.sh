#!/bin/bash

echo "Run parallel code"
#Rscript rf_parallel.R >> Parallel_output1.txt #cores=2
#Rscript rf_parallel.R >> Parallel_output2.txt #cores=4
#Rscript rf_parallel.R >> Parallel_output3.txt #cores=8
#Rscript rf_parallel.R >> Parallel_output4.txt #cores=16
#Rscript rf_parallel.R >> Parallel_output5.txt #cores=32
#Rscript rf_parallel.R >> Parallel_output6.txt #cores=64
Rscript rf_parallel.R >> Parallel_output0.txt #cores=i 
