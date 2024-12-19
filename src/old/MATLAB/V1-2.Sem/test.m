clear
clc

syms x C


% x = 2;
% start = 2;
% (x(x > 4) -4) - 2



% define q1(x)
start = 2;  % start
stop = 6;  % end
a = 1;  % parameters
b = 1;
c = 0;
q1 = a * x^1 * (x > start);
disp(q1);

figure;
fplot(x, q1);