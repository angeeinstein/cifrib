classdef dispData < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                matlab.ui.Figure
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
            app.UIFigure.Position = [100 100 640 632];
            app.UIFigure.Name = 'MATLAB App';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'Shear Force')
            xlabel(app.UIAxes, 'm')
            ylabel(app.UIAxes, 'N')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.Position = [1 374 640 185];
            grid(app.UIAxes, 'on');

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.UIFigure);
            title(app.UIAxes2, 'Normal Force')
            xlabel(app.UIAxes2, 'm')
            ylabel(app.UIAxes2, 'N')
            zlabel(app.UIAxes2, 'Z')
            app.UIAxes2.Position = [1 6 640 185];
            grid(app.UIAxes2, 'on');

            % Create UIAxes3
            app.UIAxes3 = uiaxes(app.UIFigure);
            title(app.UIAxes3, 'Bending Torque')
            xlabel(app.UIAxes3, 'm')
            ylabel(app.UIAxes3, 'Nm')
            zlabel(app.UIAxes3, 'Z')
            app.UIAxes3.Position = [1 190 640 185];
            grid(app.UIAxes3, 'on');

            % Create ForceDistributionLabel
            app.ForceDistributionLabel = uilabel(app.UIFigure);
            app.ForceDistributionLabel.FontSize = 18;
            app.ForceDistributionLabel.FontWeight = 'bold';
            app.ForceDistributionLabel.Position = [242 572 158 51];
            app.ForceDistributionLabel.Text = 'Force Distribution';

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