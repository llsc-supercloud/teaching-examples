# LLMapReduce Fibonacci

This directory contains an example of how use LLMapReduce to run a C++ executable on multiple inputs. These inputs listed in a file, one input per line.

Please note that the MIT Supercloud is available for researchers who are part of the Massachusetts Green High Performance Computing Center and/or are working in collaboration with MIT.  This example uses the LLMapReduce command, which is available on the MIT Supercloud and Lincoln Laboratory Supercomputing Center (LLSC) systems.

This example computes the fibonacci sequence on a number of different inputs using a single input file. This is done in two steps:

1. The mapper calls the fibonacci executable on each line in the file and ouputs the result to a file.
2. The reducer combines the intermediate files into one file and then deletes the intermediate files.

To run LLMapReduce you specify:
- The mapper: (--mapper mapper.sh) a shell script calling the function/scrip that is be mapped over the inputs. In this case the fibonacci executable is called on each line of the input file
- The reducer: (--reducer reducer.sh) a shell script reduce the output of the map step. In this case we are combining the intermediate text files from the map step into one file.
- The input: (--input ../../../data/fibonacci/inputFile_10) the path to the input file or directory. In this case it is a file, the list of input numbers.
- The output directory: (--output fib_intermediate) the path to the directory where the mapper should write its output files.
- The number of processes: (--np 4) the number of concurrent mapper processes that should be running. Should be less than or equal to the number of inputs (here that's less than the number of lines in the file).

In this case our executable only takes in a single input number. You can also write your application so that it can take in a file name containing a list of inputs and outputs. In this case you can add the `--apptype mimo` option. This reduces the overhead of starting new map executables when the number of inputs is large.

The command to run this example is:

```bash
LLMapReduce --mapper mapper.sh --reducer reducer.sh --input ../../../data/fibonacci/inputFile_10 --output fib_intermediate --np=4
```

or

```bash
LLMapReduce --mapper mapper.sh --reducer reducer.sh --input ../../../data/fibonacci/inputFile_100 --output fib_intermediate --np=4
```

or

```bash
LLMapReduce --mapper mapper.sh --reducer reducer.sh --input ../../../data/fibonacci/inputFile_200 --output fib_intermediate --np=4
```

If you would like to keep the log files, add the option `--keep=true`. The log files will be in MAPRED.#####/logs.

