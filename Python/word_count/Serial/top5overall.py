import os
import sys
sys.path.append('../../')
from word_count_helpers import *

# Load the file names                                                                                                                                      
dataDir = "../../../data/word_count/"
fnames = os.listdir(dataDir)

allcounts = []
for fname in fnames:
    f = open(dataDir+fname, 'r', encoding='utf-8')
    text = cleantext(f.readlines())
    allcounts.append(countwords(text))

globalcounts = dict()
for counts in allcounts:
    globalcounts = { k: counts.get(k, 0) + globalcounts.get(k, 0) for k in set(counts) | set(globalcounts) }
    
top5 = sorted(globalcounts, key=globalcounts.get, reverse=True)[:5]
for k in top5:
    print("{}: {}".format(k, globalcounts[k]))
