syms x
gloabal main;

%define as floats
q = 0.0;
F=0.0
Mb=0.0;

%as referece to the main sttructure
% main = struct('Force', [], 'Tourk', [], 'Distl', [],'Bearing', [],'Joint', []);
% 
% % Add matrixes for later load information
% Finf = zeros(3,0);       % Forces martix (pos, angle, value)
% Tinf = zeros(2,0);       % Tourk matrix (pos, value)
% Dinf = zeros(6,0);       % Dist load matrix (Startpos, Endpos, Startvalue, sign (pos=1/neg=-1), Exponent, Formula)
% Binf = zeros(4,0);       % Beraing load matrix (pos, support in x, support in y, support in Tourque)
% Jinf = zeros(4,0);       % Joint load matrix (pos, support in x, support in y, support in Tourque)


% Variablen angepasst an main.structure

%Zusammensetzung der Querkraftgleichung

[~, j1] = size(main.Distl); %Ermitteln der Spalten von Distl
for i = 1:j1-1
    q = q + main.Distl(3, i)*heaviside(x - main.Distl(1, i))+[main.Distl(6, i) * (x-main.Distl(1, i))^main.Distl(5, i) * heaviside(x - main.Distl(1, i)) - main.Distl(6, i) * (x-main.Distl(1, i))^main.Distl(2, i) * heaviside(x - main.Distl(2, i))];
end

F = -int(q, x);

[~, j2] = size(main.Force);
for i = 1:j2
    F = F + main.Force(3,i) * sind(main.Force(2,i)) * heaviside(x - main.Force(1,i));
end

Mb = int(F, x);

[~, j] = size(main.Tourk);
for i = 1:length(Mbvalue)
    Mb = Mb + main.Tourk(2,i) * heaviside(x - main.Tourk(1,i));
end

l=4;

subplot(3, 1, 1);
fplot(q,[0,l]);
grid on;

subplot(3, 1, 2);
fplot(Fn,[0,l]);
grid on;

subplot(3, 1, 3);
fplot(Mb,[0,l]);
grid on;
% 
% for i = 1:length(qvalue)
%     q = q + qvalue(i) * (x-qposa)^qexp(i) * heaviside(x - qposa(i)) - qvalue(i) * (x-qposa)^qexp(i) * heaviside(x - qposb(i));
% end
% 
% Fn = -int(q, x);
% 
% 
% for i = 1:length(Fvalue)
%     Fn = Fn + Fvalue(i) * sind(Fangle(i)) * heaviside(x - Fpos(i));
% end
% 
% Mb = int(Fn, x);
% 
% for i = 1:length(Mbvalue)
%     Mb = Mb + Mbvalue(i) * heaviside(x - Mbpos(i));
% end
% 
% l=4;
% 
% subplot(3, 1, 1);
% fplot(q,[0,l]);
% grid on;
% 
% subplot(3, 1, 2);
% fplot(Fn,[0,l]);
% grid on;
% 
% subplot(3, 1, 3);
% fplot(Mb,[0,l]);
% grid on;