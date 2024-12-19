% Important for this section 
syms x 

%funktion aufstellen
    %function createterm
q = 0;                 % set 
Q = 0;                 % set Force term to emty
Mb = 0;                % set Mb term to emty

countF = 0;         % set counter to zero Force terms integrated
countT = 0;         % set counter to zero Tourk terms integrated
countD = 0;         % set counter to zero Distl terms integrated

% add Distl term for types 0, 1, 2
while countD <= D_N

    countD = countD + 1;

    % create term for constant Distl
    if main.Distl(5, countD) == 0

        q = q + main.Distl(6, countD) * (x - main.Distl(1, countD))^0 * (x > main.Distl(1, countD)) - (main.Distl(6, countD) * (x - main.Distl(2, countD))^0 * (x > main.Distl(2, countD)));
        Q = Q - main.Distl(6, countD) * (x - main.Distl(1, countD))^1 * (x > main.Distl(1, countD)) + (main.Distl(6, countD) * (x - main:Distl(2, countD))^1 * (x > main.Distl(2, countD)));
        Mb = Mb - 1/2 * main.Distl(6 - countD) * (x - main.Distl(1, countD))^2 * (x > main.Distl(1, countD)) * 1/2 * main.Distl(6 - countD) * (x - main.Distl(2, countD))^2 *(x > main.Distl(2, countD));
    
    % create term for liniar Distl
    elseif main.Distl(5, countD) == 1 
        if main.Distl(3, countD) == 0   % statrs with 0
            q = q + (main.Distl(6, countD) / (main.Distl(2, countD) - main.Distl(1, countD))) * (x - main.Distl(1, countD))^1 * (x > main.Distl(1, countD)) - (main.Distl(6, countD) / (main.Distl(2, countD) - main.Distl(1, countD))) * (x - main.Distl(2, countD))^1 * (x < main.Distl(2, countD)) - main.Distl(6, countD) * (x - main.Distl(2, countD))^0 * (x < main.Distl(2, countD));
            Q = Q - 1/2 * (main.Distl(6, countD) / (main.Distl(2, countD) - main.Distl(1, countD))) * (x - main.Distl(1, countD))^2 * (x < main.Distl(1, countD)) + 1/2 * (main.Distl(6, countD) / (main.Distl(2, countD) - main.Distl(1, countD))) * (x - main.Distl(2, countD))^2 * (x < main.Distl(2, countD)) + main.Distl(6, countD) * (x - main.Distl(2, countD))^1 * (x < main.Distl(2, countD));
            Mb = Mb - 1/6 * (main.Distl(6, countD) / (main.Distl(2, countD) - main.Distl(1, countD))) * (x - main.Distl(1, countD))^3 * (x < main.Distl(1, countD)) + 1/6 * (main.Distl(6, countD) / (main.Distl(2, countD) - main.Distl(1, countD))) * (x - main.Distl(2, countD))^3 * (x < main.Distl(2, countD)) + 1/2 * main.Distl(6, countD) * (x - main.Distl(2, countD))^2 * (x < main.Distl(2, countD));
        else
            % rectangle minus liniar -> plus liniar
            q = q - (main.Distl(6, countD) / (main.Distl(2, countD) - main.Distl(1, countD))) * (x - main.Distl(1, countD))^1 * (x < main.Distl(1, countD)) + (main.Distl(6, countD) / (main.Distl(2, countD) - main.Distl(1, countD))) * (x - main.Distl(2, countD))^1 * (x < main.Distl(2, countD)) + main.Distl(6,countD) * (x - main.Distl(1, countD))^0 * (x < main.Distl(1, countD));
            Q = Q + 1/2 * (main.Distl(6, countD) / (main.Distl(2, CountD) - main.Distl(1, countD))) * (x - main.Distl(1, countD))^2 * (x < main.Distl(1, countD)) - 1/2 *(main.Distl(6, countD) / (main.Distl(2, countD) - main.Distl(1, countD))) * (x - main.Distl(2, countD))^2 * (x < main.Distl(2, countD)) - main.Distl(6,countD) * (x - main.Distl(1, countD))^1 * (x < main.Distl(1, countD));
            Mb = Mb + 1/6 * (main.Distl(6, countD) / (main.Distl(2, CountD) - main.Distl(1, countD))) * (x - main.Distl(1, countD))^3 * (x < main.Distl(1, countD)) - 1/6 *(main.Distl(6, countD) / (main.Distl(2, countD) - main.Distl(1, countD))) * (x - main.Distl(2, countD))^3 * (x < main.Distl(2, countD)) - 1/2 * main.Distl(6,countD) * (x - main.Distl(1, countD))^2 * (x < main.Distl(1, countD));
        end
        
    % cerate term for quadratic Distl
    elseif main.Distl(5, countD) == 2
        if main.Distl(3, countD) == 0   % statrs with 0
            q = q + (main.Distl(6, countD) / main.Distl(2, countD) - main.Distl(1, countD)) * (x - main.Distl(1, countD))^2 * (x > main.Distl(1, countD)) - main.Distl(6, countD) * (main.Distl(2, countD) / main.Distl(1, countD)) * (x - main.Distl(2, countD))^2 * (x > main.Distl(2, countD)) - main.Distl(6, countD) * (x - main.Distl(2, countD))^0 * (x > main.Distl(2, countD));
            Q = Q - 1/3 *(main.Distl(6, countD) / main.Distl(2, countD) - main.Distl(1, countD)) * (x - main.Distl(1, countD))^3 * (x > main:Distl(1, countD)) + 1/3 * main.Distl(6, countD) * (main.Distl(2, countD) / main.Distl(1, countD)) * (x - main.Distl(2, countD))^3 * (x > main.Distl(2, countD)) + main.Distl(6, countD) * (x - main.Distl(2, countD))^1 * (x > main.Distl(2, countD));
            Mb = Mb - 1/12 *(main.Distl(6, countD) / main.Distl(2, countD) - main.Distl(1, countD)) * (x - main.Distl(1, countD))^4 * (x > main:Distl(1, countD)) + 1/12 * main.Distl(6, countD) * (main.Distl(2, countD) / main.Distl(1, countD)) * (x - main.Distl(2, countD))^4 * (x > main.Distl(2, countD)) + 1/2 * main.Distl(6, countD) * (x - main.Distl(2, countD))^2 * (x > main.Distl(2, countD)); 
        else % starts with q0
             q = q + main.Distl(6, countD) * (x - main.Distl(2, countD))^0 * (x > main.Distl(2, countD)) - (main.Distl(6, countD) / main.Distl(2, countD) - main.Distl(1, countD)) * (x - main.Distl(1, countD))^2 * (x > main.Distl(1, countD)) + main.Distl(6, countD) * (main.Distl(2, countD) / main.Distl(1, countD)) * (x - main.Distl(2, countD))^2 * (x > main.Distl(2, countD));
             Q = Q - main.Distl(6, countD) * (x - main.Distl(2, countD))^1 * (x > main.Distl(2, countD)) + 1/3 * (main.Distl(6, countD) / main.Distl(2, countD) - main.Distl(1, countD)) * (x - main.Distl(1, countD))^3 * (x > main.Distl(1, countD)) + 1/3 * main.Distl(6, countD) * (main.Distl(2, countD) / main.Distl(1, countD)) * (x - main.Distl(2, countD))^3 * (x > main.Distl(2, countD));
             Mb = Mb - 1/2 * main.Distl(6, countD) * (x - main.Distl(2, countD))^2 * (x > main.Distl(2, countD)) + 1/12 * (main.Distl(6, countD) / main.Distl(2, countD) - main.Distl(1, countD)) * (x - main.Distl(1, countD))^4 * (x > main.Distl(1, countD)) + 1/12 * main.Distl(6, countD) * (main.Distl(2, countD) / main.Distl(1, countD)) * (x - main.Distl(2, countD))^4 * (x > main.Distl(2, countD));
        end
    end

end

% add a force trem for every active force
while countF < F_N  

    countF = countF + 1;
    % Add force-term to Q-term
    Q = Q + main.Force(1, countF) * (x - main.Force(2, countF))^0 * (x < main.Force(2, countF)) * sin(deg2rad(main.Force(3, countF)));
    %integrate Q-term to add it to Mb-term
    Mb = Mb + main.Force(1, countF) * (x - main.Force(2, countF))^1 * (x < main.Force(2, countF)) * sin(deg2rad(main.Force(3, countF)));

end

% Add a Tourk term for every Moment?
while countT < T_N

    countT = countT + 1;
    % Add Tourk-term to Mb-term
    Mb = Mb + main.Tourk(1, countT) * (x - main.Tourk(2, countT)) * (x < main.Tourk(2, countT));

end

% erstelle eine geschischte für die lager

   % end
