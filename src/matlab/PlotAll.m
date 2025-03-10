function PlotAll(app)
% PlotAll Deleates all Plots and Replots all Active Imputs
%   Plot (Support, Hinge, Force, Touqure, Distr.Loads)
global main
            
    % Clear Plot / Replot Bar
    % cla (app.UIAxes_Setup, 'reset');
    % X = [0 app.Spinner_BarLength.Value];
    % Y = [0 0];
    % plot(app.UIAxes_Setup,X,Y,'LineWidth',4,'Color','k');
    % hold(app.UIAxes_Setup,'on')

    % Plot Bar if nessesary
    if ~isempty(main.BarLgh)
        PlotBar(app);
    end
    
    % Plot Force if nessesary
    if ~isempty(main.Force.Value) || any(main.BckInf(2,:) == 1)
        PlotForce(app);
    end

    % Plot Tourque if nessesary
    if ~isempty(main.Torque.Value) || any(main.BckInf(2,:) == 2)
        PlotTourque(app);
    end

    % Plot Distl if nessesary
    if ~isempty(main.Distl.StartPos) || any(main.BckInf(2,:) == 3)
        PlotDistl(app);
    end

    % Plot Bearing if nessesary
    if ~isempty(main.Bearing.Position) || any(main.BckInf(2,:) == 4)
        PlotBearing(app);
    end
    
    % Plot Hinge if nessesary
    if ~isempty(main.Joint.Position) || any(main.BckInf(2,:) == 5)
        PlotHinge(app);
    end
 
end

