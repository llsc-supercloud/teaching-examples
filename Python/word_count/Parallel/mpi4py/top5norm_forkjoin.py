import os
import numpy as np
from mpi4py import MPI
import sys
sys.path.append('../../')
from word_count_helpers import *

comm = MPI.COMM_WORLD
size = comm.Get_size()
rank = comm.Get_rank()

name = MPI.Get_processor_name()
pid = os.getpid()

print("Hello World! I am process %d of %d on %s with pid %d.\n" % (rank, size, name, pid))

# Load the file names
dataDir = "../../../../data/word_count/"
fnames = os.listdir(dataDir)

idx = range(len(fnames))
myidx = idx[rank:len(idx):size]

my_allcounts = []
my_overall = dict()

for i in myidx:

    # Count the words in this file
    f = open(dataDir+fnames[i], 'r', encoding='utf-8')
    text = cleantext(f.readlines())
    counts = countwords(text)
    my_allcounts.append(counts)
   
    # Add word counts to local overall word count dict
    my_overall = {k: counts.get(k, 0) + my_overall.get(k, 0) for k in set(counts) | set(my_overall)}


# Everyone sends their overall word counts to rank 0
comm.Barrier()
all_counts = comm.gather(my_overall, root=0)
if rank == 0:
    
    # Get overall word count
    globalcounts = dict()
    for counts in all_counts:
        globalcounts = { k: counts.get(k, 0) + globalcounts.get(k, 0) for k in set(counts) | set(globalcounts) }
else:
    globalcounts = None
    
# Send global counts to workers
globalcounts = comm.bcast(globalcounts, root=0)
    

# Calculate normalized word count
for counts in my_allcounts:
    counts = { k:v for k, v in counts.items() if v > np.percentile(list(counts.values()),98) }
    normcounts = { k: counts.get(k, 0) / globalcounts.get(k, 0) for k in set(counts) & set(globalcounts) }
    top5 = sorted(normcounts, key=normcounts.get, reverse=True)[:5]
    str =''
    for k in top5:
        str=str + "%s: %s" % (k, normcounts[k]) + "; "
    print("Rank %s: " % (rank) + str[:-2])
