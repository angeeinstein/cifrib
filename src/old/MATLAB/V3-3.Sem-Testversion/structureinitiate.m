function structureinitiate()

    global main Finf Tinf Dinf Binf Jinf ImpInf DelInf loadID;
    main = struct('Force', [], 'Torque', [], 'Distl', [],'Bearing', [],'Joint', [],'Steps', [], 'Backstep', []);

    % Add matrixes for later load information
    Finf = zeros(3,0);       % Forces martix (pos, angle, value)
    Tinf = zeros(2,0);       % Tourk matrix (pos, value)
    Dinf = zeros(6,0);       % Dist load matrix (Startpos, Endpos, Startvalue, sign (pos=1/neg=-1), Exponent, pitch-k)
    Binf = zeros(4,0);       % Beraing load matrix (pos, support in x, support in y, support in Tourque)
    Jinf = zeros(4,0);       % Joint load matrix (pos, support in x, support in y, support in Tourque)

    % Add index list for tracability (StepBack)
    ImpInf = zeros(2,0);    % Implementation Information (loadtype, loadID)
    DelInf = zeros(8,0);    % Deleat Information (loadtype, loadID, INDIVIDUEL...)
    loadID = 1000;          % Assin every load its own loadID

    %Integrate load information matrixes to main Structure
    main.Force = Finf;
    main.Torque = Tinf;
    main.Distl = Dinf;
    main.Bearing = Binf;
    main.Joint = Jinf;
    main.Impl = ImpInf;
    main.Delete = DelInf;

end