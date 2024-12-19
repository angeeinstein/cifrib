function [Freed] = StaticDefinitionHinge
global main

 % Freedom Variable
    Freed = 3;

    [~,j] = size(main.Joint);
    for i = 1:j
        % Moment Freedom
        if main.Joint(2,i) == 1 && main.Joint(3,i) == 1 && main.Joint(4,i) == 0
            % Add 1 to Freedom
            Freed = Freed + 1;

        % X Freedom
        elseif main.Joint(2,i) == 0 && main.Joint(3,i) == 1 && main.Joint(4,i) == 1
            % Add 1 to Freedom
            Freed = Freed + 1;
            
        % Y Freedom
        elseif main.Joint(2,i) == 1 && main.Joint(3,i) == 0 && main.Joint(4,i) == 1
            % Add 1 to Freedom
            Freed = Freed + 1;
        end
    end
end

