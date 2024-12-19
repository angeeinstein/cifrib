% Add Bearing inputs to main Structure (pos, support in x, support in y,
% support in Tourque)  all Bool, except pos
function AddBearing(B_Pos, B_Supx, B_Supy, B_Supt)
    
    global main Binf;

    helpB = [B_Pos; B_Supx; B_Supy; B_Supt];    % integrate values to help vector

    Binf = cat(2, Binf, helpB);                 % connect vectors with each other

    main.Bearing = Binf;                        % Update Structure
    ImpOrder('B');                              % Create ID
end