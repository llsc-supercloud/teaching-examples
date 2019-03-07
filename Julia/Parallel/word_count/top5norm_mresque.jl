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

# Collect the distributed array onto the leader process
allcountsL = convert(Array,allcounts)

# Calculate the overall counts on the leader
overallcounts = getoverallcount(allcountsL)

# Calculate the normalized counts on the leader and print results
normcount = getnormcount.(allcountsL)
