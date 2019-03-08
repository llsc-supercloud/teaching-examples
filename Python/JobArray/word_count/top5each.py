import os, sys
sys.path.append('../../')
from word_count_helpers import *

# Load the file names
dataDir = "../../../data/word_count/"
fnames = os.listdir(dataDir)

# Grab the arguments that are passed in
# This is the task id and number of tasks that can be used
# to determine which indices this process/task is assigned
my_task_id = int(sys.argv[1])
num_tasks = int(sys.argv[2])

# Assign indices to this process/task
my_fnames = fnames[my_task_id-1:len(fnames):num_tasks]

for fname in my_fnames:
    # Read in file and clean the text
    f = open(dataDir+fname, 'r', encoding='utf-8')
    text = cleantext(f.readlines())

    # Count number of times each word appears
    counts = countwords(text)

    # Sort and print the top 5 words with their counts
    top5 = sorted(counts, key=counts.get, reverse=True)[:5]
    str =''
    for k in top5:
        str=str + "%s: %s" % (k, counts[k]) + "; "
        
    print(str[:-2])
