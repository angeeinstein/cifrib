% Add Force inputs to main Structure (force,position,angle,ID)
function AddForce(F_Val, F_Pos, F_Ang)
    
    global main

    % Implement Given Values to Structure
        main.Force.Value(end+1) = F_Val;
        main.Force.Position(end+1) = F_Pos;
        main.Force.Angle(end+1) = F_Ang;

    % Create Individual ID
    ImpOrder(1);

end