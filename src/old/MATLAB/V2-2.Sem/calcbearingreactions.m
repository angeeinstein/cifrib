function [Fb,Fnb,Mb]=calcbearingreactions(q,Fn,Mb)

syms x

length=l;
vars=[];

[~, j] = size(main.Bearing);
k=1;
for i=1:j
if main.Bearing(2,i)==1
    varName = ['F' num2str(k)];
    eval([varName ' = sym(varName);']);
    F=F+eval(varName)*heavyside(x-main.Bearing(i,1));
    vars = [vars, eval(varName)]; 

    k=k+1;
end
end

Mb =int(F, x);

    [~, j3] = size(main.Torque);
    for i = 1:j3
        Mb = Mb - main.Torque(2,i) * heaviside(x - main.Torque(1,i));
    end

    
k=1;
for i=1:j
if main.Bearing(4,i)==1

    varName = ['M' num2str(k)];
    eval([varName ' = sym(varName);']);
    Mb=Mb+eval(varName)*heavyside(x-main.Bearing(i,1));
    vars = [vars, eval(varName)]; 
    k=k+1;
end
end

% An den Enden des Balkens sind die Lagerkräfte und -momente null
F_end_conditions = [subs(F, x, 0) == 0, subs(F, x, length) == 0];
M_end_conditions = [subs(M, x, 0) == 0, subs(M, x, length) == 0];

% Erstellen der Gleichungen aus den Randbedingungen
equations = [F_end_conditions, M_end_conditions];

% Gleichungssystem lösen

sol = solve(equations, vars);

% Ergebnisse extrahieren
Fb = (sol.F);
Fnb =(sol.Fn);
Mb = (sol.M);

end



