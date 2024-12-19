classdef Eingabe_skript < matlab.apps.AppBase
    structureinitiate();
    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                   matlab.ui.Figure
        Label                      matlab.ui.control.Label
        Panel                      matlab.ui.container.Panel
        ParametersPanel            matlab.ui.container.Panel
        AddLineLoadsPanel          matlab.ui.container.Panel
        pitchkEditField            matlab.ui.control.NumericEditField
        pitchkEditFieldLabel       matlab.ui.control.Label
        exponentnEditField         matlab.ui.control.NumericEditField
        exponentnLabel             matlab.ui.control.Label
        EndmEditField              matlab.ui.control.NumericEditField
        EndmEditFieldLabel         matlab.ui.control.Label
        StartmEditField            matlab.ui.control.NumericEditField
        StartmEditFieldLabel       matlab.ui.control.Label
        ImplementButton_3          matlab.ui.control.Button
        ForceNEditField_2          matlab.ui.control.NumericEditField
        ForceNEditField_2Label     matlab.ui.control.Label
        AddLoadsPanel              matlab.ui.container.Panel
        AngleEditField             matlab.ui.control.NumericEditField
        AngleEditFieldLabel        matlab.ui.control.Label
        PositionmEditField         matlab.ui.control.NumericEditField
        PositionmEditFieldLabel    matlab.ui.control.Label
        ImplementButton            matlab.ui.control.Button
        ForceNNmEditField          matlab.ui.control.NumericEditField
        ForceNNmEditFieldLabel     matlab.ui.control.Label
        LoadsListBox               matlab.ui.control.ListBox
        StructuralSupportPanel     matlab.ui.container.Panel
        PositionmEditField_2       matlab.ui.control.NumericEditField
        PositionmEditField_2Label  matlab.ui.control.Label
        ImplementButton_2          matlab.ui.control.Button
        LoadsListBox_2             matlab.ui.control.ListBox
        Lamp                       matlab.ui.control.Lamp
        Label_2                    matlab.ui.control.Label
        StaticdefinitionLabel      matlab.ui.control.Label
        EditField_2                matlab.ui.control.NumericEditField
        EditField                  matlab.ui.control.NumericEditField
        ResetButton                matlab.ui.control.Button
        CalculateButton            matlab.ui.control.Button
        barlengthmEditField        matlab.ui.control.NumericEditField
        barlengthmEditFieldLabel   matlab.ui.control.Label
        UIAxes                     matlab.ui.control.UIAxes
        ContextMenu                matlab.ui.container.ContextMenu
        Menu                       matlab.ui.container.Menu
        Menu2                      matlab.ui.container.Menu
        
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create Panel
            app.Panel = uipanel(app.UIFigure);
            app.Panel.Position = [1 1 640 441];

             % Create UIAxes
            app.UIAxes = uiaxes(app.Panel);
            title(app.UIAxes, 'Bar')
            xlabel(app.UIAxes, 'Meter')
            app.UIAxes.CameraTarget = [0.5 0.5 0.5];
            app.UIAxes.CameraUpVector = [0 5 0];
            app.UIAxes.YTick = [];
            app.UIAxes.ZTick = [];
            app.UIAxes.Position = [0 181 637 260];
            app.UIAxes.Color = [0.94 0.94 0.94];

            % Create ParametersPanel
            app.ParametersPanel = uipanel(app.Panel);
            app.ParametersPanel.TitlePosition = 'centertop';
            app.ParametersPanel.Title = 'Parameters';
            app.ParametersPanel.Position = [0 0 639 181];

            % Create barlengthmEditFieldLabel
            app.barlengthmEditFieldLabel = uilabel(app.ParametersPanel);
            app.barlengthmEditFieldLabel.HorizontalAlignment = 'center';
            app.barlengthmEditFieldLabel.FontSize = 10;
            app.barlengthmEditFieldLabel.Position = [8 134 66 22];
            app.barlengthmEditFieldLabel.Text = 'bar length [m]';

            % Create barlengthmEditField
            app.barlengthmEditField = uieditfield(app.ParametersPanel, 'numeric');
            app.barlengthmEditField.Position = [81 134 77 22];

            % Create CalculateButton
            app.CalculateButton = uibutton(app.ParametersPanel, 'push');
            app.CalculateButton.Position = [48 13 71 23];
            app.CalculateButton.Text = 'Calculate';
            app.CalculateButton.ButtonPushedFcn = @(~, ~) CalculateButtonPushed(app);

            % Create ResetButton
            app.ResetButton = uibutton(app.ParametersPanel, 'push');
            app.ResetButton.Position = [48 44 71 23];
            app.ResetButton.Text = 'Reset';
            app.ResetButton.ButtonPushedFcn = createCallbackFcn(app, @ResetButtonPushed, true);

            % Create EditField
            app.EditField = uieditfield(app.ParametersPanel, 'numeric');
            app.EditField.Editable = 'off';
            app.EditField.Value = 1;
            app.EditField.Position = [81 80 50 22];

            % Create EditField_2
            app.EditField_2 = uieditfield(app.ParametersPanel, 'numeric');
            app.EditField_2.Editable = 'off';
            app.EditField_2.Value = 1;
            app.EditField_2.Position = [5 80 46 22];

            % Create StaticdefinitionLabel
            app.StaticdefinitionLabel = uilabel(app.ParametersPanel);
            app.StaticdefinitionLabel.Position = [5 106 86 23];
            app.StaticdefinitionLabel.Text = 'Static definition';

            % Create Label_2
            app.Label_2 = uilabel(app.ParametersPanel);
            app.Label_2.HorizontalAlignment = 'center';
            app.Label_2.Position = [55 81 21 22];
            app.Label_2.Text = '=';

            % Create Lamp
            app.Lamp = uilamp(app.ParametersPanel);
            app.Lamp.Position = [138 82 20 20];
             if app.EditField.Value == app.EditField_2.Value
                app.Lamp.Color = [0 1 0];  % Green
            else
                app.Lamp.Color = [1 0 0];  % Red
            end
            
            % Create StructuralSupportPanel
            app.StructuralSupportPanel = uipanel(app.ParametersPanel);
            app.StructuralSupportPanel.TitlePosition = 'centertop';
            app.StructuralSupportPanel.Title = 'Structural Support';
            app.StructuralSupportPanel.Position = [165 0 153 161];

            % Create LoadsListBox_2
            app.LoadsListBox_2 = uilistbox(app.StructuralSupportPanel);
            app.LoadsListBox_2.Items = {'Simple', 'Pinned', 'Fixed', 'Middle Hinge'};
            app.LoadsListBox_2.Position = [0 66 152 74];
            app.LoadsListBox_2.Value = 'Simple';

            % Create ImplementButton_2
            app.ImplementButton_2 = uibutton(app.StructuralSupportPanel, 'push');
            app.ImplementButton_2.VerticalAlignment = 'top';
            app.ImplementButton_2.FontSize = 10;
            app.ImplementButton_2.Position = [25 3 100 18];
            app.ImplementButton_2.Text = 'Implement';

            % Create PositionmEditField_2Label
            app.PositionmEditField_2Label = uilabel(app.StructuralSupportPanel);
            app.PositionmEditField_2Label.HorizontalAlignment = 'center';
            app.PositionmEditField_2Label.FontSize = 10;
            app.PositionmEditField_2Label.Position = [1 44 73 22];
            app.PositionmEditField_2Label.Text = 'Position [m]';

            % Create PositionmEditField_2
            app.PositionmEditField_2 = uieditfield(app.StructuralSupportPanel, 'numeric');
            app.PositionmEditField_2.Position = [83 44 69 22];

            % Create AddLoadsPanel
            app.AddLoadsPanel = uipanel(app.ParametersPanel);
            app.AddLoadsPanel.TitlePosition = 'centertop';
            app.AddLoadsPanel.Title = 'Add Loads';
            app.AddLoadsPanel.Position = [317 0 152 161];

            % Create LoadsListBox
            app.LoadsListBox = uilistbox(app.AddLoadsPanel);
            app.LoadsListBox.Items = {'Force', 'Bending Moments'};
            app.LoadsListBox.Position = [1 102 151 39];
            app.LoadsListBox.Value = 'Force';

            % Create ForceNNmEditFieldLabel
            app.ForceNNmEditFieldLabel = uilabel(app.AddLoadsPanel);
            app.ForceNNmEditFieldLabel.HorizontalAlignment = 'center';
            app.ForceNNmEditFieldLabel.FontSize = 10;
            app.ForceNNmEditFieldLabel.Position = [3 59 73 22];
            app.ForceNNmEditFieldLabel.Text = 'Force [N]/[N/m]';

            % Create ForceNNmEditField
            app.ForceNNmEditField = uieditfield(app.AddLoadsPanel, 'numeric');
            app.ForceNNmEditField.Position = [74 59 77 22];

            % Create ImplementButton
            app.ImplementButton = uibutton(app.AddLoadsPanel, 'push');
            app.ImplementButton.VerticalAlignment = 'top';
            app.ImplementButton.FontSize = 10;
            app.ImplementButton.Position = [25 3 100 18];
            app.ImplementButton.Text = 'Implement';
            app.ImplementButton.ButtonPushedFcn = createCallbackFcn(app, @ImplementButtonpushed, true);

            % Create PositionmEditFieldLabel
            app.PositionmEditFieldLabel = uilabel(app.AddLoadsPanel);
            app.PositionmEditFieldLabel.HorizontalAlignment = 'right';
            app.PositionmEditFieldLabel.FontSize = 10;
            app.PositionmEditFieldLabel.Position = [-1 38 67 22];
            app.PositionmEditFieldLabel.Text = 'Position [m]';
                
            % Create PositionmEditField
            app.PositionmEditField = uieditfield(app.AddLoadsPanel, 'numeric');
            app.PositionmEditField.Position = [74 38 77 22];

             % Create AngleEditFieldLabel
            app.AngleEditFieldLabel = uilabel(app.AddLoadsPanel);
            app.AngleEditFieldLabel.HorizontalAlignment = 'center';
            app.AngleEditFieldLabel.FontSize = 10;
            app.AngleEditFieldLabel.Position = [9 80 57 22];
            app.AngleEditFieldLabel.Text = 'Angle (deg)';

             % Create AngleEditField
            app.AngleEditField = uieditfield(app.AddLoadsPanel, 'numeric');
            app.AngleEditField.Position = [74 80 77 22];

            % Create AddLineLoadsPanel
            app.AddLineLoadsPanel = uipanel(app.ParametersPanel);
            app.AddLineLoadsPanel.TitlePosition = 'centertop';
            app.AddLineLoadsPanel.Title = 'Add Line Loads';
            app.AddLineLoadsPanel.Position = [467 0 172 161];

            % Create ImplementButton_3
            app.ImplementButton_3 = uibutton(app.AddLineLoadsPanel, 'push');
            app.ImplementButton_3.VerticalAlignment = 'top';
            app.ImplementButton_3.FontSize = 10;
            app.ImplementButton_3.Position = [38 3 100 18];
            app.ImplementButton_3.Text = 'Implement';

            % Create StartmEditFieldLabel
            app.StartmEditFieldLabel = uilabel(app.AddLineLoadsPanel);
            app.StartmEditFieldLabel.HorizontalAlignment = 'center';
            app.StartmEditFieldLabel.FontSize = 10;
            app.StartmEditFieldLabel.Position = [7 76 67 22];
            app.StartmEditFieldLabel.Text = 'Start [m]';

            % Create StartmEditField
            app.StartmEditField = uieditfield(app.AddLineLoadsPanel, 'numeric');
            app.StartmEditField.Position = [76 77 96 22];

            % Create EndmEditFieldLabel
            app.EndmEditFieldLabel = uilabel(app.AddLineLoadsPanel);
            app.EndmEditFieldLabel.HorizontalAlignment = 'center';
            app.EndmEditFieldLabel.FontSize = 10;
            app.EndmEditFieldLabel.Position = [8 54 67 22];
            app.EndmEditFieldLabel.Text = 'End [m]';

            % Create EndmEditField
            app.EndmEditField = uieditfield(app.AddLineLoadsPanel, 'numeric');
            app.EndmEditField.Position = [76 56 96 22];

             % Create exponentnLabel
            app.exponentnLabel = uilabel(app.AddLineLoadsPanel);
            app.exponentnLabel.HorizontalAlignment = 'center';
            app.exponentnLabel.FontSize = 10;
            app.exponentnLabel.Position = [13 118 54 22];
            app.exponentnLabel.Text = 'exponent n';

            % Create exponentnEditField
            app.exponentnEditField = uieditfield(app.AddLineLoadsPanel, 'numeric');
            app.exponentnEditField.Position = [76 119 96 22];

            % Create pitchkEditFieldLabel
            app.pitchkEditFieldLabel = uilabel(app.AddLineLoadsPanel);
            app.pitchkEditFieldLabel.HorizontalAlignment = 'center';
            app.pitchkEditFieldLabel.FontSize = 10;
            app.pitchkEditFieldLabel.Position = [13 97 55 22];
            app.pitchkEditFieldLabel.Text = 'pitch k';

            % Create pitchkEditField
            app.pitchkEditField = uieditfield(app.AddLineLoadsPanel, 'numeric');
            app.pitchkEditField.Position = [76 98 96 22];

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.BackgroundColor = [0.05 0.33 0.69];
            app.Label.HorizontalAlignment = 'center';
            app.Label.FontSize = 14;
            app.Label.FontWeight = 'bold';
            app.Label.Position = [1 441 640 40];
            app.Label.Text = 'Program for the calculation of internal forces and reactions inside of bars';
            app.Label.FontColor = [1 1 1];
            % Create ContextMenu
            app.ContextMenu = uicontextmenu(app.UIFigure);

            % Create Menu
            app.Menu = uimenu(app.ContextMenu);
            app.Menu.Text = 'Menu';

            % Create Menu2
            app.Menu2 = uimenu(app.ContextMenu);
            app.Menu2.Text = 'Menu2';

            app.barlengthmEditField.ValueChangedFcn = @(~,~) barlengthmEditFieldValueChanged(app);

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end
 % Callbacks that handle component events
    methods (Access = private)

        % Callback function for ResetButton
        function ResetButtonPushed(app, ~)
            % Reset all input fields
            app.barlengthmEditField.Value = 0;
            app.EditField.Value = 0;
            app.EditField_2.Value = 0;
            app.PositionmEditField.Value = 0;
            app.ForceNNmEditField.Value = 0;
            app.PositionmEditField_2.Value = 0;
            app.StartmEditField.Value = 0;
            app.EndmEditField.Value = 0;
            app.AngleEditField.Value = 0;
            app.exponentnEditField.Value = 0;
            app.pitchkEditField.Value = 0;
            app.Lamp.Color = [0 1 0];
        end
    end

    methods (Access = private)
        function CalculateButtonPushed(~)
            Kraefteverlauf_skript;
        end
    end

   methods (Access = private)
    function drawBar(app)
        % Get the length of the bar from the edit field
        barLength = app.barlengthmEditField.Value;
        % Clear previous plots
        cla(app.UIAxes);
        % Plot the bar as a line in the UIAxes    
        plot(app.UIAxes, [0 barLength], [0 0], 'LineWidth', 3, 'Color',[0 0 0]);
        % Set the axes limits to fit the bar
        xlim(app.UIAxes, [0 barLength + 0.005 * barLength]);
        ylim(app.UIAxes, [-0.5 0.5]);
    end

    % Callback for barlengthmEditField ValueChanged event
    function barlengthmEditFieldValueChanged(app, ~)
        drawBar(app);
    end
   end

   %Implement Button
   methods (Access = private)

       function ImplementButtonpushed(app, ~)
        
       quiver(app.UIAxes,0,0,1,0,'b','filled','LineWidth',3, 'Color', [1,0,0]);
       end
   end
     
    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Eingabe_skript

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