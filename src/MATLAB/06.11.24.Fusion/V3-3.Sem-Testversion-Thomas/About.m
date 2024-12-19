classdef About < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure    matlab.ui.Figure
        AboutPanel  matlab.ui.container.Panel
        Label       matlab.ui.control.Label
        Image       matlab.ui.control.Image
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create AboutPanel
            app.AboutPanel = uipanel(app.UIFigure);
            app.AboutPanel.BorderColor = [0 0 0];
            app.AboutPanel.TitlePosition = 'centertop';
            app.AboutPanel.Title = 'About';
            app.AboutPanel.FontWeight = 'bold';
            app.AboutPanel.FontSize = 16;
            app.AboutPanel.Position = [1 1 640 480];

            % Create Image
            app.Image = uiimage(app.AboutPanel);
            app.Image.ScaleMethod = 'fill';
            app.Image.Position = [0 22 640 432];
            app.Image.ImageSource = 'Egal.png';

            % Create Label
            app.Label = uilabel(app.AboutPanel);
            app.Label.Position = [1 1 515 22];
            app.Label.Text = ' Copyright ©: Thomas Blankenbichler, Leo Leidinger, Angelo Popovic, Thomas Zbil aus LAV23';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = About

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