import sys,os

# Read in the file of inputs
finputs = open(sys.argv[1],"r+")
inputs = finputs.readlines()

# The name of the executable we want to run
exec_name = '../../bin/fibonacci'

for input in inputs:
    cmd = './' + exec_name + ' ' + input
    os.system(cmd)
