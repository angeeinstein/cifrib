function [q, Fz, Mb, Fx] = calcformulas(l)

    global  main results SSE;


    k=length(main.Bearing.Position);

    BearingLeftToRight = nan (4,k);
    BearingLeftToRight(1,:)=main.Bearing.Position;
    BearingLeftToRight(2,:)=main.Bearing.XSupport;
    BearingLeftToRight(3,:)=main.Bearing.ZSupport;
    BearingLeftToRight(4,:)=main.Bearing.TSupport;

    [~, sortIdx] = sort(BearingLeftToRight(1,:)); 
    BearingLeftToRight = BearingLeftToRight(:, sortIdx);





    q = @(x) 0;

    j1 = length(main.Distl.StartPos); 
    for i = 1:j1
        x0    = main.Distl.StartPos(i);
        x1    = main.Distl.EndPos(i);
        q0    = main.Distl.StartValue(i);
        expn  = main.Distl.Exponent(i);
        pitch = main.Distl.Pitch(i);

        q = @(x) q(x) ...
            + q0        .* ((x - x0) > 0) ...
            + pitch.*( (x - x0).^expn .* ((x - x0)>0) ) ...
            - pitch.*( (x - x0).^expn .* ((x - x1)>0) ) ...
            - q0        .* ((x - x1) > 0);
    end

    options = odeset('RelTol', 1e-9, 'AbsTol', 1e-12); % Beispielwerte für hohe Genauigkeit
    q_odefun = @(x, Fval) -q(x);
    x_span   = [0, l];
    F0       = 0;
    [x_num, F_num] = ode23s(q_odefun, x_span, F0,options);

    F_int = @(x) interp1(x_num, F_num, x, 'linear', 'extrap');

    Fz = @(x) F_int(x);

    Fx_int = @(x) 0;

    Fx = @(x) Fx_int(x);

    j2 = length(main.Force.Position);
    for i = 1:j2
        xF   = main.Force.Position(i);    % Position
        phi  = main.Force.Angle(i);    % Winkel in Grad
        val  = main.Force.Value(i);    % Betrag

        % Vertikaler (z-)Anteil:
        Fz = @(xx) Fz(xx) - val * sind(phi) * ((xx - xF) > 0);

        % Horizontaler (x-)Anteil:
        Fx = @(xx) Fx(xx) - val * cosd(phi) * ((xx - xF) > 0);
    end


    jBear = length(main.Bearing.Position);
   

    symsVec = [];
    idxMap  = {};

    for i = 1:jBear
       xB    =  BearingLeftToRight(1,i);
       hasFx =  BearingLeftToRight(2,i);  % 1 => Rx
       hasFz =  BearingLeftToRight(3,i);  % 1 => Rz
       hasM  =  BearingLeftToRight(4,i);  % 1 => Einspannungsmoment

       if hasFz == 1
           % Neue Unbekannte Rz:
           varName = sprintf('Rz%d', i);
           symsVec = [symsVec; 0];       % Startwert 0
           idxMap{end+1} = varName;      % Merke Index
       end
       if hasFx == 1
           % Neue Unbekannte Rx:
           varName = sprintf('Rx%d', i);
           symsVec = [symsVec; 0]; 
           idxMap{end+1} = varName;
       end
       if hasM == 1
           varName = sprintf('Mz%d', i);
           symsVec = [symsVec; 0];
           idxMap{end+1} = varName;
       end
    end

    function val = Fz_reactions(xx, unknow)
        val = 0;
        cntLocal = 0;
        for ib = 1:jBear
            xB    =  BearingLeftToRight(1,ib);
            hasFz =  BearingLeftToRight(3,ib);
            hasFx =  BearingLeftToRight(2,ib);
            hasM  =  BearingLeftToRight(4,ib);

            if hasFz==1
                cntLocal = cntLocal+1; 
                val = val + unknow(cntLocal)*((xx - xB)>0);
            end
            if hasFx==1
            end
            if hasM==1
            end
        end
    end

    function val = Fx_reactions(xx, unknow)
        val = 0;
        cntLocal = 0;
        for ib = 1:jBear
            xB    =  BearingLeftToRight(1,ib);
            hasFz =  BearingLeftToRight(3,ib);
            hasFx =  BearingLeftToRight(2,ib);
            hasM  =  BearingLeftToRight(4,ib);

            if hasFz==1
                cntLocal = cntLocal+1; 
                %val = val + unknow(cntLocal)*((xx - xB)>0);
            end
            if hasFx==1
                cntLocal = cntLocal+1;
                 val = val + unknow(cntLocal)*((xx - xB)>0);
            end
            if hasM==1
                cntLocal = cntLocal+1;
            end
        end
    end

    % Punktlastanteil an Fz:
    function val = Fz_pointloads(xx)
        val = 0;
        for ii = 1:j2
            xF   = main.Force.Position(ii);
            phi  = main.Force.Angle(ii);
            valF = main.Force.Value(ii);
            val = val - valF * sind(phi)*((xx - xF) > 0);
        end
    end

    % Punktlastanteil an Fx:
    function val = Fx_pointloads(xx)
        val = 0;
        for ii = 1:j2
            xF   = main.Force.Position(ii);
            phi  = main.Force.Angle(ii);
            valF = main.Force.Value(ii);
            val = val - valF * cosd(phi)*((xx - xF) > 0);
        end
    end

    Fz_full = @(xx, unknow) F_int(xx) + Fz_pointloads(xx) + Fz_reactions(xx, unknow);
    Fx_full = @(xx, unknow) Fx_int(xx) + Fx_pointloads(xx) + Fx_reactions(xx, unknow);

    function val = Fz_int_pointloads(xx)
       val = F_int(xx) + Fz_pointloads(xx);
    end

    [x_numM, M_num] = ode23s(@(xx, Mv) Fz_int_pointloads(xx), x_span, 0);
    M_int = @(xx) interp1(x_numM, M_num, xx, 'linear', 'extrap');

    j3 = length(main.Torque.Position);

    function val = M_torque(xx)
       val = 0;
       for iT = 1:j3
           xT   = main.Torque.Position(iT);
           valT = main.Torque.Value(iT);
           val = val + valT*((xx - xT)>0);
       end
    end

    function val = M_reaction(xx, unknow)
        val = 0;
        cntLocal = 0;
        for ib = 1:jBear
           xB    =  BearingLeftToRight(1,ib);
           hasFz =  BearingLeftToRight(3,ib);
           hasFx =  BearingLeftToRight(2,ib);
           hasM  =  BearingLeftToRight(4,ib);

           % Rz -> linearer Hebelarm => Rz * (xx - xB)
           if hasFz==1
               cntLocal = cntLocal + 1;
               RzVal = unknow(cntLocal);
               val = val + RzVal * max((xx - xB),0);
           end

           if hasFx==1
               cntLocal = cntLocal + 1; 
           end

           % Falls hasM=1 => direkter Einspannmoment
           if hasM==1
               cntLocal = cntLocal + 1;  % MzVal
               MzVal = unknow(cntLocal);

               val = val + MzVal*((xx - xB)>0);
           end
        end
    end

    Mb_full = @(xx, unknow) M_int(xx) + M_torque(xx) + M_reaction(xx, unknow);

    function res = residual(unknow)
        resCnt = 1;
        res = [];

        res(resCnt) = Fx_full(l, unknow);
        resCnt = resCnt+1;     
        
        res(resCnt) = Fz_full(l, unknow);
        resCnt = resCnt+1;

        res(resCnt) = Mb_full(l, unknow);
        resCnt = resCnt+1;


        jJoint = length(main.Joint.Position);
        for jj=1:jJoint
            xJ   = main.Joint.Position(jj);
            freeX = main.Joint.XSupport(jj); 
            freeZ = main.Joint.ZSupport(jj);
            freeM = main.Joint.TSupport(jj);

            if freeZ==0
                res(resCnt) = Fz_full(xJ, unknow);
                resCnt = resCnt+1;
            end
            if freeX==0
                res(resCnt) = Fx_full(xJ, unknow);
                resCnt = resCnt+1;
            end

            if freeM==0
                res(resCnt) = Mb_full(xJ, unknow);
                resCnt = resCnt+1;
            end
        end
    end

    initGuess = ones(length(symsVec),1);  % Startwert 0
    options = optimset('Display','iter', ...        % zum Anzeigen des Iterationsfortschritts
                   'MaxIter',    50000, ...
                   'MaxFunEvals', 15000000);
    [sol, fval, exitflag, output] = fsolve(@residual, initGuess, options);
    q_old = q;
    SSE = sum(fval.^2);

    % Finale Fz(x)- und Mb(x)-Funktionen:
    Fz = @(xx) Fz_full(xx, sol);
    Mb = @(xx) Mb_full(xx, sol);
    Fx = @(xx) Fx_full(xx, sol);

