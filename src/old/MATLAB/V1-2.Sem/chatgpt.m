function schnittgroessen_berechnen_und_plotten()
    % Eingabe der Trägerlänge
    L = input('Länge des Trägers (m): ');

    % Eingabe der Kräfte
    nKraefte = input('Anzahl der Kräfte: ');
    Kraefte = zeros(nKraefte, 2);
    for i = 1:nKraefte
        Kraefte(i, 1) = input(['Position der Kraft ' num2str(i) ' (m): ']);
        Kraefte(i, 2) = input(['Größe der Kraft ' num2str(i) ' (N): ']);
    end

    % Eingabe der Streckenlasten
    nStreckenlasten = input('Anzahl der Streckenlasten: ');
    Streckenlasten = zeros(nStreckenlasten, 3);
    for i = 1:nStreckenlasten
        Streckenlasten(i, 1) = input(['Startposition der Streckenlast ' num2str(i) ' (m): ']);
        Streckenlasten(i, 2) = input(['Endposition der Streckenlast ' num2str(i) ' (m): ']);
        Streckenlasten(i, 3) = input(['Größe der Streckenlast ' num2str(i) ' (N/m): ']);
    end

    % Eingabe der Momente
    nMomente = input('Anzahl der Momente: ');
    Momente = zeros(nMomente, 2);
    for i = 1:nMomente
        Momente(i, 1) = input(['Position des Moments ' num2str(i) ' (m): ']);
        Momente(i, 2) = input(['Größe des Moments ' num2str(i) ' (Nm): ']);
    end

    % Diskretisierung des Trägers
    dx = 0.01;
    x = 0:dx:L;

    % Initialisierung der Schnittgrößen
    N = zeros(size(x));
    Q = zeros(size(x));
    M = zeros(size(x));

    % Berechnung der Normalkraft (N)
    for i = 1:nKraefte
        pos = Kraefte(i, 1);
        kraft = Kraefte(i, 2);
        N(x >= pos) = N(x >= pos) + kraft;
    end

    % Berechnung der Querkraft (Q) und des Biegemoments (M)
    for i = 1:nStreckenlasten
        start = Streckenlasten(i, 1);
        ende = Streckenlasten(i, 2);
        last = Streckenlasten(i, 3);
        Q(x >= start) = Q(x >= start) + last * (x(x >= start) - start);
        Q(x > ende) = Q(x > ende) - last * (x(x > ende) - ende);
    end

    for i = 1:nMomente
        pos = Momente(i, 1);
        moment = Momente(i, 2);
        M(x >= pos) = M(x >= pos) + moment;
    end

    % Berechnung des Biegemoments (M)
    for i = 2:length(x)
        M(i) = M(i-1) + Q(i) * dx;
    end

    % Plotten der Schnittgrößen
    figure;
    subplot(3,1,1);
    plot(x, N);
    title('Normalkraft (N)');
    xlabel('Position (m)');
    ylabel('Kraft (N)');

    subplot(3,1,2);
    plot(x, Q);
    title('Querkraft (Q)');
    xlabel('Position (m)');
    ylabel('Kraft (N)');

    subplot(3,1,3);
    plot(x, M);
    title('Biegemoment (M)');
    xlabel('Position (m)');
    ylabel('Moment (Nm)');
end
