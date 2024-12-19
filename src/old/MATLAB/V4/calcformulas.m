  function [q,F,Mb] = calcformulas(l)
    
    syms x 
    global main results;
    q=0.0;
    Mb=0.0;
    F=0.0;
    Fx=0.0;

    [~, j1] = size(main.Distl); %Ermitteln der Spalten von Distl
    for i = 1:j1
        %(1-Startpos, 2-Endpos, 3-Startvalue, 4-sign (pos=1/neg=-1), 5-Exponent, 6-pitch-k)
        %       |   startvalue on startposition                 |      fuction on - transformed in global coordinates (very left ==> x=0;)                   | function off 
        q = q + main.Distl(3, i)*heaviside(x - main.Distl(1, i))+(main.Distl(6, i) * (x-main.Distl(1, i))^main.Distl(5, i) * heaviside(x - main.Distl(1, i)) - main.Distl(6, i) * (x-main.Distl(1, i))^main.Distl(5, i) * heaviside(x - main.Distl(2, i)))- main.Distl(3, i)*heaviside(x - main.Distl(2, i));
    end

    F = -int(q, x);
    
    [~, j2] = size(main.Force);
    for i = 1:j2
        F = F - main.Force(3,i) * sind(main.Force(2,i)) * heaviside(x - main.Force(1,i)) ; 
        Fx= Fx + main.Force(3,i) * cosd(main.Force(2,i)) * heaviside(x - main.Force(1,i));
    end


   [h, j] = size(main.Bearing);
   bearingractions=NaN(j,4);

    vars = [];
    varsx = [];
    
    Bearingordered=NaN(h,j);
    Bearingordered(:,:)=main.Bearing(:,:);
    Bspare=NaN(h,1);

    for k=1:j-1
        for i=k+1:j
            if Bearingordered(1,i)<Bearingordered(1,k)
                Bspare=Bearingordered(:,k);
                Bearingordered(:,k)=Bearingordered(:,i);
                Bearingordered(:,i)=Bspare;

            end
        end
    end


    for i = 1:j
    if Bearingordered(2,i) == 1
        varName = ['F' num2str(i)];
        eval([varName ' = sym(varName);']);
        F = F + eval(varName) * heaviside(x - Bearingordered(1,i));
        vars = [vars, eval(varName)];
    end
    end

    for i=1:j
        if Bearingordered(3,i)==1
            varName = ['Fx' num2str(i)];
            eval([varName ' = sym(varName);']);
            Fx=Fx - eval(varName) * heaviside(x-Bearingordered(1,i));
            varsx = [varsx, eval(varName)];
        end
    end

    boundary_conditionsx=[subs(Fx,x,l*1.01)==0];

    Mb = int(F, x);
    
    [~, j3] = size(main.Torque);
    for i = 1:j3
        Mb = Mb - main.Torque(2,i) * heaviside(x - main.Torque(1,i));
    end
    
    for i = 1:j
        if Bearingordered(4,i) == 1
            varName = ['M' num2str(i)];
            eval([varName ' = sym(varName);']);
            Mb = Mb + eval(varName) * heaviside(x - Bearingordered(1,i));
            vars = [vars, eval(varName)];
        end
    end
    
    
    boundary_conditions = [subs(F, x, l*1.01) == 0, subs(Mb, x, l*1.01) == 0];

     [~, j5] = size(main.Joint);
                for i = 1:j5
                    if main.Joint(3,i) == 0
                    boundary_conditions = [boundary_conditions,subs(F, x, main.Joint(1,i)) == 0];
                    end

                    if main.Joint(2,i) == 0
                    boundary_conditionsx = [boundary_conditionsx,subs(Fx, x, main.Joint(1,i)) == 0];
                    end
                    
                    if main.Joint(4,i) == 0
                    boundary_conditions = [boundary_conditions,subs(Mb, x, main.Joint(1,i)) == 0];
                    end
                end

    sol = solve(boundary_conditions, vars);
    F = subs(F, vars, struct2array(sol));
    Mb = subs(Mb, vars, struct2array(sol));
    
    solx=solve(boundary_conditionsx, varsx);
    if length(varsx)>1
    Fx=subs(Fx, varsx, struct2array(solx));
    else
    Fx=subs(Fx, varsx, solx);
    end


    for i=1:j

        bearingractions(i,1)= i;

        varNameM = ['M' num2str(i)];
        varNameF = ['F' num2str(i)];
        varNameFx = ['Fx' num2str(i)];
        if isfield(sol, varNameM)
            bearingractions(i,4)=sol.(varNameM);
        end
        if isfield(sol, varNameF)
            bearingractions(i,3)=sol.(varNameF);
        end
        if length(varsx)>1
            if isfield(solx, varNameFx)
            bearingractions(i,2)=solx.(varNameFx);
            end
        else
            if Bearingordered(3,i)==1
                bearingractions(i,2)=eval(solx);
            end
        end
        
    end
    
    results.Fz=F;
    results.Fx=Fx;
    results.Mb=Mb;
    results.BearingForces=bearingractions();
   
end