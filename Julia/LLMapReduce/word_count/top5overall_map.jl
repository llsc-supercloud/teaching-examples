# Activate environment

include("../../word_count_helpers.jl")
using FileIO,JSON

# Grab the two arguments that are passed in
# The first is the input file name and the second is the output file name
#inputfile = ARGS[1]
#outputfile = ARGS[2]
inOutFileList = readlines(open(ARGS[1],"r+"))
print(inOutFileList)

# Read in file and clean the text
for line in inOutFileList
    inputfile = split(line)[1]
    outputfile = split(line)[2]

    # Read in file and clean the text
    f = open(inputfile)
    text=cleantext(readlines(f))

    # Count number of times each word appears
    wordCounts = countwords(text)

    # Save the word counts to the passed in output file name
    open(outputfile*".json","w") do f
    	JSON.print(f,wordCounts)
    end
end