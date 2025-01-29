% Add Tourque inputs to main Structure (Torque,Position,ID)
function AddTorque(T_Val, T_Pos)
    
    global main

    % Implement Given Values to Structure
    main.Torque.Value(end+1) = T_Val;
    main.Torque.Position(end+1) = T_Pos;

    % Create Individual ID
    ImpOrder(2);
end