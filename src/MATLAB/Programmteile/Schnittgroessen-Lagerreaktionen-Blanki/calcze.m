function [C1,C2] = calcze (Mb,F,l)
% CALCZE calculates the integration constants C1, C2

% create integration variables as variables
syms x
syms C1
syms C2
global main;
global lbar;
l=lbar;
s=NaN;

% consider free beginning of the beam
[~, N1] = size(main.Bearing); %Bearing amounts

if all(main.Bearing(1,1:N1) ~= 0)
    if N1 <= 1
        Mb = -Mb;
        F = -F;

        C1 = matlabFunction(F);
        C1 = C1(0);
        C1 = subs(C1);

        C2 = matlabFunction(Mb);
        C2 = C2(0); % -Mb(0);

        return;
    else

    end

    % consider Free end of Beam on right side
elseif all(main.Bearing(1,1:N1) ~= l)

    % create equation helper
    eq1 = F + C1;

    % sipmplfy equation helper
    eq1 = matlabFunction(eq1);

    % set x to position(funktion Handle)
    if eq1==C1
        C1=0;
    
    else
        eq1 = eq1(C1,l);

        % solve equation for C1 
        C1 = solve(eq1 == 0,C1);
    end

    % consider C2
    % create equation helper
    eq2 = Mb + C1 * x + C2;

    % sipmplfy equation helper
    eq2 = matlabFunction(eq2);

    % set x to position(funktion Handle)
    eq2 = eq2(C2,l);

    % solve equation for C2
    C2 = solve(eq2 == 0,C2);

% if there is no free begining nor a free end this will be nessesary
% consider all non free beam situations
else 
    for k=1:N1
        if main.Bearing(1,k) == 0
            break;
        end
    end

    % Bearing on pos 0 doesn't support tourque
    if main.Bearing(4,k) == 0

        % C2 has to be zero
        C2 = 0;

    % Bearing does support tourque
    else

        % requires joint somewere -> C1 will be zero
        C1 = 0;
    end
    % serch for another Bearing 
    for m=1:N1
        if main.Bearing(1,m) ~= 0
            break;
        end
    end

    % create equation helper
    eq1 = Mb + C1 * x + C2;

    if isnumeric(C1)

        % sipmplfy equation helper
        eq1 = matlabFunction(eq1);

        % set x to position(funktion Handle)
        eq1 = eq1(C2,main.Bearing(1,m));

        % solve equation after C2
        C2 = solve(eq1,C2);

        return;

    % else C2 is numeric
    else
        % sipmplfy equation helper
        eq1 = matlabFunction(eq1);

        % set x to position(funktion Handle)
        eq1 = eq1(C1,main.Bearing(1,m));

        % solve equation after C1
        C1 = solve(eq1,C1);

        return;

    end

end