function [q, Fz, Mb, Fx] = calcformulasanalytic(l)
    
    bearingReactions = cell(2, 4);
    syms x
    global main results;
    
    q = 0.0;
    Mb = 0.0;
    Fz = 0.0;
    Fx = 0.0;

    j1 = length(main.Distl.StartPos); 
    for i = 1:j1
        x0 = main.Distl.StartPos(i);
        x1 = main.Distl.EndPos(i);
        q0 = main.Distl.StartValue(i);
        expn = main.Distl.Exponent(i);
        pitch = main.Distl.Pitch(i);

        q = q + q0 * heaviside(x - x0) ...
            + (pitch * (x - x0)^expn * heaviside(x - x0) ...
            - pitch * (x - x0)^expn * heaviside(x - x1)) ...
            - q0 * heaviside(x - x1);
    end

    Fz = -int(q, x);

    j2 = length(main.Force.Position);
    for i = 1:j2
        xF = main.Force.Position(i);
        phi = main.Force.Angle(i);
        val = main.Force.Value(i);

        Fz = Fz - val * sind(phi) * heaviside(x - xF);
        Fx = Fx + val * cosd(phi) * heaviside(x - xF);
    end

    jBear = length(main.Bearing.Position);

    if jBear ~= 0
        Fxl = subs(Fx, x, l);
    end

    for i = 1:jBear
        xB = main.Bearing.Position(i);
        hasFz = main.Bearing.ZSupport(i);
        hasFx = main.Bearing.XSupport(i);
        hasM = main.Bearing.TSupport(i);

        if hasFx == 1
            Fx = Fx - Fxl * heaviside(x - xB);
            bearingReactions{i, 2} = -double(Fxl);
            break;
        end
    end

    vars = [];
    k = 1;
    for i = 1:jBear
        xB = main.Bearing.Position(i);
        hasFz = main.Bearing.ZSupport(i);
        hasFx = main.Bearing.XSupport(i);
        hasM = main.Bearing.TSupport(i);

        if hasFz == 1
            varName = ['F' num2str(k)];
            eval([varName ' = sym(varName);']);
            Fz = Fz + eval(varName) * heaviside(x - xB);
            vars = [vars, eval(varName)];
            k = k + 1;
        end
    end

    Mb = int(Fz, x);

 
    j3 = length(main.Torque.Position);
    for i = 1:j3
        xT = main.Torque.Position(i);
        valT = main.Torque.Value(i);
        Mb = Mb - valT * heaviside(x - xT);
    end

    k = 1;
    for i = 1:jBear
        xB = main.Bearing.Position(i);
        hasFz = main.Bearing.ZSupport(i);
        hasFx = main.Bearing.XSupport(i);
        hasM = main.Bearing.TSupport(i);

        if hasM == 1
            varName = ['M' num2str(k)];
            eval([varName ' = sym(varName);']);
            Mb = Mb + eval(varName) * heaviside(x - xB);
            vars = [vars, eval(varName)];
            k = k + 1;
        end
    end

    boundary_conditions = [subs(Fz, x, l*1.01) == 0, subs(Mb, x, l*1.01) == 0];

    jJoint = length(main.Joint.Position);
    for jj = 1:jJoint
        xJ = main.Joint.Position(jj);
        freeX = main.Joint.XSupport(jj);
        freeZ = main.Joint.ZSupport(jj);
        freeM = main.Joint.TSupport(jj);

        if freeZ == 0
            boundary_conditions = [boundary_conditions, subs(Fz, x, xJ) == 0];
        end
        if freeX == 0
            boundary_conditions = [boundary_conditions, subs(Fx, x, xJ) == 0];
        end
        if freeM == 0
            boundary_conditions = [boundary_conditions, subs(Mb, x, xJ) == 0];
        end
    end

    sol = solve(boundary_conditions, vars);


    Fz = subs(Fz, vars, struct2array(sol));
    Mb = subs(Mb, vars, struct2array(sol));

    results.Fz=Fz;
    results.Fx=Fx;
    results.Mb=Mb;

    disp('Lagerreaktionen:');
    disp(sol);
    disp('Funktion Fz(x):');
    disp(Fz);
    disp('Funktion Mb(x):');
    disp(Mb);


   
    feldNamen = fieldnames(sol);
    F_felder = feldNamen(startsWith(feldNamen, 'F'));

    solF = rmfield(sol, setdiff(feldNamen, F_felder));
    matrixWerte = cell2mat(cellfun(@double, struct2cell(solF), 'UniformOutput', false));

    disp('Matrix mit den numerischen Werten der F-Felder:');
    disp(matrixWerte);

    % bearingReactions{1, 3} = getfield(sol, 'F1', 'default', 0);
    % bearingReactions{2, 3} = getfield(sol, 'F2', 'default', 0);
    % bearingReactions{1, 4} = getfield(sol, 'M1', 'default', 0);
    % bearingReactions{2, 4} = getfield(sol, 'M2', 'default', 0);
    % 
    % myApp.UITable.Data = bearingReactions;
end
