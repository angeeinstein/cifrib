% Add Distl inputs to main Structure (StartPos, EndPos, StartValue, Sign (pos=1/neg=-1), Exponent, Pitch-k, LoadID)
function AddDistl(SL1_St, SL1_End, SL1_HI, SL_Gl1, SL_Exp, SL_q0)

    global main

    % Implement Given Values to Structure
    main.Distl.StartPos(end+1) = SL1_St;
    main.Distl.EndPos(end+1) = SL1_End;
    main.Distl.StartValue(end+1) = SL1_HI;
    main.Distl.Sign(end+1) = SL_Gl1;
    main.Distl.Exponent(end+1) = SL_Exp;
    main.Distl.Pitch(end+1) = SL_q0;

    % Create Individual ID
    ImpOrder(3);

end