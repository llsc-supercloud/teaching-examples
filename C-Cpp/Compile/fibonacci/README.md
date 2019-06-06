# Compiling the Fibonacci Example

This example intended to provide the learner with a brief introduction to compiling code at the command line, as well as provide the source code for the Fibonacci example. Often compiled languages must be compiled on the target operating system where the code will be run, and so code that you compile on your desktop may not run on a supercomputer or cluster.

Please note that the MIT Supercloud is available for researchers who are part of the Massachusetts Green High Performance Computing Center and/or are working in collaboration with MIT.  This example was created with the MIT Supercloud and Lincoln Laboratory Supercomputing Center (LLSC) in mind, and so the instructions for compiling may be different for your system.

## Compiling the Fibonacci Example
Compiling this example requires `gcc`. It was tested using gcc 7.1.1, but should compile with most versions of gcc. Since the source code is written in C++, we use the g++ command to compile:

```bash
g++ fibonacci.cpp -o ../../bin/fibonacci
```

This command compiles `fibonacci.cpp` and creates the executable `fibonacci` in the `../../bin` directory, specified by the `-o` option.