function structureinitiate()

    global main loadID;
    main = struct('Force', [], 'Torque', [], 'Distl', [],'Bearing', [],'Joint', [],'ImpInf', [], 'BckInf', [], 'DelInf', []);

    % Add matrixes for later load information
    Finf = zeros(4,0);       % Forces martix (pos, angle, value)
    Tinf = zeros(3,0);       % Tourk matrix (pos, value)
    Dinf = zeros(7,0);       % Dist load matrix (Startpos, Endpos, Startvalue, sign (pos=1/neg=-1), Exponent, pitch-k)
    Binf = zeros(5,0);       % Beraing load matrix (pos, support in x, support in y, support in Tourque)
    Jinf = zeros(5,0);       % Joint load matrix (pos, support in x, support in y, support in Tourque)

    % Add index list for tracability (StepBack)
    ImpInf = zeros(2,0);    % Implementation Information (loadID, loadtype)
    BckInf = zeros(8,0);    % Back Information (loadtype, loadID, INDIVIDUEL...)
    loadID = 1000;          % Assin every load its own loadID
    DelInf = zeros(8,0);

    %Integrate load information matrixes to main Structure
    main.Force = Finf;
    main.Torque = Tinf;
    main.Distl = Dinf;
    main.Bearing = Binf;
    main.Joint = Jinf;
    main.ImpInf = ImpInf;
    main.BckInf = BckInf;
    main.DelInf = DelInf;


end