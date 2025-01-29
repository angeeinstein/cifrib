function IDDelete(ForceID) % Has to be updated (new structure)
%IDDelete Deletes specific Load-Vectors by its ID
%   Serch for vector with input ID -> Delete force Vector in structure

global main loadID
    
% Serch for vector with input ID in main Structure
    % Which type of load
[~,helper] = find(main.ImpInf(1,:) == ForceID);     % Imp pos
Ltype = main.ImpInf(2,helper);                      % Load type

% Save Implementation Information for "StepBack"
helpDel2 = main.ImpInf(:,helper);       % helpDel2 = last Implementation

% Delete Implementation Information in Structure
main.ImpInf(:,helper) = [];


% According to load type delete coresponding load

if Ltype == 1           % Force
    % Serch for "Deleting" vector with ID
    [~,ExtermHelper] = find(main.Force(4,:) == ForceID);

    helpDel1 = main.Force(:,ExtermHelper);          % Save vector for "StepBack"
    heplDel3 = cat(1,helpDel2,helpDel1,0,0,0);      % Combine helpDel1 & helpDel2

    % Delete Vector
    main.Force(:,ExtermHelper) = [];

elseif Ltype == 2       % Torque
    % Serch for "Deleting" vector with ID
    [~,ExtermHelper] = find(main.Torque(3,:) == ForceID);

    helpDel1 = main.Torque(:,ExtermHelper);         % Save vector for "StepBack"
    heplDel3 = cat(1,helpDel2,helpDel1,0,0,0,0);    % Combine helpDel1 & helpDel2

    % Delete Vector
    main.Torque(:,ExtermHelper) = [];

elseif Ltype == 3       % Distl
    % Serch for "Deleting" vector with ID
    [~,ExtermHelper] = find(main.Distl(7,:) == ForceID);

    helpDel1 = main.Distl(:,ExtermHelper);          % Save vector for "StepBack"
    heplDel3 = cat(1,helpDel2,helpDel1);            % Combine helpDel1 & helpDel2

    % Delete Vector
    main.Distl(:,ExtermHelper) = [];

elseif Ltype == 4       % Bearing
    % Serch for "Deleting" vector with ID
    [~,ExtermHelper] = find(main.Bearing(5,:) == ForceID);

    helpDel1 = main.Bearing(:,ExtermHelper);        % Save vector for "StepBack"
    heplDel3 = cat(1,helpDel2,helpDel1,0,0);        % Combine helpDel1 & helpDel2

    % Delete Vector
    main.Bearing(:,ExtermHelper) = [];

elseif Ltype == 5       % Joint
    % Serch for "Deleting" vector with ID
    [~,ExtermHelper] = find(main.Joint(5,:) == ForceID);

    helpDel1 = main.Joint(:,ExtermHelper);          % Save vector for "StepBack"
    heplDel3 = cat(1,helpDel2,helpDel1,0,0);        % Combine helpDel1 & helpDel2

    % Delete Vector
    main.Joint(:,ExtermHelper) = [];
end

% Conect vectors with each other & Update Structure
        main.DelInf = cat(2,main.DelInf,heplDel3);

% Save Step In ImpInf & Update Structure
        loadID = loadID + 1;         % prepare new loadID
        Inf = [loadID,Ltype];
        main.ImpInf = cat(2,Inf);

end

