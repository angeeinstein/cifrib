% Add Joint inputs to main Structure (Position, XSupport, ZSupport, TSupport, LoadID)
% all Bool, except pos & ID
function AddJoint(J_Pos, J_Supx, J_Supz, J_Supt)

    global main
    % check if on position is a bearing alredy
    hold = false;
    k = length(main.Bearing.Position);

    for i=1:k
        if J_Pos == main.Bearing.Position(i)
            hold = true;
            break;
        end
    end

    if hold == false 
        % if there was no bearing go on
        main.Joint.Position(end+1) = J_Pos;
        main.Joint.XSupport(end+1) = J_Supx;
        main.Joint.ZSupport(end+1) = J_Supz;
        main.Joint.TSupport(end+1) = J_Supt;

        % Create Individual ID
        ImpOrder(5);
    else
        % if Beraing is there set bearing B_supt to 0
            % and dont implement sepperate joint
        main.Bearing.TSupport(i) = 0;
    end

end