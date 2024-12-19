% Add Bearing inputs to main Structure (pos, support in x, support in y,
% support in Tourque, ID)  all Bool, except pos
function AddBearing(B_Pos, B_Supx, B_Supy, B_Supt)
    
    global main

    helpB = [B_Pos; B_Supx; B_Supy; B_Supt; 0];    % Integrate values to help vector

    % Connect vectors with each other & Update Structure
    main.Bearing = cat(2, main.Bearing, helpB);

    ImpOrder(4);                                % Create ID
end