function schnittgroessen_foeppl_klammer()
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
    Streckenlasten = zeros(nStreckenlasten, 4);
    for i = 1:nStreckenlasten
        Streckenlasten(i, 1) = input(['Startposition der Streckenlast ' num2str(i) ' (m): ']);
        Streckenlasten(i, 2) = input(['Endposition der Streckenlast ' num2str(i) ' (m): ']);
        Streckenlasten(i, 3) = input(['Startgröße der Streckenlast ' num2str(i) ' (N/m): ']);
        Streckenlasten(i, 4) = input(['Endgröße der Streckenlast ' num2str(i) ' (N/m): ']);
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
    Q = zeros(size(x));
    M = zeros(size(x));

    % Berechnung der Querkraft (Q) und des Biegemoments (M) mittels Superpositionsprinzip
    for i = 1:nKraefte
        pos = Kraefte(i, 1);
        kraft = Kraefte(i, 2);
        Q(x >= pos) = Q(x >= pos) + kraft;
    end

    for i = 1:nStreckenlasten
        start = Streckenlasten(i, 1);
        ende = Streckenlasten(i, 2);
        startLast = Streckenlasten(i, 3);
        endLast = Streckenlasten(i, 4);
        % Lineare Streckenlast
        for j = 1:length(x)
            if x(j) >= start && x(j) <= ende
                last = startLast + (endLast - startLast) * (x(j) - start) / (ende - start);
                Q(j) = Q(j) + last * dx;
            elseif x(j) > ende
                Q(j) = Q(j) + ((startLast + endLast) / 2) * (ende - start);
            end
        end
    end

    for i = 1:nMomente
        pos = Momente(i, 1);
        moment = Momente(i, 2);
        M(x >= pos) = M(x >= pos) + moment;
    end

    % Integration der Querkraft um das Biegemoment zu berechnen
    for i = 2:length(x)
        M(i) = M(i-1) + Q(i-1) * dx;
    end

    % Plotten der Schnittgrößen
    figure;
    subplot(2,1,1);
    plot(x, Q);
    title('Querkraft (Q)');
    xlabel('Position (m)');
    ylabel('Kraft (N)');

    subplot(2,1,2);
    plot(x, M);
    title('Biegemoment (M)');
    xlabel('Position (m)');
    ylabel('Moment (Nm)');
end
