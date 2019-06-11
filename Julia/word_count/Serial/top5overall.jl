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

# Get counts for each book
allcounts = getwordcounts.(fnames)

# Calculate the overall word counts
overallcounts = merge(+,allcounts...)

# Sort and print the top 5 words with their counts
println(sort(collect(overallcounts), by=x->x[2], rev=true)[1:5,:])
