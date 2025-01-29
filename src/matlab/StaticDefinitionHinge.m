function [Freed] = StaticDefinitionHinge
global main

 % Freedom Variable
    Freed = 3;

    j = length(main.Joint.Position);
    for i = 1:j
        % Moment Freedom
        if main.Joint.XSupport(i) == 1 && main.Joint.ZSupport(i) == 1 && main.Joint.TSupport(i) == 0
            % Add 1 to Freedom
            Freed = Freed + 1;

        % X Freedom
        elseif main.Joint.XSupport(i) == 0 && main.Joint.ZSupport(i) == 1 && main.Joint.TSupport(i) == 1
            % Add 1 to Freedom
            Freed = Freed + 1;
            
        % Y Freedom
        elseif main.Joint.XSupport(i) == 1 && main.Joint.ZSupport(i) == 0 && main.Joint.TSupport(i) == 1
            % Add 1 to Freedom
            Freed = Freed + 1;
        end
    end
end

