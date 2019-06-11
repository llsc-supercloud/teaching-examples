import os
import sys
sys.path.append('../../')
from word_count_helpers import *

# Load the file names
dataDir = "../../../data/word_count/"
fnames = os.listdir(dataDir)

# Iterate through file names
for fname in fnames:

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
