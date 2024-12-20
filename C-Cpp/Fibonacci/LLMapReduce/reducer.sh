#!/bin/bash

# Echo out the inputs
echo 'My arg 1: ' $1
echo 'My arg 2: ' $2

# Combine all intermediate files into one output file
cat $1/* > $2

# Remove Intermediate Files
#rm -r $1
