function [q_sample, Fz_sample, Mb_sample, Fx_sample] = calcformulasanalytico3(l)
% calcformulasanalytico3
%   Computes q(x), Fz(x), Mb(x) and Fx(x) for a beam by summing terms of the
%   form F * ⟨x - pos⟩^power (with ⟨·⟩ equal to (x-pos) for x>=pos and 0 otherwise).
%   Integration is done term‐by‐term (power rule) so no symbolic toolbox is needed.
%   Unknown reaction coefficients (from bearings) are determined via boundary
%   and joint conditions.
%
%   Global structures "main" and "results" provide input data and store outputs.
%
%   INPUT:
%       l    – the beam length (used for evaluating boundary conditions)
%
%   OUTPUT:
%       q_sample, Fz_sample, Mb_sample, Fx_sample – numeric vectors (sampled along x)
%           for plotting or further processing.

    global main results;
    
    %% 1. Build the distributed load function q(x)
    q_terms = [];  % each term is a struct with fields: F, pos, power, isUnknown, unknownIndex
    j1 = length(main.Distl.StartPos);
    for i = 1:j1
        x0    = main.Distl.StartPos(i);
        x1    = main.Distl.EndPos(i);
        q0    = main.Distl.StartValue(i);
        expn  = main.Distl.Exponent(i);
        pitch = main.Distl.Pitch(i);
        
        % q0 * heaviside(x - x0)
        q_terms = addTerm(q_terms, struct('F', q0, 'pos', x0, 'power', 0, 'isUnknown', false));
        % pitch * (x - x0)^expn * heaviside(x - x0)
        q_terms = addTerm(q_terms, struct('F', pitch, 'pos', x0, 'power', expn, 'isUnknown', false));
        % -pitch * (x - x0)^expn * heaviside(x - x1)
        q_terms = addTerm(q_terms, struct('F', -pitch, 'pos', x1, 'power', expn, 'isUnknown', false));
        % -q0 * heaviside(x - x1)
        q_terms = addTerm(q_terms, struct('F', -q0, 'pos', x1, 'power', 0, 'isUnknown', false));
    end
    
    %% 2. Compute Fz(x) from q(x)
    % Fz = -∫q(x)dx
    Fz_terms = integrateTerms(q_terms);
    Fz_terms = multiplyTerms(Fz_terms, -1);
    
    %% 3. Process applied forces (affect Fz and Fx)
    Fx_terms = []; % initialize Fx as a sum of terms
    j2 = length(main.Force.Position);
    for i = 1:j2
        xF  = main.Force.Position(i);
        phi = main.Force.Angle(i);
        val = main.Force.Value(i);
        
        % For Fz: subtract val*sind(phi)*heaviside(x - xF)
        Fz_terms = addTerm(Fz_terms, struct('F', -val * sind(phi), 'pos', xF, 'power', 0, 'isUnknown', false));
        % For Fx: add val*cosd(phi)*heaviside(x - xF)
        Fx_terms = addTerm(Fx_terms, struct('F', val * cosd(phi), 'pos', xF, 'power', 0, 'isUnknown', false));
    end
    
    %% 4. Bearing support corrections for Fx (normal force)
    % For each bearing with X support, subtract the reaction.
    jBear = length(main.Bearing.Position);
    if jBear ~= 0
        Fxl = evaluateTerms(Fx_terms, l);  % Fx at the beam end
    end
    bearingReaction_Fx = zeros(1, jBear);
    for i = 1:jBear
        if main.Bearing.XSupport(i)==1
            xB = main.Bearing.Position(i);
            bearingReaction_Fx(i) = -Fxl;
            Fx_terms = addTerm(Fx_terms, struct('F', -Fxl, 'pos', xB, 'power', 0, 'isUnknown', false));
        end
    end
    
    %% 5. Add unknown reaction terms for Z support (shear forces)
    % Unknown coefficients are added to Fz.
    unknownCounter = 0;
    for i = 1:jBear
        if main.Bearing.ZSupport(i)==1
            unknownCounter = unknownCounter + 1;
            xB = main.Bearing.Position(i);
            Fz_terms = addTerm(Fz_terms, struct('F', 1, 'pos', xB, 'power', 0, ...
                'isUnknown', true, 'unknownIndex', unknownCounter));
        end
    end
    
    %% 6. Compute Mb(x) by integrating Fz(x) and subtracting torques
    Mb_terms = integrateTerms(Fz_terms);
    j3 = length(main.Torque.Position);
    for i = 1:j3
        xT   = main.Torque.Position(i);
        valT = main.Torque.Value(i);
        Mb_terms = addTerm(Mb_terms, struct('F', -valT, 'pos', xT, 'power', 0, 'isUnknown', false));
    end
    % Add unknown moment terms for bearings with T support.
    for i = 1:jBear
        if main.Bearing.TSupport(i)==1
            unknownCounter = unknownCounter + 1;
            xB = main.Bearing.Position(i);
            Mb_terms = addTerm(Mb_terms, struct('F', 1, 'pos', xB, 'power', 0, ...
                'isUnknown', true, 'unknownIndex', unknownCounter));
        end
    end
    
    % Total unknowns for the linear system:
    totalUnknown = unknownCounter;
    
    %% 7. Assemble boundary and joint conditions.
    % Boundary: Fz(1.01*l) = 0 and Mb(1.01*l) = 0.
    % Joint: if a degree of freedom is fixed (free?==0) then the function must vanish.
    % These conditions yield a linear system A*U = b.
    A = []; b = [];
    x_cond = 1.01 * l;
    
    % Boundary condition on Fz:
    [rowFz, constFz] = evalTermsLinear(Fz_terms, x_cond, totalUnknown);
    A = [A; rowFz];
    b = [b; -constFz];
    
    % Boundary condition on Mb:
    [rowMb, constMb] = evalTermsLinear(Mb_terms, x_cond, totalUnknown);
    A = [A; rowMb];
    b = [b; -constMb];
    
    % Joint conditions:
    jJoint = length(main.Joint.Position);
    for jj = 1:jJoint
        xJ = main.Joint.Position(jj);
        if main.Joint.ZSupport(jj)==0
            [row, cons] = evalTermsLinear(Fz_terms, xJ, totalUnknown);
            A = [A; row];
            b = [b; -cons];
        end
        if main.Joint.XSupport(jj)==0
            [row, cons] = evalTermsLinear(Fx_terms, xJ, totalUnknown);
            A = [A; row];
            b = [b; -cons];
        end
        if main.Joint.TSupport(jj)==0
            [row, cons] = evalTermsLinear(Mb_terms, xJ, totalUnknown);
            A = [A; row];
            b = [b; -cons];
        end
    end
    
    % Solve for the unknown reaction coefficients.
    if ~isempty(A)
        U = A \ b;
    else
        U = [];
    end
    
    %% 7a. Extract bearing reaction forces for each bearing.
    % For bearings with Z support, extract the unknown coefficient from Fz_terms;
    % but if the bearing is at x = l, evaluate Fz just before l to capture the jump.
    tol = 1e-6;  % tolerance for matching positions
    bearingReaction_Fz = zeros(1, jBear);
    bearingReaction_Mb = zeros(1, jBear);
    for i = 1:jBear
        pos_i = main.Bearing.Position(i);
        % For Z support (shear force)
        if main.Bearing.ZSupport(i) == 1
            if abs(pos_i - l) < tol
                % For a support at the beam end, evaluate Fz just before l.
                shear_before = evaluateTerms(Fz_terms, l - 1e-6);
                bearingReaction_Fz(i) = -shear_before;
            else
                idx_all = find(arrayfun(@(t) isfield(t, 'isUnknown') && t.isUnknown, Fz_terms));
                if ~isempty(idx_all)
                    diffs = arrayfun(@(j) abs(Fz_terms(j).pos - pos_i), idx_all);
                    [minDiff, idxMin] = min(diffs);
                    if minDiff < tol
                        bearingReaction_Fz(i) = U(Fz_terms(idx_all(idxMin)).unknownIndex);
                    end
                end
            end
        end
        % For T support (moment reaction)
        if main.Bearing.TSupport(i) == 1
            if abs(pos_i - l) < tol
                % For a support at the beam end, set moment reaction as NaN (as before)
                bearingReaction_Mb(i) = NaN;
            else
                idx_all = find(arrayfun(@(t) isfield(t, 'isUnknown') && t.isUnknown, Mb_terms));
                if ~isempty(idx_all)
                    diffs = arrayfun(@(j) abs(Mb_terms(j).pos - pos_i), idx_all);
                    [minDiff, idxMin] = min(diffs);
                    if minDiff < tol
                        bearingReaction_Mb(i) = U(Mb_terms(idx_all(idxMin)).unknownIndex);
                    end
                end
            end
        end
    end
    
    %% 8. Substitute solved unknowns back into term lists.
    Fz_terms = substituteUnknowns(Fz_terms, U);
    Mb_terms = substituteUnknowns(Mb_terms, U);
    results.Fz_terms = Fz_terms;
    results.Fx_terms = Fx_terms;
    results.Mb_terms = Mb_terms;
    
    %% 9. Create function handles from the term lists for plotting.
    results.Fx = @(x) evaluateTerms(Fx_terms, x);
    results.Fz = @(x) evaluateTerms(Fz_terms, x);
    results.Mb = @(x) evaluateTerms(Mb_terms, x);
    
    %% 10. Build the bearing reactions matrix (like the old code).
    % For each bearing, set:
    %   [bearing index, Rx reaction, Rz reaction, Mz reaction]
    bearingReactions = zeros(jBear, 4);
    for i = 1:jBear
        bearingReactions(i, 1) = i;
        if main.Bearing.XSupport(i) == 1
            bearingReactions(i, 2) = bearingReaction_Fx(i);
        else
            bearingReactions(i, 2) = 0;
        end
        if main.Bearing.ZSupport(i) == 1
            bearingReactions(i, 3) = bearingReaction_Fz(i);
        else
            bearingReactions(i, 3) = 0;
        end
        if main.Bearing.TSupport(i) == 1
            bearingReactions(i, 4) = bearingReaction_Mb(i);
        else
            bearingReactions(i, 4) = 0;
        end
    end
    % If the last bearing is exactly at the beam end (x == l), override its row.
    if abs(main.Bearing.Position(jBear) - l) < tol
        % Evaluate Fx at l and Fz just before l to obtain the reaction jump.
        bearingReactions(jBear, :) = [jBear, -results.Fx(l), -evaluateTerms(Fz_terms, l - 1e-6), NaN];
    end
    results.BearingForces = bearingReactions;

    %% 11. For demonstration, evaluate the functions on a sample grid.
    x_sample = linspace(0, l, 100);
    q_sample  = arrayfun(@(x) evaluateTerms(q_terms, x), x_sample);
    Fz_sample = arrayfun(@(x) evaluateTerms(Fz_terms, x), x_sample);
    Mb_sample = arrayfun(@(x) evaluateTerms(Mb_terms, x), x_sample);
    Fx_sample = arrayfun(@(x) evaluateTerms(Fx_terms, x), x_sample);
    
    %% Display solved unknowns and the bearing reactions matrix.
    disp('Solved unknowns:');
    disp(U);
    disp('Bearing Reactions Matrix:');
    disp(results.BearingForces);
    
    
    %% Nested Helper Functions
    
    function terms = addTerm(terms, term)
        % Ensures that every term has the same fields.
        defaultTerm = struct('F', 0, 'pos', 0, 'power', 0, 'isUnknown', false, 'unknownIndex', []);
        defaultFields = fieldnames(defaultTerm);
        for iField = 1:length(defaultFields)
            fieldName = defaultFields{iField};
            if ~isfield(term, fieldName)
                term.(fieldName) = defaultTerm.(fieldName);
            end
        end
        if ~isempty(terms)
            allFields = fieldnames(terms(1));
            missingFields = setdiff(defaultFields, allFields);
            for iField = 1:length(missingFields)
                fieldName = missingFields{iField};
                for j = 1:length(terms)
                    terms(j).(fieldName) = defaultTerm.(fieldName);
                end
            end
        end
        if isempty(terms)
            terms = term;
        else
            terms(end+1) = term;
        end
    end

    function newTerms = integrateTerms(terms)
        % Applies the power rule to integrate each term.
        newTerms = [];
        for k = 1:length(terms)
            t = terms(k);
            new_t = t;
            new_t.F = t.F / (t.power + 1);
            new_t.power = t.power + 1;
            newTerms = addTerm(newTerms, new_t);
        end
    end

    function newTerms = multiplyTerms(terms, factor)
        % Multiplies each term by a numeric factor.
        newTerms = terms;
        for k = 1:length(newTerms)
            newTerms(k).F = newTerms(k).F * factor;
        end
    end

    function val = evaluateTerms(terms, x)
        % Evaluates the sum of the terms at a given scalar x.
        val = 0;
        for k = 1:length(terms)
            if x >= terms(k).pos
                contribution = (x - terms(k).pos)^(terms(k).power);
                val = val + terms(k).F * contribution;
            end
        end
    end

    function [row, knownVal] = evalTermsLinear(terms, x, totalUnknown)
        % Linearizes the expression at x so that f(x) = row*U + knownVal.
        if nargin < 3
            totalUnknown = 0;
        end
        row = zeros(1, totalUnknown);
        knownVal = 0;
        for k = 1:length(terms)
            if x >= terms(k).pos
                c = (x - terms(k).pos)^(terms(k).power);
                if isfield(terms(k), 'isUnknown') && terms(k).isUnknown
                    row(terms(k).unknownIndex) = row(terms(k).unknownIndex) + c;
                else
                    knownVal = knownVal + terms(k).F * c;
                end
            end
        end
    end

    function newTerms = substituteUnknowns(terms, U)
        % Replaces unknown coefficients with their solved numeric values.
        newTerms = terms;
        for k = 1:length(newTerms)
            if isfield(newTerms(k), 'isUnknown') && newTerms(k).isUnknown
                newTerms(k).F = U(newTerms(k).unknownIndex);
                newTerms(k).isUnknown = false;
            end
        end
    end

