% Add Force inputs to main Structure (position,angle,force,ID)
function AddForce(F_1, F1_Pos, F1_a)
    
    global main
    helpF = [F_1; F1_Pos; F1_a; 0];        % Integrate values into help vector

    % Conect vectors with each other & Update Structure
    main.Force = cat(2, main.Force, helpF);
    
    ImpOrder(1);                        % Create ID

end