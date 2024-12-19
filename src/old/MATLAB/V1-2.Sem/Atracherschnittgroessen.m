-clear
clc
% % Import the symbolic toolbox
% syms x
% 
% % Define the symbolic function
% f = 5 * (x ^ 2 ) + 7 * x;
% 
% % Find the indefinite integral
% indefinite_integral = int(f, x);
% 
% % Display the result
% %disp('The indefinite integral of f(x) is:');
% disp(indefinite_integral);


% Import symbolic variables
syms x C 

% define q1(x)
start = 2;  % start
stop = 6;  % end
a = 1;  % parameters
b = 1;
c = 0;
d = 0;
e = 0;
exponent = 2; % exponent von q(x)
q1 = a * (x(x > start) - start); %(1 * (x-start)^2*heaviside(x-start)) - (1 * (x-stop)^2*heaviside(x-stop)) - (0 * (x-stop)^1*heaviside(x-stop));
q1 = a * x^2 * 
% define q2(x)
q2 = 0; %(1 * (x-start)^2*heaviside(x-start)) - (1 * (x-stop)^2*heaviside(x-stop)) - (0 * (x-stop)^1*heaviside(x-stop));


% Define the q(x) function
f = q1 + q2;    % add all q(x) together
%(x-a)^n*heaviside(x-a);

% Calculate the indefinite integral
indefinite_integral = int(f, x);

% Add a constant C to represent the constant of integration
indefinite_integral = indefinite_integral; % + C;

% Convert the symbolic expression to a function handle
indefinite_integral_handle = matlabFunction(indefinite_integral, 'Vars', [x C]);

% Define the value of the constant (for simplicity)
constant_value = 0;

% Create a function handle with the constant set
integral_with_constant = @(x) indefinite_integral_handle(x, constant_value);

% display integral
disp(indefinite_integral);

% define limits for plot
x_lim_high = 10;
x_lim_low = -10;
y_lim_high = 10;
y_lim_low = -10;

% figure
figure;

% first plot
subplot(2,1,1); 
fplot(x,f,'r');
xlim([x_lim_low, x_lim_high]);
ylim([y_lim_low, y_lim_high]);
title('f(x)')

% second plot
subplot(2,1,2);
fplot(x,integral_with_constant,'b');
xlim([x_lim_low, x_lim_high]);
ylim([y_lim_low, y_lim_high]);
title('F(x)');

% % Plot the function using fplot from 0 to 10
% fplot(integral_with_constant, [0, 10]);
% xlabel('x');
% ylabel('F(x)');
% title('Indefinite Integral of f(x) = 2 * x');
% grid on;