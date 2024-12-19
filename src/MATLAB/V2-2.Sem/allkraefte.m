function [B1, B2] = akg(l)

global main;
syms B1 B2

% für Fortnite
lenght=l;
    %define as floats
    q = 0.0;
    F=0.0;
    Fn=0.0;
    Mb=0.0;

[~, j1] = size(main.Distl); %Ermitteln der Spalten von Distl
    for i = 1:j1
        %(1-Startpos, 2-Endpos, 3-Startvalue, 4-sign (pos=1/neg=-1), 5-Exponent, 6-pitch-k)
        %       |   startvalue on startposition                 |      fuction on - transformed in global coordinates (very left ==> x=0;)                   | function off 
        q = q + main.Distl(3, i)*heaviside(x - main.Distl(1, i))+(main.Distl(6, i) * (x-main.Distl(1, i))^main.Distl(5, i) * heaviside(x - main.Distl(1, i)) - main.Distl(6, i) * (x-main.Distl(1, i))^main.Distl(5, i) * heaviside(x - main.Distl(2, i)))- main.Distl(3, i)*heaviside(x - main.Distl(2, i));
    end

    F = -int(q, x);

     [~, j2] = size(main.Force);
    for i = 1:j2
        F = F - main.Force(3,i) * sind(main.Force(2,i)) * heaviside(x - main.Force(1,i)) ; 
        Fn= Fn - main.Force(3,i) * cosd(main.Force(2,i)) * heaviside(x - main.Force(1,i));
    end

     Mb =int(F, x);

    [~, j3] = size(main.Torque);
    for i = 1:j3
        Mb = Mb - main.Torque(2,i) * heaviside(x - main.Torque(1,i));
    end

% Summe aller kräfte
    SF = 0;

    % go throu all external Forces
        % all Force Forces
        [~,F1] = main.Force;
        for i=1:F1
            SF = SF + main.Force(1,i) * sin(main.Force(3,i));
        end
        
        % all Line lods
            [~,D1] = main.Distl;
            for i=1:D1
                switch main.Distl(5,i)
                    % rectangular Distl
                    case 0
                        SF = SF + (main.Distl(2,i)-main.Distl(1,i)) * main.Distl(6,i);
                    % line load
                    case 1
                        SF = SF + 1/sqrt(2) * mian.Distl(6,i);
                    % Quadratic load
                    case 2
                        SF = SF + 1/sqrt(3) * mian.Distl(6,i);
                end
            end
    % Add Bearing forces 
    SF = SF + B1 + B2;

% Summe aller Momente
    SM = 0;

    % go thrue all external Moments
        % all Moments 
            % all Force Forces
            for i=1:F1
                SM = SM + main.Force(1,i) * sin(main.Force(3,i)) * (main.Force(1,i));
            end

            % Line loads
            for i=1:D1
                switch main.Distl(5,i)
                    % rectangular Distl
                    case 0
                        SM = SM + (main.Distl(2,i)-main.Distl(1,i)) * main.Distl(6,i) * ((main.Distl(2,i)-main.Distl(1,i))/2+main.Distl(1,i));
                    % Rectangular load
                    case 1
                        SM = SM + 1/sqrt(2) * mian.Distl(6,i)* (2/3 * (main.Distl(2,i)-main.Distl(1,i))+main.Distl(1,i));
                    % Quadratic load
                    case 2
                        SM = SM + 1/sqrt(3) * mian.Distl(6,i)* main.Distl(1)+9/16*(main.Distl(2,i)-main.Distl(1,i));
                end
            end
end


% sum moment and force = 0




