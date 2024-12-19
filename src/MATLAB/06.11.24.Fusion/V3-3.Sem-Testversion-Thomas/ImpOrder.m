% Assin ID's to every vector in main Structure
function ImpOrder(Ftyp)

    global main loadID;
    loadID = loadID + 1;            % Prepare new ID for vector

    % Add unique ID into load vector for later Identification 
    if Ftyp == 1
        main.Force(4,end) = loadID;
    elseif Ftyp == 2
        main.Torque(3,end) = loadID;
    elseif Ftyp == 3
        main.Distl(7,end) = loadID;
    elseif Ftyp == 4
        main.Bearing(5,end) = loadID;
    elseif Ftyp == 5
        main.Joint(5,end) = loadID;
    end

    % Save Type of Implemented vector
    % Give unique ID to New vector
    
    helpI = [loadID;Ftyp];

    % Conect vectors with each other & Update Structure
    main.ImpInf = cat(2, main.ImpInf, helpI);  % Save Implementation Order

    % Update Structure(reset)
    main.BckInf = zeros(8,0);       % Pretends miss-use of StepForward function 
    
    % Vector Type Directory
    % Force         "1"
    % Torque        "2"
    % Distl         "3"
    % Bearing       "4"
    % Joint         "5"
    % Deleted V     "6"

    
end