 function [q,F,Mb] = calcformulas(l)
    
    myApp = dispData;
    syms x C1 C2
    global main;

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
    


    % Implementing bearing forces
   [~,P1] = size(main.Bearing); % Ermitteln ser Spalten von Bearing
   [Lag] = akg(l);
    for i=1:P1
        if (main.Bearing(1,i) ~= 0) && (main.Bearing(1,i) ~= l)
            BF = BF * heaviside(x - main.Bearing(1,i));
        else
            BF = 0;
        end
    end


    

    [~, j2] = size(main.Force);
    for i = 1:j2
        F = F - main.Force(3,i) * sind(main.Force(2,i)) * heaviside(x - main.Force(1,i)) ; %+ BF
        Fn= Fn - main.Force(3,i) * cosd(main.Force(2,i)) * heaviside(x - main.Force(1,i));
    end


   %Fn fertigstellen

    if j2~=0
        Fnl=subs(Fn, x, 20);
    end
    for i=1:j2
        if main.Bearing(3,i)==1
              Fn=Fn - Fnl * heaviside(x-main.Bearing(1,i));
            break
        end
    end


    Mb =int(F, x);

    [~, j3] = size(main.Torque);
    for i = 1:j3
        Mb = Mb - main.Torque(2,i) * heaviside(x - main.Torque(1,i));
    end
    
    
    [C1,C2] = calcze (Mb,F,l);
    %matlabFunktion(C1);

   F=F+C1;
   Mb=Mb+C1 * x + C2;

   %fplot(myApp.UIAxes, q, [0,l]);
   fplot(myApp.UIAxes, F, [0,l]);
   fplot(myApp.UIAxes3, Mb, [0,l]);
   fplot(myApp.UIAxes2, Fn, [0,l]);


    % subplot(4, 1, 1);
    % fplot(q,[0,l]);
    % title('q');
    % ylabel('N/m');
    % xlabel('m');
    % grid on;
    % 
    % subplot(4, 1, 2);
    % fplot(F,[0,l]);
    % title('Fq');
    % ylabel('N');
    % xlabel('m');
    % grid on;
    % 
    % subplot(4, 1, 3);
    % fplot(Mb,[0,l]);
    % title('Mb');
    % ylabel('Nm');
    % xlabel('m');
    % grid on;
    % 
    % subplot(4, 1, 4);
    % fplot(Fn,[0,l]);
    % title('Fn');
    % ylabel('Fn');
    % xlabel('m');
    % grid on;

end