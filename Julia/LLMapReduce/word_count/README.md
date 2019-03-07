# LLMapReduce Word Count

This directory contains an example of how to submit an LLMapReduce job using mimo (multiple input multiple output).

There are a number of data files containing text. The goal is to get the top 5 words in the entire text corpus. In this case, you specify four options to run LLMapReduce: the mapper (a shell script calling the function/script that is being mapped over the input files, in this case counting the number of words in each file), a reducer (a shell script calling the function/script that iterates through the results of the mapper, and in this case sums the word counts to get a global word count), a direcotry that contains the input files, a directory to write out the result of the mapper, and the number of concurrent processes for the mapper.

The mimo option will create np map processes and split the workload amongst those processes, with each process working on multiple files. This reduces the overhead of starting new map processes when the number of files is large.

The command to run this example is:

LLMapReduce --mapper mapper.sh --reducer reducer.sh --input ../../../data/word_count/ --output counts --apptype=mimo --np=4

If you would like to keep the output and intermeidate files, add the option --keep=true.

In this example, mapper.sh is the shell script calling the script that is being mapped over the input files (top5overall_map.jl). The script reducer.sh is the shell script that calls the reducer (top5overall_reduce.jl). The directory ../../../data/word_count/ is the directory of input files, and counts is the output directory for the mapper.

