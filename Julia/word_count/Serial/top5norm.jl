using Statistics

# Read in file of helper functions
# This file incluse: cleantext, countwords
include("../word_count_helpers.jl")

# Load the file names
dataLoc = "../../../data/word_count/";
fnames = dataLoc.*readdir(dataLoc)

# Create function for processing each file
function getwordcounts(fname)
    # Read in file and clean the text
    f = open(fname)
    text=cleantext(readlines(f))

    # Count number of times each word appears
    return countwords(text)
end

# Find word counts for all books
allcounts = getwordcounts.(fnames)

# Get overall counts for each word
overallcounts = merge(+,allcounts...)

# Iterate through each set of word counts
for counts in allcounts

    # Calculate normalized score
    thresh = quantile(collect(values(counts)), .98)
    counts = filter!(word-> word.second > thresh, counts)
    normscore = merge(/,counts,filter(word->haskey(counts,word.first), overallcounts))

    # Sort and print the top 5 words with their normalized counts
    rankedwords = sort(collect(normscore), by=x->x[2], rev=true)
    println(rankedwords[1:min(5,length(counts)),:])
end
