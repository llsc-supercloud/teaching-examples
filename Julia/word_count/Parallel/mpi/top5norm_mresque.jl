# Load packages and helper functions
using MPI, Statistics
include("../parallelhelpers.jl")

MPI.Init()
comm = MPI.COMM_WORLD
my_rank = MPI.Comm_rank(comm)
n_procs = MPI.Comm_size(comm)
root = 0

# Load the file names
dataLoc = "../../../../data/word_count/";
fnames = dataLoc.*readdir(dataLoc)

# Distribute filenames by rank
myfnames = fnames[my_rank+1:n_procs:length(fnames)]

# Calculate the word counts
mycounts =  getcounts.(myfnames)

# Gather all counts onto Process 0

# First we have to serialize the counts so we can send it
msg = MPI.serialize(mycounts)

# Since each msg size is different we have to get the length of each one
counts = Int32.(MPI.Allgather(length(msg),comm))

# Then we can gather on process 0 (root)
res = MPI.Gatherv(msg, counts, root, comm)

# And finish the computation on process 0
if my_rank == 0
    
    # Deserialize the counts
    idx = [0; cumsum(counts)]
    res = [res[idx[i]+1:idx[i+1]] for i in 1:length(idx)-1]
    allcounts = vcat(MPI.deserialize.(res)...)
    
    # Merge them to find the overall counts
    overallcounts = merge(+,allcounts...)
    
    # Calculate the normalized counts
    normcount = getnormcount.(allcounts,Ref(overallcounts))
    
    # Print out the top 5 words for each file and their counts
    for i=1:length(normcount)
        top5 = sort(collect(normcount[i]), by=x->x[2], rev=true)[1:min(5,length(normcount[i])),:]
        println(top5)
    end
end


