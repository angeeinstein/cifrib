% Add Joint inputs to main Structure (pos, support in x, support in y,
% support in Tourque) all Bool, except pos
function AddJoint(J_Pos, J_Supx, J_Supy, J_Supt)

    global main Jinf;
    % check if on position is a bearing alredy
    hold = false;
    [~,N1] = main.Bearing;

    for i=1:N1
        if J_Pos == main.Bearing(1,i)
            hold = true;
            break;
        end
    end

    if hold == false 
        % if there was no bearing go on
        helpJ = [J_Pos; J_Supx; J_Supy; J_Supt];               % integrate values to help vector
        Jinf = cat(2, Jinf, helpJ);         % connect vectors with each other

        main.Joint = Jinf;                  % Update Structure
    else
        % if beraing is there set bearing B_supt to 0
            % and dont implement sepperate joint
        main.Bearing(4,i) = 0;
    end

end