classdef Help < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure   matlab.ui.Figure
        HelpPanel  matlab.ui.container.Panel
        Label      matlab.ui.control.Label
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create HelpPanel
            app.HelpPanel = uipanel(app.UIFigure);
            app.HelpPanel.BorderColor = [0 0 0];
            app.HelpPanel.TitlePosition = 'centertop';
            app.HelpPanel.Title = 'Help';
            app.HelpPanel.FontWeight = 'bold';
            app.HelpPanel.FontSize = 16;
            app.HelpPanel.Position = [1 1 640 480];

            % Create Label
            app.Label = uilabel(app.HelpPanel);
            app.Label.HorizontalAlignment = 'left';
            app.Label.FontSize = 15;
            app.Label.FontWeight = 'normal';
            app.Label.Position = [5 60 640 401];
            app.Label.Text = {'1. Step: Define the bar length in the bar length field.';''; 
                'Step 2: Implementing the Bearings';
                'Select the desired bearing from the "Supports" panel and specify its position. Please note that the fixed support is only available at the start and end positions. Once you are satisfied with your selection, confirm your choice by clicking the "Add" button at the end of the panel.'
                '3. Step: Implement the punctual forces and moments in the add loads panel, define the angle,'; 'the strength and the position. Then press the implement button at the bottom of the' ; 'add loads panel.' ;''; 
                '4. Step: Implement the line loads by choosing between a constant, linear and quadratic'; 'line load in the line loads panel. Define the pitch, which is the coefficient of the chosen'; 'exponet, the start point, the end point and the start height of the line load. You can also'; 'implement a negative pitch. If you are satisfied with your values, press the implement button'; 'at the end of the panel.';'';
                '5. Step: If you made a mistake, you can always reset. Before pressing calculate, check if the'; 'lamp shines green, which means your whole calculation is statically defined. If not, you either'; 'have to reset or implement more structual supports. If you have done everything right and'; 'pressed calculate, you should now see the the force distribution.'};

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Help

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