# Compiling the parallel execution of Random Forest in R example :
___

This example shows the parallel execution of random forest in R. Working of random forest is same as in serial version, where various decision trees are created in parallel using multiple cores, which increases performance in the field of execution time.

Additional packages used are randomForest, foreach, caret and doParallel, which has parallelization built in their functions. 

| Package | Purpose |
| ------ | ------ |
| Foreach | It is true horsepower of parallel processing in R. Uses %dopar% to parallelize tasks and returns it at a list of results vectors. |
| doparallel | Provides parallel backend for %dopar% function. |
| randomForest | Builds a number of decision trees. Uses foreach and the combine function to get parallelization. |
| Caret | Provides framework to find optimal model by trying multiple models with resampling. |

By using registerDoParallel(cores = n) and getDoParWorkers() we can set the number of cores and run multiple times to get system time as done in the serial version of the code. 

Sys.time() gives the execution time of the program, hence we chose to run it multiple times and compared the execution time of serial and parallel execution. We observe that, parallel execution gives output in less time as compared to serial execution, as the work is divided into cores by processes.

# Submitting the Parallel R example :
___

We are submitting the R script rf_parallel1.R using shell script named submit.sh, which runs both serial and parallel executions in the same script.

Command used to run the R script is as follows :
    • First go the directory where the parallel R file is located.
    • Then run : Rscript rf_parallel1.R
Command to run the shell script to run both serial and parallel executions at once is as follows :
    • First go the directory where the parallel shell script is located.
    • Then submit batch job as : LLsub submit .sh