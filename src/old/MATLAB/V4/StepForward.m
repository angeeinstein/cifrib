% undoes last undo(Stepback)
function StepForward

    global main
    
    % add last deleated 
    
    % Force
    if main.BckInf(1,end) == 1
        AddForce(main.BckInf(3,end), main.BckInf(4,end), main.BckInf(5,end));
    % Torque
    elseif main.BckInf(1,end) == 2
        AddTorque(main.BckInf(3,end),main.BckInf(4,end));
    % Distl
    elseif main.BckInf(1,end) == 3
        AddDistl(main.BckInf(3,end),main.BckInf(4,end),main.BckInf(5,end),main.BckInf(6,end),main.BckInf(7,end),main.BckInf(8,end));
    % Bearing
    elseif main.BckInf(1,end) == 4
        AddBearing(main.BckInf(3,end),main.BckInf(4,end),main.BckInf(5,end),main.BckInf(6,end));
    % Joint
    elseif main.BckInf(1,end) == 5
        AddJoint(main.BckInf(3,end),main.BckInf(4,end),main.BckInf(5,end),main.BckInf(6,end));
    end

    % Deleate Last Back Information & Update Structure
    main.BckInf(:,end) = [];

end