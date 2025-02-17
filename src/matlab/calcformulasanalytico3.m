function [q_sample, Fz_sample, Mb_sample, Fx_sample] = calcformulasanalytico3(l)
% calcformulasanalytico3
%   Computes q(x), Fz(x), Mb(x) and Fx(x) for a beam by summing terms of the
%   form F * ⟨x - pos⟩^power (with ⟨·⟩ equal to (x-pos) for x>=pos and 0 otherwise).
%   Integration is done term‐by‐term (using the power rule) so no symbolic toolbox is needed.
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
    q_terms = [];  % each term is a struct with fields: F, pos, power, isUnknown
    j1 = length(main.Distl.StartPos);
    for i = 1:j1
        x0    = main.Distl.StartPos(i);
        x1    = main.Distl.EndPos(i);
        q0    = main.Distl.StartValue(i);
        expn  = main.Distl.Exponent(i);
        pitch = main.Distl.Pitch(i);
        
        % Term (a): +q0 * heaviside(x - x0)
        q_terms = addTerm(q_terms, struct('F', q0, 'pos', x0, 'power', 0, 'isUnknown', false));
        % Term (b): +pitch*(x - x0)^expn * heaviside(x - x0)
        q_terms = addTerm(q_terms, struct('F', pitch, 'pos', x0, 'power', expn, 'isUnknown', false));
        % Term (c): -pitch*(x - x0)^expn * heaviside(x - x1)
        q_terms = addTerm(q_terms, struct('F', -pitch, 'pos', x1, 'power', expn, 'isUnknown', false));
        % Term (d): -q0 * heaviside(x - x1)
        q_terms = addTerm(q_terms, struct('F', -q0, 'pos', x1, 'power', 0, 'isUnknown', false));
        % --- Extra term to subtract the constant load beyond x1 ---
        % This extra term subtracts pitch*(x1-x0) for x>=x1 so that q(x) becomes zero.
        q_terms = addTerm(q_terms, struct('F', -pitch*(x1 - x0), 'pos', x1, 'power', 0, 'isUnknown', false));
    end
    
    %% 2. Compute Fz(x) from q(x)
    % Fz = -∫q(x) dx
    Fz_terms = integrateTerms(q_terms);
    Fz_terms = multiplyTerms(Fz_terms, -1);
    
    %% 3. Process applied forces (affect Fz and Fx)
    Fx_terms = []; % initialize Fx as a sum of terms
    j2 = length(main.Force.Position);
    for i = 1:j2
        xF  = main.Force.Position(i);
        phi = main.Force.Angle(i);
        val = main.Force.Value(i);
        
        % For Fz: subtract val * sind(phi)*heaviside(x - xF)
        Fz_terms = addTerm(Fz_terms, struct('F', -val * sind(phi), 'pos', xF, 'power', 0, 'isUnknown', false));
        % For Fx: add val * cosd(phi)*heaviside(x - xF)
        Fx_terms = addTerm(Fx_terms, struct('F', val * cosd(phi), 'pos', xF, 'power', 0, 'isUnknown', false));
    end
    
    %% 4. Bearing support corrections for Fx (normal force)
    % For each bearing with X support, subtract the reaction (evaluated at x=l).
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
            Fz_terms = addTerm(Fz_terms, struct('F', 1, 'pos', xB, 'power', 0, 'isUnknown', true, 'unknownIndex', unknownCounter));
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
            Mb_terms = addTerm(Mb_terms, struct('F', 1, 'pos', xB, 'power', 0, 'isUnknown', true, 'unknownIndex', unknownCounter));
        end
    end
    totalUnknown = unknownCounter;
    
    %% 7. Assemble boundary and joint conditions.
    % Boundary: Fz(1.01*l) = 0 and Mb(1.01*l) = 0.
    % Joint: if a degree of freedom is fixed (free?==0) then the function must vanish.
    % These conditions yield a linear system A*U = b.
    A = []; b = [];
    x_cond = 1.01 * l;
    
    [rowFz, constFz] = evalTermsLinear(Fz_terms, x_cond, totalUnknown);
    A = [A; rowFz];
    b = [b; -constFz];
    
    [rowMb, constMb] = evalTermsLinear(Mb_terms, x_cond, totalUnknown);
    A = [A; rowMb];
    b = [b; -constMb];
    
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
    
    if ~isempty(A)
        U = A \ b;
    else
        U = [];
    end
    
    %% 7a. Extract bearing reaction forces.
    % For bearings with Z support, extract the unknown coefficient from Fz_terms.
    % For a bearing at the beam end (x = l), evaluate Fz just before l.
    tol = 1e-6;
    bearingReaction_Fz = zeros(1, jBear);
    bearingReaction_Mb = zeros(1, jBear);
    for i = 1:jBear
        pos_i = main.Bearing.Position(i);
        if main.Bearing.ZSupport(i) == 1
            if abs(pos_i - l) < tol
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
        if main.Bearing.TSupport(i) == 1
            if abs(pos_i - l) < tol
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
    
    %% 10. Build the bearing reactions matrix (like your old code).
    % Each row: [bearing index, Rx reaction, Rz reaction, Mz reaction]
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
            bearingReactions(i, 4) = -results.Mb( max(main.Bearing.Position(i), 1e-6) );
        else
            bearingReactions(i, 4) = 0;
        end
    end
    if abs(main.Bearing.Position(jBear) - l) < tol
        bearingReactions(jBear, :) = [jBear, -results.Fx(l), -evaluateTerms(Fz_terms, l - 1e-6), NaN];
    end
    results.BearingForces = bearingReactions;
    
    %% 11. For demonstration, sample the functions on a grid.
    x_sample = linspace(0, l, 100);
    q_sample  = arrayfun(@(x) evaluateTerms(q_terms, x), x_sample);
    Fz_sample = arrayfun(@(x) evaluateTerms(Fz_terms, x), x_sample);
    Mb_sample = arrayfun(@(x) evaluateTerms(Mb_terms, x), x_sample);
    Fx_sample = arrayfun(@(x) evaluateTerms(Fx_terms, x), x_sample);
    
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
                contribution = (x - terms(k).pos).^(terms(k).power);
                val = val + terms(k).F * contribution;
            end
        end
    end

    function [row, knownVal] = evalTermsLinear(terms, x, totalUnknown)
        % Linearizes the expression at x so that f(x) = row*U + knownVal.
        if nargin < 3, totalUnknown = 0; end
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
        % Replaces unknown coefficients with the solved values from U.
        newTerms = terms;
        for k = 1:length(newTerms)
            if isfield(newTerms(k), 'isUnknown') && newTerms(k).isUnknown
                newTerms(k).F = U(newTerms(k).unknownIndex);
                newTerms(k).isUnknown = false;
            end
        end
    end

end
