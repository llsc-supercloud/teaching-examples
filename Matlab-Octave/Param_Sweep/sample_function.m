function [out] = sample_function(i_global, my_rank, my_other_arg);

out = zeros(1,3);

out(1) = i_global;
out(2) = my_rank;
out(3) = my_other_arg;