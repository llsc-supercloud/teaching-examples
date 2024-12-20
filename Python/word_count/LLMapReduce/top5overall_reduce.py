import os, sys, json, csv
sys.path.append('../')
from word_count_helpers import *

# Grab the two arguments that are passed in
# The first is the directory containing the output of the mapper
# The second is the name of the file where the final word counts should be saved
inputdir = sys.argv[1]
outputfile = sys.argv[2]

# Read in the first word count file
fnames = os.listdir(inputdir)
with open(inputdir+"/"+fnames[1], 'r') as fp:
    globalranks = json.load(fp)

# Merge the counts from all files
globalcounts = dict()
for fname in fnames:
    with open(inputdir+"/"+fname, 'r') as fp:
        counts = json.load(fp)
    globalcounts = { k: counts.get(k, 0) + globalcounts.get(k, 0) for k in set(counts) | set(globalcounts) }
    
# Sort and print the top 5 words with their counts
top5 = sorted(globalcounts, key=globalcounts.get, reverse=True)[:5]
for k in top5:
    print("{}: {}".format(k, globalcounts[k]))

# Save to the output file
with open(outputfile+'.csv', 'w') as output_file:
    csv.writer(output_file).writerows({k: globalcounts[k] for k in top5}.items())
