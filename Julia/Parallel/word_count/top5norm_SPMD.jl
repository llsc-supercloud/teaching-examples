# Activate environment

using ClusterManagers,Distributed

# Add in the cores allocated by the scheduler as workers
addprocs(SlurmManager(parse(Int,ENV["SLURM_NTASKS"])-1))
print("Added workers: ")
println(nworkers())

# Load required packages and helpers on all processes
@everywhere begin
    using DistributedArrays,Statistics
    include("parallelhelpers.jl")
end

# Load the file names
dataLoc = "../../../data/word_count/";
fnames = dataLoc.*readdir(dataLoc)

# Create a distributed array with the file names
dfnames = distribute(fnames)

# Calculate the word counts
# Broadcast over a distributed array automatically does the operation on the correct worker
allcounts =  getcounts.(dfnames)

# Collect the distributed array onto the leader process and share with workers
allcountsL = convert(Array,allcounts)
@everywhere allcountsL=$allcountsL

# Calculate the overall counts on each woker
@everywhere overallcounts = getoverallcount(allcountsL)

# Calculate the normalized counts on each worker
normcount = getnormcount.(allcounts)

# Print out the top 5 words for each file and their counts on the leader process
for i=1:length(normcount)
    println(sort(collect(normcount[i]), by=x->x[2], rev=true)[1:min(5,length(normcount[i])),:])
end
