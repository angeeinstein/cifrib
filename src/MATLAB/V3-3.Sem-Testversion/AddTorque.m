% Add Tourque inputs to main Structure (Position,Torque,)
function AddTorque(T_Pos, T_Value)
    
    global main Tinf;
    helpT = [T_Pos; T_Value];               % integrate values to help vector
    Tinf = cat(2, Tinf, helpT);         % conect vectors with each other

    main.Torque = Tinf;                  % Update Structure
    ImpOrder('T');                      % Create ID
end