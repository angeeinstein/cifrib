% Add Tourque inputs to main Structure (Position,Torque,ID)
function AddTorque(T_Pos, T_Value)
    
    global main
    helpT = [T_Pos; T_Value; 0];           % Integrate values into help vector

    % Conect vectors with each other & Update Structure
    main.Torque = cat(2, main.Torque, helpT);

    ImpOrder(2);                      % Create ID
end