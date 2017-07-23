function[Pos] =  OffFindPos(vector)

%OffFindPos translates the vector of angles to the  positions into the lattice.


% INPUTS
% vector: Sequence of residues ( (H)ydrophobic or (P)olar, respectively represented by zero and one)


% OUTPUTS
% Pos: Matrix of positions Pos(sizechain,2) calculated from the angles

sizeChain = size(vector,2);
Pos = zeros(sizeChain,2);

Pos(1,1) = 0;  %Position for the initial molecule 
Pos(1,2) = 0;
 
Pos(2,1) = 1;  %Position for the second molecule 
Pos(2,2) = 0;

for i=3:sizeChain
 Pos(i,1) = Pos(i-1,1)+cos(vector(i));
 Pos(i,2) = Pos(i-1,2)+sin(vector(i));
end

%sol1 = [1.553335e-001 6.150657e+000 4.425148e+000 4.760213e-002 5.986690e+000 1.193417e+000 2.739953e+000 1.168770e+000 3.132109e+000 1.326418e+000 2.391033e-001 1.175209e+000 3.009217e+000 1.476943e+000 2.263935e-003 3.641778e-001 4.693403e+000 2.159132e-001 2.738250e-001 1.293043e+000 3.107070e+000 
%]
%sol2 = [6.280128e+000 8.993728e-003 1.791911e+000 6.114974e+000 1.327735e+000 6.072794e+000 4.595686e+000 4.953036e+000 3.010987e+000 4.817423e+000 4.858861e+000 5.898593e+000 1.416969e+000 6.661956e-001 3.370680e-001 2.133721e+000 1.836168e-001 5.703042e-001 5.349405e+000 3.854111e+000 5.640157e+000 
%];
%sol3 = [6.273743e+000 8.057623e-002 6.173477e+000 4.234966e+000 5.987332e+000 6.074495e+000 8.322097e-001 2.649786e+000 6.995055e-001 2.539575e+000 1.093253e+000 5.815352e+000 5.916623e-001 5.277412e+000 3.879921e+000 5.749515e+000 3.813017e+000 5.647877e+000 3.975749e-001 5.213975e-001 2.278595e+000 
%];

% Last version 10/09/2005. Roberto Santana (rsantana@si.ehu.es)    