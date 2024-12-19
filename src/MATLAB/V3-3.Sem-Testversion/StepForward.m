% undoes last undo(Stepback)
function StepForward

    global main DelInf;


    % add last deleated 
    if main.Delete(1,end) == 'F'
        AddForce(main.Delete(3,end), main.Delete(4,end), main.Delete(5,end));   

    elseif main.Delete(1,end) == 'T'
        AddTorque(main.Delete(3,end),main.Delete(4,end));

    elseif main.Delete(1,end) == 'D'
        AddDistl(main.Distl(3,end),main.Delete(4,end),main.Delete(5,end),main.Delete(6,end),main.Delete(7,end),main.Delete(8,end));

    elseif main.Delete(1,end) == 'B'
        AddBearing(main.Delete(3,end),main.Delete(4,end),main.Delete(5,end),main.Delete(6,end));

    elseif main.Delete(1,end) == 'J'
        AddJoint(main.Delete(3,end),main.Delete(4,end),main.Delete(5,end),main.Delete(6,end));
    end

    DelInf(:,end) = [];             % Deleate Last Delete Information
    main.Delete = DelInf;           % Update Structure

end