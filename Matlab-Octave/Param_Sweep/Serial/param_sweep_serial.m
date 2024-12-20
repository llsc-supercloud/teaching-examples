% basic parameter sweep code (serial)

% Set the path to the sample_function.m code
addpath('../')

% Set data sizes.
m = 3; % number of output arguments
n = 16; % number of independent iterations

% Create z %G–%@ data output matrix.
z = zeros(n, m);

% Loop over the local indices	
for ii = 1:size(z, 1)
   % Calculate another argument
   my_other_arg = 2.5 * ii;

   % call a function with the index, and other arguments, and 
   % store the result in a row
   z(ii, :) = sample_function(ii, 0, my_other_arg);
end % for ii

% Finalize the pMATLAB program
disp('SUCCESS');

% Finally, display the resulting matrix on the leader
disp(z);
