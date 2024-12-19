function [F,Mb] = calcbearingreactions(F,Mb,l)

syms x
global main;

vars = [];

[~, j] = size(main.Bearing);
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
