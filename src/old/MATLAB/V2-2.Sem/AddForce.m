% Add Force inputs to main Structure (position, angle,force)
function AddForce(F_1, F1_Pos, F1_a)
    
    global main Finf;
    helpF = [F_1; F1_Pos; F1_a];        % integrate values to help vector
    Finf = cat(2, Finf, helpF);         % conect vectors with each other

    main.Force = Finf;                  % Update Structure
end