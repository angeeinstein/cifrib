clear
clc
% Import the symbolic toolbox
syms x

% Define the beam length
L = input('Länge des Trägers (m): ');

% Define the number of point loads, distributed loads and moments
nKraefte = input('Anzahl der Kräfte: ');
nStreckenlasten = input('Anzahl der Streckenlasten: ');
nMomente = input('Anzahl der Momente: ');

% Initialize the loads
Kraefte = zeros(nKraefte, 2);
Streckenlasten = zeros(nStreckenlasten, 4); % [start, end, q_start, q_end]
Momente = zeros(nMomente, 2);

% Input the point loads
for i = 1:nKraefte
    Kraefte(i, 1) = input(['Position der Kraft ' num2str(i) ' (m): ']);
    Kraefte(i, 2) = input(['Größe der Kraft ' num2str(i) ' (N): ']);
end

% Input the distributed loads
for i = 1:nStreckenlasten
    Streckenlasten(i, 1) = input(['Startposition der Streckenlast ' num2str(i) ' (m): ']);
    Streckenlasten(i, 2) = input(['Endposition der Streckenlast ' num2str(i) ' (m): ']);
    Streckenlasten(i, 3) = input(['Startgröße der Streckenlast ' num2str(i) ' (N/m): ']);
    Streckenlasten(i, 4) = input(['Endgröße der Streckenlast ' num2str(i) ' (N/m): ']);
end

% Input the moments
for i = 1:nMomente
    Momente(i, 1) = input(['Position des Moments ' num2str(i) ' (m): ']);
    Momente(i, 2) = input(['Größe des Moments ' num2str(i) ' (Nm): ']);
end

% Initialize the shear force (Q) and bending moment (M) functions
Q = sym(0);
M = sym(0);

% Add contributions from point loads
for i = 1:nKraefte
    pos = Kraefte(i, 1);
    kraft = Kraefte(i, 2);
    Q = Q + kraft * heaviside(x - pos);
end

% Add contributions from distributed loads
for i = 1:nStreckenlasten
    start = Streckenlasten(i, 1);
    stop = Streckenlasten(i, 2);
    q_start = Streckenlasten(i, 3);
    q_end = Streckenlasten(i, 4);
    
    % Linear distributed load contribution
    q = q_start + (q_end - q_start) / (stop - start) * (x - start);
    Q = Q + int(q, x, start, x) * (heaviside(x - start) - heaviside(x - stop));
end

% Add contributions from moments
for i = 1:nMomente
    pos = Momente(i, 1);
    moment = Momente(i, 2);
    M = M + moment * heaviside(x - pos);
end

% Calculate the bending moment by integrating the shear force
M = M + int(Q, x);

% Simplify the expressions
Q = simplify(Q);
M = simplify(M);

% Plotting
x_lim_high = L;
x_lim_low = 0;
y_lim_high = max(double(subs(Q, x, linspace(x_lim_low, x_lim_high, 1000)))) + 10;
y_lim_low = min(double(subs(Q, x, linspace(x_lim_low, x_lim_high, 1000)))) - 10;

figure;

% Plot shear force
subplot(2, 1, 1);
fplot(Q, [x_lim_low, x_lim_high], 'r');
xlim([x_lim_low, x_lim_high]);
ylim([y_lim_low, y_lim_high]);
title('Querkraft (Q)');
xlabel('Position (m)');
ylabel('Kraft (N)');

% Plot bending moment
subplot(2, 1, 2);
fplot(M, [x_lim_low, x_lim_high], 'b');
xlim([x_lim_low, x_lim_high]);
ylim([min(double(subs(M, x, linspace(x_lim_low, x_lim_high, 1000)))) - 10, ...
      max(double(subs(M, x, linspace(x_lim_low, x_lim_high, 1000)))) + 10]);
title('Biegemoment (M)');
xlabel('Position (m)');
ylabel('Moment (Nm)');

% Display the shear force and bending moment equations
disp('Querkraft Q(x):');
disp(Q);
disp('Biegemoment M(x):');
disp(M);
