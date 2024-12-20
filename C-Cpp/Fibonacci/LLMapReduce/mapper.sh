#!/bin/bash

echo 'My arg 1: ' $1
echo 'My arg 2: ' $2

# Call your script as you would from the command line, passing in $1 and $2 as arugments
# Note that $1 and $2 are the arguments passed into this script
../bin/fibonacci $1 > $2
