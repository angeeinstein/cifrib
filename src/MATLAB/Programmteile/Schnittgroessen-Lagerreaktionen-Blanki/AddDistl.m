% Add Distl inputs to main Structure (Startpos, Endpos, Startvalue, sign (pos/neg), Exponent, pitch-k)
function AddDistl(SL1_St, SL1_End, SL1_HI, SL_Gl1, SL_Exp, SL_q0)

    global main Dinf;
    helpD = [SL1_St; SL1_End; SL1_HI; SL_Gl1; SL_Exp; SL_q0];   % integrate values to help vector
    Dinf = cat(2, Dinf, helpD);         % conect vectors with each other

    main.Distl = Dinf;                  % Update Structure
end