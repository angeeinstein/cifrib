% Assin Order IDs to main Structure
function ImpOrder(Ftyp)

    global main ImpInf loadID;

    helpI = [Ftyp; loadID + 1];         % Integrate values to help vector
    ImpInf = cat(2, ImpInf, helpI);     % Conect vectors with each other

    main.ImpInf = ImpInf;               % Update Structure(new)
    main.DelInf = zeros(8,0);           % Update Structure(reset)

end