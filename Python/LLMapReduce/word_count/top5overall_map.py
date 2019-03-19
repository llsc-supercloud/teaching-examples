import os, sys, json
sys.path.append('../../')
from word_count_helpers import *

inOutFileList = open(sys.argv[1],"r+")

for line in inOutFileList.readlines():

    # Get input and output file names for this iteration
    (inFile,outFile) = line.split()
    print("Reading from " + inFile + " and writing to " + outFile)

    # Read in file and clean the text
    infid  = open(inFile,"r+", encoding='utf-8')
    text = cleantext(infid.readlines())

    # Count number of times each word appears
    wordCounts =countwords(text)

    # Save the word counts to the passed in output file name 
    with open(outFile+'.json', 'w') as fp:
        json.dump(wordCounts, fp)
