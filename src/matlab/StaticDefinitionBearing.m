function [Fixed] = StaticDefinitionBearing
global main 

% Fixed Variable
    Fixed = 0;

    j = length(main.Bearing.Position);
    for i = 1:j
        % Clamped Bearing
        if main.Bearing.XSupport(i) == 1 && main.Bearing.ZSupport(i) == 1 && main.Bearing.TSupport(i) == 1
            % Add 3 to Fixed
            Fixed = Fixed + 3;

        % Fixed Bearing
        elseif main.Bearing.XSupport(i) == 1 && main.Bearing.ZSupport(i) == 1 && main.Bearing.TSupport(i) == 0
            % Add 2 to Fixed
            Fixed = Fixed + 2;

        % Loose Bearing
        elseif main.Bearing.XSupport(i) == 0 && main.Bearing.ZSupport(i) == 1 && main.Bearing.TSupport(i) == 0
            % Add 1 to Fixed
            Fixed = Fixed + 1;

        end
    end