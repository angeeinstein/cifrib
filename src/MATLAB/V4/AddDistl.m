% Add Distl inputs to main Structure (Startpos, Endpos, Startvalue, sign (pos/neg), Exponent, pitch-k, ID)
function AddDistl(SL1_St, SL1_End, SL1_HI, SL_Gl1, SL_Exp, SL_q0)

    global main
    helpD = [SL1_St; SL1_End; SL1_HI; SL_Gl1; SL_Exp; SL_q0; 0];   % Integrate values to help vector

    % Conect vectors with each other & Update Structure
    main.Distl = cat(2, main.Distl, helpD);

    ImpOrder(3);                      % Create ID
end