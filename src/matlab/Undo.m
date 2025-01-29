% Undoes the last Implementation 
% Saves Deleated vectors in main.Backinf
function Undo(app)
    global main

    % If Last Implementation = Force
    if main.ImpInf.LoadTyp(end) == 1

        % Store Deleted Vector Inf in main.BckInf

        helpDel1 = [main.Force.Value(end); main.Force.Position(end); main.Force.Angle(end); main.Force.LoadID(end)];       % helpDel1 = last Force of main.Force
        helpDel2 = [main.ImpInf.LoadTyp(end); main.ImpInf.LoadID];       % helpDel2 = last Implementation

        heplDel3 = cat(1,helpDel2,helpDel1,0,0,0); % Combine helpDel1 & helpDel2

        % Conect vectors with each other & Update Structure
        main.BckInf = cat(2,main.BckInf,heplDel3);

        
        % Update Structure
            % Delete last Force
            main.Force.Value(end) = [];  
            main.Force.Position(end) = [];
            main.Force.Angle(end) = [];
            main.Force.LoadID(end) = []; 
        
            % Delete last Implementation Information
            main.ImpInf.LoadTyp(end) = []; 
            main.ImpInf.LoadID(end) = [];


    elseif main.ImpInf(2,end) == 2           % Same for Torque

        helpDel1 = [main.Torque.Value(end); main.Torque.Position(end); main.Torque.LoadID(end)];        
        helpDel2 = [main.ImpInf.LoadTyp(end); main,ImpInf.LoadID(end)];         

        heplDel3 = cat(1,helpDel2,helpDel1,0,0,0,0); 

        % Conect vectors with each other & Update Structure
        main.BckInf = cat(2,main.BckInf,heplDel3);                    
        
        % Update Structure
            % Delete Last Torque
            main.Torque.Value(end) = [];
            main.Torque.Position(end) = [];
            main.Torque.LoadID = [];

        % Delete last Implementation Information
            main.ImpInf.LoadTyp(end) = []; 
            main.ImpInf.LoadID(end) = [];

    elseif main.ImpInf(2,end) == 3          % same for Distl

        helpDel1 = [main.Distl.StartPos(end); main.Distl.EndPos(end); main.Distl.Value(end); main.Distl.Sign(end); main.Distl.Exponent(end); main.Distl.Pitch(end); main.Distl.LoadID(end)];      
        helpDel2 = [main.ImpInf.LoadTyp(end); main,ImpInf.LoadID(end)];         

        heplDel3 = cat(1,helpDel2,helpDel1); 

        % Conect vectors with each other & Update Structure
        main.BckInf = cat(2,main.BckInf,heplDel3);                    
        
        % Update Structure
            % Delete Last Distl
            main.Distl.StartPos(end) = []; 
            main.Distl.EndPos(end) = [];
            main.Distl.Value(end) = [];
            main.Distl.Sign(end) = [];
            main.Distl.Exponent(end) = [];
            main.Distl.Pitch(end) = [];
            main.Distl.LoadID(end) = [];

            % Delete last Implementation Information
            main.ImpInf.LoadTyp(end) = []; 
            main.ImpInf.LoadID(end) = [];


    elseif main.ImpInf(2,end) == 4          % same for Bearing

        helpDel1 = [main.Bearing.Position(end); main.Bearing.XSupport(end); main.Bearing.ZSupport(end); main.Bearing.TSupport(end); main.Bearing.LoadID(end)];        
        helpDel2 = [main.ImpInf.LoadTyp(end); main,ImpInf.LoadID(end)];       

        heplDel3 = cat(1,helpDel2,helpDel1,0,0); 

        % Conect vectors with each other & Update Structure
        main.BckInf = cat(2,main.BckInf,heplDel3);                   
        
        % Update Structure
            % Delete Last Bearing
            main.Bearing.Position(end) = [];
            main.Bearing.XSupport(end) = [];
            main.Bearing.ZSupport(end) = [];
            main.Bearing.TSupport(end) = [];
            main.Bearing.LoadID(end) = [];

            % Delete last Implementation Information
            main.ImpInf.LoadTyp(end) = []; 
            main.ImpInf.LoadID(end) = [];

    elseif main.ImpInf(2,end) == 5          % same for Joint

        helpDel1 = [main.Joint.Position(end); main.Joint.XSupport(end); main.Joint.ZSupport(end); main.Joint.TSupport(end); main.Joint.LoadID(end)]; 
        helpDel2 = [main.ImpInf.LoadTyp(end); main,ImpInf.LoadID(end)];          

        heplDel3 = cat(1,helpDel2,helpDel1,0,0);

        % Conect vectors with each other & Update Structure
        main.BckInf = cat(2,main.BckInf,heplDel3);                   
        
        % Update Structure
            % Delete Last Joint
            main.Joint.Position(end) = [];
            main.Joint.XSupport(end) = [];
            main.Joint.ZSupport(end) = [];
            main.Joint.TSupport(end) = [];
            main.Joint.LoadID(end) = [];
              
            % Delete last Implementation Information
            main.ImpInf.LoadTyp(end) = []; 
            main.ImpInf.LoadID(end) = [];

    elseif main.ImpInf(2,end) == 6      % Same for Deleted vectors
        
        helpDel1 = main.DelInf(:,end);
        helpDel2 = [main.ImpInf.LoadTyp(end); main,ImpInf.LoadID(end)];

        heplDel3 = cat(1,helpDel2,helpDel1);

        % Conect vectors with each other & Update Structure
        main.BckInf = cat(2,main.BckInf,heplDel3);                   
        
            % Update Structure
            % Delete last Implementation Information
            main.ImpInf.LoadTyp(end) = []; 
            main.ImpInf.LoadID(end) = [];

    end

    % Replot Everything
    PlotAll(app);

    % Update Static Definition
    app.EditField_StaticDefinition1.Value = StaticDefinitionBearing;
    app.EditField_StaticDefinition2.Value = StaticDefinitionHinge;

end