end

% function [q_sample, Fz_sample, Mb_sample, Fx_sample] = calcformulasanalytico3(l)
% % calcformulasanalytico3
% %   Computes the functions q(x), Fz(x), Mb(x) and Fx(x) for a beam by
% %   assembling a sum of terms of the form
% %
% %       F * ⟨x - pos⟩^power,
% %
% %   where ⟨x-pos⟩ equals (x-pos) when x>=pos and 0 otherwise.
% %
% %   Integration is performed term‐by‐term (using the power rule) so that
% %   no symbolic toolbox is required. Unknown reaction coefficients (added
% %   from bearings) are determined from boundary conditions.
% %
% %   Global structures “main” and “results” provide input data and store results.
% %
% %   INPUT:
% %       l    – the length of the beam (used for evaluating boundary conditions)
% %
% %   OUTPUT:
% %       q_sample, Fz_sample, Mb_sample, Fx_sample – numeric vectors sampled
% %            along x (for plotting or further processing).
% 
%     global main results;
% 
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % 1. Build the distributed load function q(x)
%     %    q is assembled as a sum of simple terms.
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     q_terms = [];  % each term is a struct with fields:
%                    %   F, pos, power, isUnknown, unknownIndex
%     j1 = length(main.Distl.StartPos);
%     for i = 1:j1
%         x0   = main.Distl.StartPos(i);
%         x1   = main.Distl.EndPos(i);
%         q0   = main.Distl.StartValue(i);
%         expn = main.Distl.Exponent(i);
%         pitch= main.Distl.Pitch(i);
% 
%         % q0 * heaviside(x - x0)
%         q_terms = addTerm(q_terms, struct('F', q0, 'pos', x0, 'power', 0, 'isUnknown', false));
%         % pitch * (x-x0)^expn * heaviside(x - x0)
%         q_terms = addTerm(q_terms, struct('F', pitch, 'pos', x0, 'power', expn, 'isUnknown', false));
%         % -pitch * (x-x0)^expn * heaviside(x - x1)
%         q_terms = addTerm(q_terms, struct('F', -pitch, 'pos', x1, 'power', expn, 'isUnknown', false));
%         % -q0 * heaviside(x - x1)
%         q_terms = addTerm(q_terms, struct('F', -q0, 'pos', x1, 'power', 0, 'isUnknown', false));
%     end
% 
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % 2. Compute Fz(x) from q(x)
%     %    Fz = - ∫q(x)dx
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Fz_terms = integrateTerms(q_terms);
%     Fz_terms = multiplyTerms(Fz_terms, -1);
% 
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % 3. Process applied forces:
%     %    (i) They contribute to Fz and Fx.
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Fx_terms = []; % initialize Fx as a sum of terms
%     j2 = length(main.Force.Position);
%     for i = 1:j2
%         xF = main.Force.Position(i);
%         phi = main.Force.Angle(i);
%         val = main.Force.Value(i);
% 
%         % For Fz: subtract val * sind(phi)*heaviside(x-xF)
%         Fz_terms = addTerm(Fz_terms, struct('F', -val * sind(phi), 'pos', xF, 'power', 0, 'isUnknown', false));
%         % For Fx: add val * cosd(phi)*heaviside(x-xF)
%         Fx_terms = addTerm(Fx_terms, struct('F', val * cosd(phi), 'pos', xF, 'power', 0, 'isUnknown', false));
%     end
% 
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % 4. Bearing support corrections:
%     %    For bearings with X support, subtract the value of Fx at x = l.
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     jBear = length(main.Bearing.Position);
%     bearingReactions = cell(jBear, 4);
%     if jBear ~= 0
%         Fxl = evaluateTerms(Fx_terms, l);
%     end
%     for i = 1:jBear
%         xB   = main.Bearing.Position(i);
%         hasFz= main.Bearing.ZSupport(i);
%         hasFx= main.Bearing.XSupport(i);
%         hasM = main.Bearing.TSupport(i);
%         if hasFx == 1
%             Fx_terms = addTerm(Fx_terms, struct('F', -Fxl, 'pos', xB, 'power', 0, 'isUnknown', false));
%             bearingReactions{i,2} = -Fxl;
%             break; % assume only one such support is used
%         end
%     end
% 
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % 5. Add unknown reaction terms from bearings with Z support.
%     %    These unknowns (F1, F2, …) are added to Fz.
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     unknownCounter = 0;
%     for i = 1:jBear
%         xB    = main.Bearing.Position(i);
%         hasFz = main.Bearing.ZSupport(i);
%         hasFx = main.Bearing.XSupport(i);
%         hasM  = main.Bearing.TSupport(i);
%         if hasFz == 1
%             unknownCounter = unknownCounter + 1;
%             % Add an unknown term: coefficient * heaviside(x - xB)
%             Fz_terms = addTerm(Fz_terms, struct('F', 1, 'pos', xB, 'power', 0, ...
%                 'isUnknown', true, 'unknownIndex', unknownCounter));
%         end
%     end
% 
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % 6. Compute Mb(x) by integrating Fz(x)
%     %    Mb = ∫Fz(x)dx then subtract torque contributions.
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Mb_terms = integrateTerms(Fz_terms);
% 
%     % Subtract torque terms: for each torque, subtract valT*heaviside(x-xT)
%     j3 = length(main.Torque.Position);
%     for i = 1:j3
%         xT   = main.Torque.Position(i);
%         valT = main.Torque.Value(i);
%         Mb_terms = addTerm(Mb_terms, struct('F', -valT, 'pos', xT, 'power', 0, 'isUnknown', false));
%     end
% 
%     % Add unknown moment terms from bearings with moment (T) support.
%     for i = 1:jBear
%         xB    = main.Bearing.Position(i);
%         hasFz = main.Bearing.ZSupport(i);
%         hasFx = main.Bearing.XSupport(i);
%         hasM  = main.Bearing.TSupport(i);
%         if hasM == 1
%             unknownCounter = unknownCounter + 1;
%             Mb_terms = addTerm(Mb_terms, struct('F', 1, 'pos', xB, 'power', 0, ...
%                 'isUnknown', true, 'unknownIndex', unknownCounter));
%         end
%     end
% 
%     % Define total number of unknowns (for a consistent linear system)
%     totalUnknown = unknownCounter;
% 
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % 7. Assemble boundary and joint conditions.
%     %
%     % Boundary conditions:
%     %   Fz(1.01*l) = 0  and  Mb(1.01*l) = 0.
%     % Joint conditions:
%     %   If a degree of freedom is fixed (free?==0) then the corresponding
%     %   function value must vanish.
%     % These yield a linear system A*U = b for the unknown reaction coefficients.
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     A = []; b = [];
%     x_cond = 1.01 * l;
% 
%     % Condition 1: Fz(x_cond) == 0.
%     [rowFz, constFz] = evalTermsLinear(Fz_terms, x_cond, totalUnknown);
%     A = [A; rowFz];
%     b = [b; -constFz];
% 
%     % Condition 2: Mb(x_cond) == 0.
%     [rowMb, constMb] = evalTermsLinear(Mb_terms, x_cond, totalUnknown);
%     A = [A; rowMb];
%     b = [b; -constMb];
% 
%     % Joint conditions:
%     jJoint = length(main.Joint.Position);
%     for jj = 1:jJoint
%         xJ = main.Joint.Position(jj);
%         freeX = main.Joint.XSupport(jj);
%         freeZ = main.Joint.ZSupport(jj);
%         freeM = main.Joint.TSupport(jj);
%         if freeZ == 0
%             [row, cons] = evalTermsLinear(Fz_terms, xJ, totalUnknown);
%             A = [A; row];
%             b = [b; -cons];
%         end
%         if freeX == 0
%             [row, cons] = evalTermsLinear(Fx_terms, xJ, totalUnknown);
%             A = [A; row];
%             b = [b; -cons];
%         end
%         if freeM == 0
%             [row, cons] = evalTermsLinear(Mb_terms, xJ, totalUnknown);
%             A = [A; row];
%             b = [b; -cons];
%         end
%     end
% 
%     % Solve for the unknowns (if any equations were assembled)
%     if ~isempty(A)
%         U = A \ b;
%     else
%         U = [];
%     end
% 
%     % Substitute the solved unknowns back into Fz_terms and Mb_terms.
%     Fz_terms = substituteUnknowns(Fz_terms, U);
%     Mb_terms = substituteUnknowns(Mb_terms, U);
% 
%     % Save final term lists in the global results structure.
%     results.Fz_terms = Fz_terms;
%     results.Fx_terms = Fx_terms;
%     results.Mb_terms = Mb_terms;
% 
%     % Create function handles from the term lists for fplot.
%     results.Fx = @(x) evaluateTerms(Fx_terms, x);
%     results.Fz = @(x) evaluateTerms(Fz_terms, x);
%     results.Mb = @(x) evaluateTerms(Mb_terms, x);
% 
%     % For demonstration, evaluate on a sample grid.
%     x_sample = linspace(0, l, 100);
%     q_sample  = arrayfun(@(x) evaluateTerms(q_terms, x), x_sample);
%     Fz_sample = arrayfun(@(x) evaluateTerms(Fz_terms, x), x_sample);
%     Mb_sample = arrayfun(@(x) evaluateTerms(Mb_terms, x), x_sample);
%     Fx_sample = arrayfun(@(x) evaluateTerms(Fx_terms, x), x_sample);
% 
%     % Display the solved unknowns.
%     disp('Solved unknowns:');
%     disp(U);
% 
%     % (Optionally, update the app’s UI with bearing reaction values, etc.)
% 
% 
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % Nested helper functions
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%     function terms = addTerm(terms, term)
%         % Normalize each term so that every term has the same fields.
%         defaultTerm = struct('F', 0, 'pos', 0, 'power', 0, 'isUnknown', false, 'unknownIndex', []);
%         defaultFields = fieldnames(defaultTerm);
% 
%         % Ensure the new term has all default fields.
%         for iField = 1:length(defaultFields)
%             fieldName = defaultFields{iField};
%             if ~isfield(term, fieldName)
%                 term.(fieldName) = defaultTerm.(fieldName);
%             end
%         end
% 
%         % If the terms array is nonempty, ensure each element has the default fields.
%         if ~isempty(terms)
%             allFields = fieldnames(terms(1));
%             missingFields = setdiff(defaultFields, allFields);
%             for iField = 1:length(missingFields)
%                 fieldName = missingFields{iField};
%                 for j = 1:length(terms)
%                     terms(j).(fieldName) = defaultTerm.(fieldName);
%                 end
%             end
%         end
% 
%         if isempty(terms)
%             terms = term;
%         else
%             terms(end+1) = term;
%         end
%     end
% 
%     function newTerms = integrateTerms(terms)
%         % Integrates each term (applying the power rule) and returns the new term list.
%         newTerms = [];
%         for k = 1:length(terms)
%             t = terms(k);
%             new_t = t;
%             new_t.F = t.F / (t.power + 1);
%             new_t.power = t.power + 1;
%             newTerms = addTerm(newTerms, new_t);
%         end
%     end
% 
%     function newTerms = multiplyTerms(terms, factor)
%         % Multiplies each term in the list by a numeric factor.
%         newTerms = terms;
%         for k = 1:length(newTerms)
%             newTerms(k).F = newTerms(k).F * factor;
%         end
%     end
% 
%     function val = evaluateTerms(terms, x)
%         % Evaluates the sum of the terms at a given scalar x.
%         % Each term contributes F*(x-pos)^power if x >= pos, 0 otherwise.
%         val = 0;
%         for k = 1:length(terms)
%             if x >= terms(k).pos
%                 contribution = (x - terms(k).pos)^(terms(k).power);
%                 val = val + terms(k).F * contribution;
%             end
%         end
%     end
% 
%     function [row, knownVal] = evalTermsLinear(terms, x, totalUnknown)
%         % For a given x, returns a row vector "row" (of length totalUnknown)
%         % and a scalar "knownVal" so that the function value is:
%         %       f(x) = row*U + knownVal,
%         % where U is the vector of unknown coefficients.
%         if nargin < 3
%             totalUnknown = 0;
%         end
%         row = zeros(1, totalUnknown);
%         knownVal = 0;
%         for k = 1:length(terms)
%             if x >= terms(k).pos
%                 c = (x - terms(k).pos)^(terms(k).power);
%                 if isfield(terms(k), 'isUnknown') && terms(k).isUnknown
%                     row(terms(k).unknownIndex) = row(terms(k).unknownIndex) + c;
%                 else
%                     knownVal = knownVal + terms(k).F * c;
%                 end
%             end
%         end
%     end
% 
%     function newTerms = substituteUnknowns(terms, U)
%         % Replaces unknown term coefficients with their solved numeric values.
%         newTerms = terms;
%         for k = 1:length(newTerms)
%             if isfield(newTerms(k), 'isUnknown') && newTerms(k).isUnknown
%                 newTerms(k).F = U(newTerms(k).unknownIndex);
%                 newTerms(k).isUnknown = false;  % mark as now known
%             end
%         end
%     end
% 
% end
