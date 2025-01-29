% Add Bearing inputs to main Structure (Position, XSupport, ZSupport, TSupport, LoadID)
% all Bool, except pos & ID
function AddBearing(B_Pos, B_Supx, B_Supz, B_Supt)
    
    global main

    main.Bearing.Position(end+1) = B_Pos;
    main.Bearing.XSupport(end+1) = B_Supx;
    main.Bearing.ZSupport(end+1) = B_Supz;
    main.Bearing.TSupport(end+1) = B_Supt;

    % Create Individual ID
    ImpOrder(4);
end