function integral_str = integrate_string(expr)
    % Extrahiere Koeffizient a und Exponent b aus dem String 'a*x^b'
    pattern = '([+-]?\d+)\*x\^(\d+)';
    tokens = regexp(expr, pattern, 'tokens');

    % Wandle die gefundenen Werte in Zahlen um
    a = str2double(tokens{1}{1});
    b = str2double(tokens{1}{2});
    
    % Wende die Potenzregel der Integration an
    b = b + 1;
    result = (a / b) * sprintf('x^%d', b);

    % Setze das Ergebnis als String zusammen
    integral_str = sprintf('%.4f%s + C', a / b, result);
end
