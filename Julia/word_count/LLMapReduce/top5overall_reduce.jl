# Activate environment

using FileIO,JSON

# Grab the two arguments that are passed in
# The first is the directory containing the output of the mapper
# The second is the name of the file where the final word counts should be saved
inputdir = ARGS[1]
outputfile = ARGS[2]

# Read in the first word count file
fnames = readdir(inputdir)
allcounts = JSON.parsefile.(inputdir*"/".*fnames)

globalcounts = merge(+,allcounts...)

# Sort and print the top 5 words with their counts
globalranks = sort(collect(globalcounts), by=x->x[2], rev=true)
println(globalranks[1:5,:])

# Save to the output file
output = join([k*","*string(v) for (k,v) in globalranks[1:5,:]],'\n')*"\n"
write(outputfile*".csv",output)
