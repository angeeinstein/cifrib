function structureinitiate()

    global main loadID results;
    main = struct('Force', struct('Value', [], 'Position', [], 'Angle', [], 'LoadID', []), ...
                  'Torque', struct('Value', [], 'Position', [], 'LoadID', []), ...
                  'Distl', struct('StartPos', [], 'EndPos', [], 'StartValue', [], 'Sign', [], 'Exponent', [], 'Pitch', [], 'LoadID', []), ...
                  'Bearing', struct('Position', [], 'XSupport', [], 'ZSupport', [], 'TSupport', [], 'LoadID', []), ...
                  'Joint', struct('Position', [], 'XSupport', [], 'ZSupport', [], 'TSupport',[], 'LoadID', []), ...
                  'ImpInf', struct('LoadID', [], 'LoadTyp', []), ...
                  'BckInf', [], ...
                  'DelInf', [], ...
                  'BarLgh', [], ...
                  'StaticDefinition', [], ...
                  'Redoe', []);
    results = struct ('Fz', [],'Fx', [],'Mb', [],'BearingForces', []);
    

    % Add matrixes for later load information
    % Finf = zeros(4,0);       % Forces martix (force, pos, angle, loadID)
    % Tinf = zeros(3,0);       % Tourk matrix (pos, value)
    % Dinf = zeros(7,0);       % Dist load matrix (Startpos, Endpos, Startvalue, sign (pos=1/neg=-1), Exponent, pitch-k)
    % Binf = zeros(5,0);       % Beraing load matrix (pos, support in x, support in y, support in Tourque)
    % Jinf = zeros(5,0);       % Joint load matrix (pos, support in x, support in y, support in Tourque)

    % % Add index list for tracability (StepBack)
    % ImpInf = zeros(2,0);    % Implementation Information (loadID, loadtype)
    % BckInf = zeros(9,0);    % Back Information (loadID, loadtype, INDIVIDUEL...)
    % loadID = 1000;          % Assin every load its own loadID
    % Redoe = false;
    % DelInf = zeros(8,0);


    % Force Struct[1] (Value, Position, Angle, LoadID)
        main.Force.Value = zeros(1,0);
        main.Force.Position = zeros(1,0);
        main.Force.Angle = zeros(1,0);
        main.Force.LoadID = zeros(1,0);

    % Torque Struct[2] (Value, Position, LoadID)
        main.Torque.Value = zeros(1,0);
        main.Torque.Position = zeros(1,0);
        main.Torque.LoadID = zeros(1,0);

   % Distl Struct[3] (StartPos, EndPos, StartValue, Sign (pos=1/neg=-1), Exponent, Pitch-k, LoadID)
        main.Distl.StartPos = zeros(1,0);
        main.Distl.EndPos = zeros(1,0);
        main.Distl.StartValue = zeros(1,0);
        main.Distl.Sign = zeros(1,0);
        main.Distl.Exponent = zeros(1,0);
        main.Distl.Pitch = zeros(1,0);
        main.Distl.LoadID = zeros(1,0);

   % Beraing Struct[4] (Position, Support in X, Support in Z, Support in Tourque, LoadID)
        main.Bearing.Position = zeros(1,0);
        main.Bearing.XSupport = zeros(1,0);
        main.Bearing.ZSupport = zeros(1,0);
        main.Bearing.TSupport = zeros(1,0);
        main.Bearing.LoadID = zeros(1,0);

   % Joint Struct[5] (Position, Support in X, Support in Z, Support in Tourque, LoadID)
        main.Joint.Position = zeros(1,0);
        main.Joint.XSupport = zeros(1,0);
        main.Joint.ZSupport = zeros(1,0);
        main.Joint.TSupport = zeros(1,0);
        main.Joint.LoadID = zeros(1,0);

   % Implementation Information Struct (loadID, loadtype)
        main.ImpInf.LoadID = zeros(1,0);
        main.ImpInf.LoadTyp = zeros(1,0);

   % Back Information (loadID, loadtype, INDIVIDUEL...)
        main.BckInf= zeros(9,0);

   % Delete Information (there is a use [Undo])    !!
        main.DelInf = zeros(8,0);

   % Bar Length (Length of the Bar)
        main.BarLgh = zeros(1,0);


   % Static Definition (not fully implementet jet)
        main.StaticDefinition = zeros(2,0);

   % Redoe (Bool if current step is caused by redo button)
        main.Redoe = false;

   % Assin every load its own loadID
        loadID = 1000;


end