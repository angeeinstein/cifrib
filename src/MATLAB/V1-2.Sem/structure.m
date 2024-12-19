%Add Structure

% Initiate main Structure - split structure in katrgorys (Force, Tourk, Distl, Bearing, Joint)
global main Finf Tinf Dinf Binf Jinf;
main = struct('Force', [], 'Tourk', [], 'Distl', [],'Bearing', [],'Joint', []);

% Add matrixes for later load information
Finf = zeros(3,0);       % Forces martix (pos, angle, value)
Tinf = zeros(2,0);       % Tourk matrix (pos, value)
Dinf = zeros(6,0);       % Dist load matrix (Startpos, Endpos, Startvalue, sign (pos=1/neg=-1), Exponent, Formula)
Binf = zeros(4,0);       % Beraing load matrix (pos, support in x, support in y, support in Tourque)
Jinf = zeros(4,0);       % Joint load matrix (pos, support in x, support in y, support in Tourque)

%Integrate load information matrixes to main Structure
main.Force = Finf;
main.Tourk = Tinf;
main.Distl = Dinf;
main.Bearing = Binf;
main.Joint = Jinf;
%end
    

% Add Force inputs to main Structure (force, position, angle)
function F_N = AddForce(F_1, F1_Pos, F1_a)
    
    global main Finf;
    helpF = [F_1; F1_Pos; F1_a];        % integrate values to help vector
    Finf = cat(2, Finf, helpF);         % conect vectors with each other
    F_N = F_N + 1;                      % Increase number of forces by one

    main.Force = Finf;                  % Update Structure
end

% Add Tourk inputs to main Structure (Tourk, position)
function T_N = AddTourk(T_1, T_Pos)
    
    global main;
    helpT = [T_1; T_Pos];               % integrate values to help vector
    Tinf = cat(2, Tinf, helpT);         % conect vectors with each other
    T_N = T_N + 1;                      % Increase number of Tourk by one

    main.Tourk = Tinf;                  % Update Structure
end

% Add Distl inputs to main Structure (Startpos, Endpos, Startvalue, sign (pos/neg), Exponent, Formula)
function D_N = AddDistl(SL1_St, SL1_End, SL1_HI, SL_Gl1, SL_Exp, SL_q0)

    global main;
    helpD = [SL1_St; SL1_End; SL1_HI; SL_Gl1; SL_Exp; SL_q0];   % integrate values to help vector
    Dinf = cat(2, Dinf, helpD);         % conect vectors with each other

    main.Distl = Dinf;                  % Update Structure
end

% Add Bearing inputs to main Structure (pos, support in x, support in y,
% support in Tourque)  all Bool, except pos
function B_N = AddBearing(B_Pos, B_Supx, B_Supy, B_Supt)
    
    global main;
    helpB = [B_Pos; B_Supx; B_Supy; B_Supt];               % integrate values to help vector
    Binf = cat(2, Binf, helpB);         % conect vectors with each other

    main.Bearing = Binf;                  % Update Structure
end

% Add Joint inputs to main Structure (pos, support in x, support in y,
% support in Tourque) all Bool, except pos
function J_N = AddJoint(J_Pos, J_Supx, J_Supy, J_Supt)

    global main;
    helpJ = [J_Pos; J_Supx; J_Supy; J_Supt];               % integrate values to help vector
    Jinf = cat(2, Jinf, helpJ);         % conect vectors with each other

    main.Joint = Jinf;                  % Update Structure
end


% % Add Lager Structure 
% function lagerstruktur 
% 
% % create new structure for lager, gelenke
% Lager = struct('lager', [], 'gelenke', [])
% 
% % create emty lager inf vector
% Linf = zeros(2, 0);
% % create emty gelenk vektor
% Ginf = zeros(2, 0);
% 
% end