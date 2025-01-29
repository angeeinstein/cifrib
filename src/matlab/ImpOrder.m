% Assin ID's to every vector in main Structure
function ImpOrder(Ftyp)

    global main loadID;

    % Check If Redo is Active
    if main.Redoe == false           % Normal Implementation

        loadID = loadID + 1;            % Prepare new ID for vector
    
        % Add unique ID into load vector for later Identification 
        if Ftyp == 1
            main.Force.LoadID(end+1) = loadID;
        elseif Ftyp == 2
            main.Torque.LoadID(end+1) = loadID;
        elseif Ftyp == 3
            main.Distl.LoadID(end+1) = loadID;
        elseif Ftyp == 4
            main.Bearing.LoadID(end+1) = loadID;
        elseif Ftyp == 5
            main.Joint.LoadID(end+1) = loadID;
        end

        % Give unique ID to New vector
        main.ImpInf.LoadID(end+1) = loadID;

        % Save Type of Implemented vector
        main.ImpInf.LoadTyp(end+1)= Ftyp;
        
    
        % Update Structure(reset)
        main.BckInf = zeros(9,0);       % Pretends miss-use of StepForward function 
        

    else                % Redo Implementation

        % Reuse ID for later Identification 
        if Ftyp == 1
            main.Force.LoadID(end+1) = main.BckInf(1,end);
        elseif Ftyp == 2
            main.Torque.LoadID(end+1) = main.BckInf(1,end);
        elseif Ftyp == 3
            main.Distl.LoadID(end+1) = main.BckInf(1,end);
        elseif Ftyp == 4
            main.Bearing.LoadID(end+1) = main.BckInf(1,end);
        elseif Ftyp == 5
            main.Joint.LoadID(end+1) = main.BckInf(1,end);
        end

        % Give unique ID to New vector
        main.ImpInf.LoadID = main.BckInf(2,end);
        % Save Type of Implemented vector
        main.ImpInf.LoadTyp = Ftyp; 
        
    end


    % Vector Type Directory
    % Force         "1"
    % Torque        "2"
    % Distl         "3"
    % Bearing       "4"
    % Joint         "5"
    % Deleted V     "6"

    
end