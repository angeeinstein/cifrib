 function [q,F,Mb] = calcformulas(l)
    
    myApp = dispData;

    syms x 
    global main;
q=0.0;
Mb=0.0;
F=0.0;
Fn=0.0;

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

   [~, j] = size(main.Bearing);

   %Fn Bearingforce
    if j2~=0

        Fnl=subs(Fn, x, l);
    end
    for i=1:j
        if main.Bearing(3,i)==1
              Fn=Fn - Fnl * heaviside(x-main.Bearing(1,i));
            break
        end
    end



vars = [];


k = 1;

for i = 1:j
    if main.Bearing(2,i) == 1
        varName = ['F' num2str(k)];
        eval([varName ' = sym(varName);']);
        F = F + eval(varName) * heaviside(x - main.Bearing(1,i));
        vars = [vars, eval(varName)];
        k = k + 1;
    end
end

Mb = int(F, x);

[~, j3] = size(main.Torque);
for i = 1:j3
    Mb = Mb - main.Torque(2,i) * heaviside(x - main.Torque(1,i));
end

k = 1;
for i = 1:j
    if main.Bearing(4,i) == 1
        varName = ['M' num2str(k)];
        eval([varName ' = sym(varName);']);
        Mb = Mb + eval(varName) * heaviside(x - main.Bearing(1,i));
        vars = [vars, eval(varName)];
        k = k + 1;
    end
end

boundary_conditions = [subs(F, x, l) == 0, subs(Mb, x, l) == 0];

sol = solve(boundary_conditions, vars);

F = subs(F, vars, struct2array(sol));
Mb = subs(Mb, vars, struct2array(sol));

disp('Lagerreaktionen:');
disp(sol);
disp('Funktion F(x):');
disp(F);
disp('Funktion Mb(x):');
disp(Mb);

   fplot(myApp.UIAxes, F, [0,l]);
   fplot(myApp.UIAxes3, Mb, [0,l]);
   fplot(myApp.UIAxes2, Fn, [0,l]);

end