# Load packages and helper functions
using MPI, Statistics
include("../parallelhelpers.jl")

# Call MPI.init() and 
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

# Gather all counts onto Process 0 and merge
if my_rank > 0
    # send to 0
    msg = MPI.serialize(mycounts)
    print("$my_rank: Sending mycounts $my_rank -> 0\n")
    sreq = MPI.Send(length(msg), 0, my_rank+n_procs, comm) # First send the length of the message
    sreq = MPI.Send(msg, 0, my_rank+(n_procs*2), comm) # Then send the message
else
    allcounts = Array{Array{UInt8,1},1}(undef,n_procs-1)
    for i = 1:n_procs-1
        # receive
        global allcounts
        msglen = Array{Int64,1}(undef,1)
        println("$my_rank: Waiting to receive length from $i")
        rreq = MPI.Recv!(msglen, i,  i+n_procs, comm) # First receive the length of the message
        allcounts[i] = Array{UInt8}(undef,msglen[1])
        println("$my_rank: Waiting to receive msg from $i")
        rreq = MPI.Recv!(allcounts[i], i,  i+(n_procs*2), comm) # Teh receive the message
        println("$my_rank: Received from $i")
    end
    allcounts = vcat(MPI.deserialize.(allcounts)...)
    overallcounts = merge(+,mycounts...,allcounts...)
end

# Now send the overall counts to all the other Processes
if my_rank == 0 
    msg = MPI.serialize(overallcounts)
    for i in 1:n_procs-1
        global msg
        print("$my_rank: Sending overallcounts $my_rank -> $i\n")
        sreq = MPI.Send(length(msg), i, i+(n_procs*3), comm) # First send the length of the message
        sreq = MPI.Send(msg, i, i+(n_procs*4), comm) # Then send the message
    end
else
    msglen = Array{Int64,1}(undef,1)
    println("$my_rank: Waiting to receive length from 0")
    rreq = MPI.Recv!(msglen, 0,  my_rank+(n_procs*3), comm)
    overallcounts = Array{UInt8}(undef,msglen[1])
    println("$my_rank: Waiting to receive msg from 0")
    rreq = MPI.Recv!(overallcounts, 0,  my_rank+(n_procs*4), comm)
    overallcounts = MPI.deserialize(overallcounts)
end

# Calculate the normalized counts
normcount = getnormcount.(mycounts,Ref(overallcounts))

# Print out the top 5 words for each file and their counts on the leader process
for i=1:length(normcount)
    top5 = sort(collect(normcount[i]), by=x->x[2], rev=true)[1:min(5,length(normcount[i])),:]
    println(top5)
end