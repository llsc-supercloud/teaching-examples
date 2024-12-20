% basic parameter sweep code
%
% Want to parallelize the following loop:
% for ii = 1:n
%     z(ii) = f(ii, otherArgs...)
% end % for ii

% Set the path to the sample_function.m code
addpath('../')
	     
% Turn parallelism on or off. 
PARALLEL = 1;
tic;
% Set data sizes.
m = 3; % number of output arguments
n = 16; % number of independent iterations

% Create Maps.
map1 = 1;
if (PARALLEL)
    my_rank = Pid
    % Break up rows.
    map1 = map([Np 1], {}, 0:Np-1 );
end

% Create z - data output matrix.
z = zeros(n, m, map1);

% Get the local portion of the global indices
my_i_global = global_ind(z, 1);

% Get the local portion of the distributed matrix
my_z = local(z);

% Loop over the local indices
for i_local = 1:length(my_i_global)
    % Determine the global index for this (local) iteration
    i_global = my_i_global(i_local);
    
    % Calculate another argument
    my_other_arg = 2.5 * i_global;
    
    % call a function with the global index, and other arguments, and 
    % store the result in a local row
    my_z(i_local, :) = sample_function(i_global, my_rank, my_other_arg);
end % for i_local

% Store the local portion of z into the distributed matrix z
z = put_local(z, my_z);

% Finally, aggregate all of the output onto the leader process
z_final = agg(z);
toc;
% Finalize the pMATLAB program
disp('SUCCESS');

% Finally, display the resulting matrix on the leader
disp(z_final);
