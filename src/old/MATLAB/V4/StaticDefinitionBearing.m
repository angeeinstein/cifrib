function [Fixed] = StaticDefinitionBearing
global main 

% Fixed Variable
    Fixed = 0;

    [~,j] = size(main.Bearing);
    for i = 1:j
        % Clamped Bearing
        if main.Bearing(2,i) == 1 && main.Bearing(3,i) == 1 && main.Bearing(4,i) == 1
            % Add 3 to Fixed
            Fixed = Fixed + 3;

        % Fixed Bearing
        elseif main.Bearing(2,i) == 1 && main.Bearing(3,i) == 1 && main.Bearing(4,i) == 0
            % Add 2 to Fixed
            Fixed = Fixed + 2;

        % Loose Bearing
        elseif main.Bearing(2,i) == 1 && main.Bearing(3,i) == 0 && main.Bearing(4,i) == 0
            % Add 1 to Fixed
            Fixed = Fixed + 1;

        end
    end