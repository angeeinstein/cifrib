% undoes the last implementation
function StepBack
    global main Finf Tinf Dinf Binf Jinf ImpInf DelInf;

    if main.ImpInf(1,end) == 'F'

        helpDel1 = main.force(:,end);        % helpDel1 = last Force of main.Force
        helpDel2 = main.Impl(:,end);         % helpDel2 = last Implementation

        heplDel3 = cat(1,helpDel2,helpDel1); % Combine helpDel1 & helpDel2
        DelInf = cat(2,DelInf,heplDel3);     % Conect vectors with each other

        main.Delete = DelInf;                % Update Structure
        
        Finf(:,end) = [];                    % Delete last Force
        ImpInf(:,end) = [];                  % Delete last Implementation Information
        
        main.Force = Finf;                   % Update Structure
        main.ImpInf = ImpInf;                % Update Structure

    elseif main.ImpInf(1,end) == 'T'         % same for Torque

        helpDel1 = main.Torque(:,end);        
        helpDel2 = main.Impl(:,end);         

        heplDel3 = cat(1,helpDel2,helpDel1); 
        DelInf = cat(2,DelInf,heplDel3);     

        main.Delete = DelInf;                
        
        Tinf(:,end) = [];                    
        ImpInf(:,end) = [];                  
        
        main.Torque = Tinf;                   
        main.ImpInf = ImpInf; 

        elseif main.ImpInf(1,end) == 'D'         % same for Distl

        helpDel1 = main.Distl(:,end);        
        helpDel2 = main.Impl(:,end);         

        heplDel3 = cat(1,helpDel2,helpDel1); 
        DelInf = cat(2,DelInf,heplDel3);     

        main.Delete = DelInf;                
        
        Dinf(:,end) = [];                    
        ImpInf(:,end) = [];                  
        
        main.Distl = Dinf;                   
        main.ImpInf = ImpInf;

        elseif main.ImpInf(1,end) == 'B'         % same for Bearing

        helpDel1 = main.Bearing(:,end);        
        helpDel2 = main.Impl(:,end);         

        heplDel3 = cat(1,helpDel2,helpDel1); 
        DelInf = cat(2,DelInf,heplDel3);     

        main.Delete = DelInf;                
        
        Binf(:,end) = [];                    
        ImpInf(:,end) = [];                  
        
        main.Bearing = Binf;                   
        main.ImpInf = ImpInf;

        elseif main.ImpInf(1,end) == 'J'         % same for Bearing

        helpDel1 = main.Joint(:,end);        
        helpDel2 = main.Impl(:,end);         

        heplDel3 = cat(1,helpDel2,helpDel1); 
        DelInf = cat(2,DelInf,heplDel3);     

        main.Delete = DelInf;                
        
        Jinf(:,end) = [];                    
        ImpInf(:,end) = [];                  
        
        main.Joint = Jinf;                   
        main.ImpInf = ImpInf;
    end

end