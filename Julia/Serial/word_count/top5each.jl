# Read in file of helper functions
# This file incluse: cleantext, countwords
include("../../word_count_helpers.jl")

# Load the file names
dataLoc = "../../../data/word_count/";
fnames = dataLoc.*readdir(dataLoc)

# Iterate through file names
for fname in fnames
    
    # Read in file and clean the text
    f = open(fname)
    text = readlines(f)
    text = cleantext(text)

    # Count number of times each word appears
    wordCounts = countwords(text)

    # Sort and print the top 5 words with their counts
    rankedwords = sort(collect(wordCounts), by=x->x[2], rev=true)
    println(rankedwords[1:5,:])
    
end
