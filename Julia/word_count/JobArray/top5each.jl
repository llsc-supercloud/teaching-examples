# Read in file of helper functions
# This file includes: cleantext, countwords
include("../word_count_helpers.jl")

# Load the file names
dataLoc = "../../../data/word_count/";
fnames = dataLoc.*readdir(dataLoc)

# Grab the argument that is passed in
# This is the index into fnames for this process
task_id = parse(Int,ARGS[1])
num_tasks = parse(Int,ARGS[2])

# Check to see if the index is valid (so the program exits cleanly if the wrong indices are passed)
for i in task_id+1:num_tasks:length(fnames)

    # Read in file and clean the text
    f = open(fnames[i])
    text=cleantext(readlines(f))

    # Count number of times each word appears
    wordCounts = countwords(text)

    # Sort and print the top 5 words with their counts
    rankedwords = sort(collect(wordCounts), by=x->x[2], rev=true)
    println(rankedwords[1:5,:])
    
end
