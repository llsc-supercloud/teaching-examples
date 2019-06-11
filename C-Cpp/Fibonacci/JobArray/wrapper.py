import sys,os

# Read in the file of inputs
finputs = open(sys.argv[1],"r+")
inputs = finputs.readlines()

# The name of the executable we want to run
exec_name = '../bin/fibonacci'

# Determine which inputs to run
if len(sys.argv) > 2: # if we pass in the task_id and number of tasks
    # This is the task id and number of tasks that can be used
    # to determine which indices this process/task is assigned
    my_task_id = int(sys.argv[2])
    num_tasks = int(sys.argv[3])

    # Assign indices to this process/task
    myinputs = inputs[my_task_id-1:len(inputs):num_tasks]
else:
    myinputs = inputs


for input in myinputs:
    cmd = './' + exec_name + ' ' + input
    os.system(cmd)
