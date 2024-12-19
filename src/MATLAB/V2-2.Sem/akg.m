function [B1, B2] = akg(l)

global main;
syms B1 B2


% summe aller kräfte 
SF = 0;
% Implement all external forces
[~,v] = size(main.Force);
for i=1:v
    SF = SF + main.Force(3,i);
end

% Bearings
SF = SF + B1 + B2;

% sum of moments 
SM = 0;
% Forces
[~,v] = size(main.Force);
for i=1:v
    SM = SM + main.Force(3,i)* main.Force(1,i);
end

SM = SM + B1 * main.Bearing(1,1) + B2 * main.Bearing(1,2);

B1 = solve(SF == 0,B1);
B2 = solve(SM == 0, B2);

% B1 Strich
% B2 Strich

B2S = matlabFunction(B2);
B2S = B2S(B1);

B1S = matlabFunction(B1);
B1S = B1S(B2);


if isnumeric(B1S) == 0
    B1 = matlabFunction(B1);
    B1 = B1(B2);
end
if isnumeric(B2S) == false
    B2 = matlabFunction(B2);
    B2 = B2(B1);
end


end


function [B1, B2] = akg(l)

global main;
syms B1 B2


% summe aller kräfte 
SF = 0;
% Implement all external forces
[~,v] = size(main.Force);
for i=1:v
    SF = SF + main.Force(3,i);
end

% Bearings
SF = SF + B1 + B2;

% sum of moments 
SM = 0;
% Forces
[~,v] = size(main.Force);
for i=1:v
    SM = SM + main.Force(3,i)* main.Force(1,i);
end

SM = SM + B1 * main.Bearing(1,1) + B2 * main.Bearing(1,2);

B1 = solve(SF == 0,B1);
B2 = solve(SM == 0, B2);

% B1 Strich
% B2 Strich

B2S = matlabFunction(B2);
B2S = B2S(B1);

B1S = matlabFunction(B1);
B1S = B1S(B2);


if isnumeric(B1S) == 0
    B1 = matlabFunction(B1);
    B1 = B1(B2);
end
if isnumeric(B2S) == false
    B2 = matlabFunction(B2);
    B2 = B2(B1);
end


end




