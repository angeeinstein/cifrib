% Add Joint inputs to main Structure (pos, support in x, support in y,
% support in Tourque, ID) all Bool, except pos
function AddJoint(J_Pos, J_Supx, J_Supy, J_Supt)

    global main
    % check if on position is a bearing alredy
    hold = false;
    [~,N1] = size(main.Bearing);

    for i=1:N1
        if J_Pos == main.Bearing(1,i)
            hold = true;
            break;
        end
    end

    if hold == false 
        % if there was no bearing go on
        helpJ = [J_Pos; J_Supx; J_Supy; J_Supt; 0];               % Integrate values to help vector

        % Connect vectors with each other & Update Structure
        main.Joint = cat(2, main.Joint, helpJ);

        ImpOrder(5);                      % Create ID
    else
        % if beraing is there set bearing B_supt to 0
            % and dont implement sepperate joint
        main.Bearing(4,i) = 0;
    end

end