% if ~isempty(main.Joint.Position)  % Falls Gelenke existieren
%     Mb_modified = @(xx) Mb(xx)- M_torque(xx)- M_reaction(xx, sol);
% 
%     x_vals = linspace(0, l, 20000); % Diskretisierung
%     Mb_vals = arrayfun(Mb_modified, x_vals); % Modifizierte Momentwerte
% 
%     % Numerische Ableitung
%     dMb_dx = gradient(Mb_vals, x_vals);
% 
%     % Erstelle numerische Ableitungsfunktion für Fz
%     Fz_modified = @(xx) interp1(x_vals, dMb_dx, xx, 'nearest', 'extrap');
% 
%     % Speichere das korrigierte Fz in results
%     results.Fz = Fz_modified;
% else
% 
% end

    results.Fz = Fz;
    results.Mb = Mb;
    results.Fx = Fx;

    % Auflagerreaktionen protokollieren:
    bearingReactions = nan(jBear,4);
    cnt = 0;
    indx=[];
    for ib=1:jBear
        hasFz =  BearingLeftToRight(3,ib);
        hasFx =  BearingLeftToRight(2,ib);
        hasM  = BearingLeftToRight(4,ib);
        
        RxVal = NaN; RzVal = NaN; MzVal = NaN;

        if hasFz==1
            cnt=cnt+1;
            RzVal = sol(cnt);
        end
        if hasFx==1
            cnt=cnt+1;
            RxVal = sol(cnt);
        end
        if hasM==1
            cnt=cnt+1;
            MzVal = sol(cnt);
        end

        bearingReactions(ib,:) = [ib,RxVal,RzVal, MzVal];
    end

    if BearingLeftToRight(1,jBear)==l
    bearingReactions(jBear, :) = [jBear, -results.Fx(l), -results.Fz(l), NaN];
    end

    results.BearingForces = bearingReactions;

    %######################################################
    % figure; hold on; grid on;
    % xPlot = linspace(0,l,200);
    % 
    % plot(xPlot, arrayfun(q_old, xPlot),  'b', 'LineWidth',1.5);
    % plot(xPlot, arrayfun(Fz, xPlot),     'r', 'LineWidth',1.5);
    % plot(xPlot, arrayfun(Mb, xPlot),     'g', 'LineWidth',1.5);
    % plot(xPlot, arrayfun(Fx, xPlot),     'm', 'LineWidth',1.5);
    % legend('q_z(x)','F_z(x)','M_b(x)','F_x(x)');
    % title('Verteilte Last, Scherkraft, Moment, und horizontale Kraft');
    %ver2
end