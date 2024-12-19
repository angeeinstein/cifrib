% Undoes the last Implementation
% Saves Deleated vectors in main.Backinf
function Undo(app)
    global main

    % If Last Implementation = Force
    if main.ImpInf(2,end) == 1

        helpDel1 = main.Force(:,end);        % helpDel1 = last Force of main.Force
        helpDel2 = main.ImpInf(:,end);       % helpDel2 = last Implementation

        heplDel3 = cat(1,helpDel2,helpDel1,0,0,0); % Combine helpDel1 & helpDel2

        % Conect vectors with each other & Update Structure
        main.BckInf = cat(2,main.BckInf,heplDel3);

        % Update Structure
        main.Force(:,end) = [];              % Delete last Force
        main.ImpInf(:,end) = [];             % Delete last Implementation Information


    elseif main.ImpInf(2,end) == 2           % Same for Torque

        helpDel1 = main.Torque(:,end);        
        helpDel2 = main.ImpInf(:,end);         

        heplDel3 = cat(1,helpDel2,helpDel1,0,0,0,0); 

        % Conect vectors with each other & Update Structure
        main.BckInf = cat(2,main.BckInf,heplDel3);                    
        
        % Update Structure
        main.Torque(:,end) = [];           % Delete Last Torque        
        main.ImpInf(:,end) = [];           % Delete last Implementation Information

    elseif main.ImpInf(2,end) == 3          % same for Distl

        helpDel1 = main.Distl(:,end);        
        helpDel2 = main.ImpInf(:,end);         

        heplDel3 = cat(1,helpDel2,helpDel1); 

        % Conect vectors with each other & Update Structure
        main.BckInf = cat(2,main.BckInf,heplDel3);                    
        
        % Update Structure
        main.Distl(:,end) = [];         % Delete Last Distl Vector        
        main.ImpInf(:,end) = [];        % Delete last Implementation Information

    elseif main.ImpInf(2,end) == 4          % same for Bearing

        helpDel1 = main.Bearing(:,end);        
        helpDel2 = main.ImpInf(:,end);         

        heplDel3 = cat(1,helpDel2,helpDel1,0,0); 

        % Conect vectors with each other & Update Structure
        main.BckInf = cat(2,main.BckInf,heplDel3);                   
        
        % Update Structure
        main.Bearing(:,end) =[];        % Delete Last Bearing Vector          
        main.ImpInf(:,end) = [];        % Delete Last Implementation Information

    elseif main.ImpInf(2,end) == 5          % same for Joint

        helpDel1 = main.Joint(:,end);        
        helpDel2 = main.ImpInf(:,end);         

        heplDel3 = cat(1,helpDel2,helpDel1,0,0,0);

        % Conect vectors with each other & Update Structure
        main.BckInf = cat(2,main.BckInf,heplDel3);                   
        
        % Update Structure
        main.Joint(:,end) = [];         % Delete Last Joint Vector               
        main.ImpInf(:,end) = [];        % Delete Last Implementation Information

    elseif main.ImpInf(2,end) == 6      % Same for Deleted vectors
        
        helpDel1 = main.DelInf(:,end);
        helpDel2 = main.ImpInf(:,end);

        heplDel3 = cat(1,helpDel2,helpDel1);

        % Conect vectors with each other & Update Structure
        main.BckInf = cat(2,main.BckInf,heplDel3);                   
        
        % Update Structure             
        main.ImpInf(:,end) = [];        % Delete Last Implementation Information

    end

    % Replot Everything
    PlotAll(app);

    % Update Static Definition
    app.EditField_StaticDefinition1.Value = StaticDefinitionBearing;
    app.EditField_StaticDefinition2.Value = StaticDefinitionHinge;

end