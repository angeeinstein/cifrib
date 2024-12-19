classdef dispData < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                matlab.ui.Figure
        UITable                 matlab.ui.control.Table
        BearingForcesLabel      matlab.ui.control.Label
        ForceDistributionLabel  matlab.ui.control.Label
        UIAxes3                 matlab.ui.control.UIAxes
        UIAxes2                 matlab.ui.control.UIAxes
        UIAxes                  matlab.ui.control.UIAxes
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1290 459];
            app.UIFigure.Name = 'MATLAB App';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'Fq (x)')
            xlabel(app.UIAxes, 'm')
            ylabel(app.UIAxes, ' N')
            app.UIAxes.YLabel.Rotation = 0;
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.Position = [1 201 640 185];
            grid(app.UIAxes, 'on');

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.UIFigure);
            title(app.UIAxes2, 'Fn (x)')
            xlabel(app.UIAxes2, 'm')
            ylabel(app.UIAxes2, ' N')
            app.UIAxes2.YLabel.Rotation = 0;
            zlabel(app.UIAxes2, 'Z')
            app.UIAxes2.Position = [650 201 640 185];
            grid(app.UIAxes2, 'on');

            % Create UIAxes3
            app.UIAxes3 = uiaxes(app.UIFigure);
            title(app.UIAxes3, 'Mb')
            xlabel(app.UIAxes3, 'm')
            ylabel(app.UIAxes3, ' Nm')
            app.UIAxes3.YLabel.Rotation = 0;
            zlabel(app.UIAxes3, 'Z')
            app.UIAxes3.Position = [1 16 639 185];
            grid(app.UIAxes3, 'on');

            % Create ForceDistributionLabel
            app.ForceDistributionLabel = uilabel(app.UIFigure);
            app.ForceDistributionLabel.FontSize = 18;
            app.ForceDistributionLabel.FontWeight = 'bold';
            app.ForceDistributionLabel.Position = [583 399 158 51];
            app.ForceDistributionLabel.Text = 'Force Distribution';

            % Create BearingForcesLabel
            app.BearingForcesLabel = uilabel(app.UIFigure);
            app.BearingForcesLabel.FontSize = 16;
            app.BearingForcesLabel.FontWeight = 'bold';
            app.BearingForcesLabel.Position = [897 153 125 51];
            app.BearingForcesLabel.Text = 'Bearing Forces';

            % Create UITable
            app.UITable = uitable(app.UIFigure);
            app.UITable.ColumnName = {'Bearing'; 'X-Force'; 'Z-Force'; 'Y-Torque'};
            app.UITable.RowName = {};
            app.UITable.Position = [709 45 516 109];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = dispData

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end