classdef Eingabe_skript < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                   matlab.ui.Figure
        Label                      matlab.ui.control.Label
        Panel                      matlab.ui.container.Panel
        ParametersPanel            matlab.ui.container.Panel
        ButtonGroupKraft           matlab.ui.container.ButtonGroup
        ButtonPunkt                matlab.ui.control.ToggleButton
        ButtonMoment               matlab.ui.control.ToggleButton
        ButtonGroupStrecke         matlab.ui.container.ButtonGroup
        ButtonKonstant             matlab.ui.control.ToggleButton
        ButtonLinear               matlab.ui.control.ToggleButton
        ButtonKurve                matlab.ui.control.ToggleButton
        AddLineLoadsPanel          matlab.ui.container.Panel
        StartheightEditField       matlab.ui.control.NumericEditField
        StartheightEditFieldLabel  matlab.ui.control.Label
        pitchkEditField            matlab.ui.control.NumericEditField
        pitchkEditFieldLabel       matlab.ui.control.Label
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
        StructuralSupportPanel     matlab.ui.container.Panel
        ButtonGroupLager           matlab.ui.container.ButtonGroup
        ButtonGelenk               matlab.ui.control.ToggleButton
        ButtonFestlager            matlab.ui.control.ToggleButton
        ButtonLoslager             matlab.ui.control.ToggleButton
        ButtonEinspannung          matlab.ui.control.ToggleButton
        PositionmEditField_2       matlab.ui.control.NumericEditField
        PositionmEditField_2Label  matlab.ui.control.Label
        ImplementButton_2          matlab.ui.control.Button
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
    methods (Access = public)
 
        % Create UIFigure and components
        function createComponents(app)

            structureinitiate;
           
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
            app.UIAxes.YTick = [];
            app.UIAxes.Position = [0 181 637 260];

            % Create ParametersPanel
            app.ParametersPanel = uipanel(app.Panel);
            app.ParametersPanel.TitlePosition = 'centertop';
            app.ParametersPanel.Title = '';
            app.ParametersPanel.Position = [0 0 640 181];

            % Create barlengthmEditFieldLabel
            app.barlengthmEditFieldLabel = uilabel(app.ParametersPanel);
            app.barlengthmEditFieldLabel.HorizontalAlignment = 'center';
            app.barlengthmEditFieldLabel.FontSize = 12;
            app.barlengthmEditFieldLabel.Position = [8 154 80 22];
            app.barlengthmEditFieldLabel.Text = '[bar length] m';

            % Create barlengthmEditField
            app.barlengthmEditField = uieditfield(app.ParametersPanel, 'numeric');
            app.barlengthmEditField.Position = [91 154 68 22];
            app.barlengthmEditField.AllowEmpty = "on";
            app.barlengthmEditField.Value = [];
            app.barlengthmEditField.ValueChangedFcn = @(~,~) barlengthmEditFieldValueChanged(app);

            % Create CalculateButton
            app.CalculateButton = uibutton(app.ParametersPanel, 'push');
            app.CalculateButton.Position = [48 33 71 23];
            app.CalculateButton.Text = 'Calculate';
            app.CalculateButton.ButtonPushedFcn = @(~, ~) CalculateButtonPushed(app);

            % Create ResetButton
            app.ResetButton = uibutton(app.ParametersPanel, 'push');
            app.ResetButton.Position = [48 64 71 23];
            app.ResetButton.Text = 'Reset';
            app.ResetButton.ButtonPushedFcn = createCallbackFcn(app, @ResetButtonPushed, true);

            % Create EditField
            app.EditField = uieditfield(app.ParametersPanel, 'numeric');
            app.EditField.Editable = 'off';
            app.EditField.Value = 0;
            app.EditField.Position = [81 100 50 22]; 

            % Create EditField_2
            app.EditField_2 = uieditfield(app.ParametersPanel, 'numeric');
            app.EditField_2.Editable = 'off';
            app.EditField_2.Value = 0;
            app.EditField_2.Position = [5 100 46 22];

            % Create StaticdefinitionLabel
            app.StaticdefinitionLabel = uilabel(app.ParametersPanel);
            app.StaticdefinitionLabel.Position = [5 123 86 23];
            app.StaticdefinitionLabel.Text = 'Static definition';

            % Create Label_2
            app.Label_2 = uilabel(app.ParametersPanel);
            app.Label_2.HorizontalAlignment = 'center';
            app.Label_2.Position = [55 100 21 22];
            app.Label_2.Text = '=';

            % Create Lamp
            app.Lamp = uilamp(app.ParametersPanel);
            app.Lamp.Position = [138 100 20 20];
            app.Lamp.Color = [0 1 0];  % Green
            
            % Create StructuralSupportPanel
            app.StructuralSupportPanel = uipanel(app.ParametersPanel);
            app.StructuralSupportPanel.TitlePosition = 'centertop';
            app.StructuralSupportPanel.Title = 'Structural Support';
            app.StructuralSupportPanel.Position = [165 0 153 181];

            % Create ImplementButton_2
            app.ImplementButton_2 = uibutton(app.StructuralSupportPanel, 'push');
            app.ImplementButton_2.VerticalAlignment = 'top';
            app.ImplementButton_2.FontSize = 12;
            app.ImplementButton_2.Position = [25 3 100 23];
            app.ImplementButton_2.Text = 'Implement';
            app.ImplementButton_2.ButtonPushedFcn = @(~,~) ImplementButton2pushed(app);

            % Create ButtonGroupKräfte
            app.ButtonGroupLager = uibuttongroup(app.StructuralSupportPanel);
            app.ButtonGroupLager.Position = [1 50 150 110];
            app.ButtonGroupLager.BorderWidth = 0;

            % Create Button
            app.ButtonGelenk = uitogglebutton(app.ButtonGroupLager,"Icon","hinge.png","IconAlignment","top");
            app.ButtonGelenk.Icon = "hinge.png";
            app.ButtonGelenk.Text = '';
            app.ButtonGelenk.Position = [78 27 70 39];

            % Create ButtonFestlager
            app.ButtonFestlager = uitogglebutton(app.ButtonGroupLager,"Icon","fixed_bearing.png","IconAlignment","top");
            app.ButtonFestlager.Icon = "fixed_bearing.png";
            app.ButtonFestlager.Text = '';
            app.ButtonFestlager.Position = [78 69 70 39];

            % Create ButtonLoslager
            app.ButtonLoslager = uitogglebutton(app.ButtonGroupLager,"Icon","loose_bearing.png","IconAlignment","top");
            app.ButtonLoslager.Icon = "loose_bearing.png";
            app.ButtonLoslager.Text = '';
            app.ButtonLoslager.Position = [5 69 70 39];

            % Create ButtonEinspannung
            app.ButtonEinspannung = uitogglebutton(app.ButtonGroupLager,"Icon","clamped_support.png","IconAlignment","top");
            app.ButtonEinspannung.Icon = "clamped_support.png";
            app.ButtonEinspannung.Text = '';
            app.ButtonEinspannung.Position = [5 27 70 39];

            % Create PositionmEditField_2Label
            app.PositionmEditField_2Label = uilabel(app.StructuralSupportPanel);
            app.PositionmEditField_2Label.HorizontalAlignment = 'center';
            app.PositionmEditField_2Label.FontSize = 12;
            app.PositionmEditField_2Label.Position = [1 50 74 22];
            app.PositionmEditField_2Label.Text = '[Position] m';

            % Create PositionmEditField_2
            app.PositionmEditField_2 = uieditfield(app.StructuralSupportPanel, 'numeric');
            app.PositionmEditField_2.Position = [83 50 64 22];
            app.PositionmEditField_2.AllowEmpty = "on";
            app.PositionmEditField_2.Value = [];

            % Create AddLoadsPanel
            app.AddLoadsPanel = uipanel(app.ParametersPanel);
            app.AddLoadsPanel.TitlePosition = 'centertop';
            app.AddLoadsPanel.Title = 'Add Loads';
            app.AddLoadsPanel.Position = [317 0 152 181];

            % Create ForceNNmEditFieldLabel
            app.ForceNNmEditFieldLabel = uilabel(app.AddLoadsPanel);
            app.ForceNNmEditFieldLabel.HorizontalAlignment = 'center';
            app.ForceNNmEditFieldLabel.FontSize = 12;
            app.ForceNNmEditFieldLabel.Position = [1 71 78 22];
            app.ForceNNmEditFieldLabel.Text = '[Force] N N/m';

            % Create ForceNNmEditField
            app.ForceNNmEditField = uieditfield(app.AddLoadsPanel, 'numeric');
            app.ForceNNmEditField.Position = [83 71 64 22];
            app.ForceNNmEditField.AllowEmpty = "on";
            app.ForceNNmEditField.Value = [];

            % Create ImplementButton
            app.ImplementButton = uibutton(app.AddLoadsPanel, 'push');
            app.ImplementButton.VerticalAlignment = 'top';
            app.ImplementButton.FontSize = 12;
            app.ImplementButton.Position = [25 3 100 23];
            app.ImplementButton.Text = 'Implement';
            app.ImplementButton.ButtonPushedFcn = @(~,~) ImplementButtonpushed(app);

            % Create PositionmEditFieldLabel
            app.PositionmEditFieldLabel = uilabel(app.AddLoadsPanel);
            app.PositionmEditFieldLabel.HorizontalAlignment = 'right';
            app.PositionmEditFieldLabel.FontSize = 12;
            app.PositionmEditFieldLabel.Position = [1 50 74 22];
            app.PositionmEditFieldLabel.Text = '[Position] m';
                
            % Create PositionmEditField
            app.PositionmEditField = uieditfield(app.AddLoadsPanel, 'numeric');
            app.PositionmEditField.Position = [83 50 64 22];
            app.PositionmEditField.AllowEmpty = "on";
            app.PositionmEditField.Value = [];

             % Create AngleEditFieldLabel
            app.AngleEditFieldLabel = uilabel(app.AddLoadsPanel);
            app.AngleEditFieldLabel.HorizontalAlignment = 'center';
            app.AngleEditFieldLabel.FontSize = 12;
            app.AngleEditFieldLabel.Position = [1 92 74 22];
            app.AngleEditFieldLabel.Text = '[Angle] deg';

             % Create AngleEditField
            app.AngleEditField = uieditfield(app.AddLoadsPanel, 'numeric');
            app.AngleEditField.Position = [83 92 64 22];
            app.AngleEditField.AllowEmpty = "on";
            app.AngleEditField.Value = 90;

            % Create AddLineLoadsPanel
            app.AddLineLoadsPanel = uipanel(app.ParametersPanel);
            app.AddLineLoadsPanel.TitlePosition = 'centertop';
            app.AddLineLoadsPanel.Title = 'Add Line Loads';
            app.AddLineLoadsPanel.Position = [467 0 173 181];

            % Create ImplementButton_3
            app.ImplementButton_3 = uibutton(app.AddLineLoadsPanel, 'push');
            app.ImplementButton_3.VerticalAlignment = 'top';
            app.ImplementButton_3.FontSize = 12;
            app.ImplementButton_3.Position = [38 3 100 23];
            app.ImplementButton_3.Text = 'Implement';
            app.ImplementButton_3.ButtonPushedFcn = @(~,~) ImplementButtonpushed3(app);

            % Create StartmEditFieldLabel
            app.StartmEditFieldLabel = uilabel(app.AddLineLoadsPanel);
            app.StartmEditFieldLabel.HorizontalAlignment = 'center';
            app.StartmEditFieldLabel.FontSize = 12;
            app.StartmEditFieldLabel.Position = [8 72 67 22];
            app.StartmEditFieldLabel.Text = '[Start] m';

            % Create StartmEditField
            app.StartmEditField = uieditfield(app.AddLineLoadsPanel, 'numeric');
            app.StartmEditField.Position = [84 72 84 22];
            app.StartmEditField.AllowEmpty = "on";
            app.StartmEditField.Value = [];

            % Create EndmEditFieldLabel
            app.EndmEditFieldLabel = uilabel(app.AddLineLoadsPanel);
            app.EndmEditFieldLabel.HorizontalAlignment = 'center';
            app.EndmEditFieldLabel.FontSize = 12;
            app.EndmEditFieldLabel.Position = [1 51 84 22];
            app.EndmEditFieldLabel.Text = '[End] m';

            % Create EndmEditField
            app.EndmEditField = uieditfield(app.AddLineLoadsPanel, 'numeric');
            app.EndmEditField.Position = [84 51 84 22];
            app.EndmEditField.AllowEmpty = "on";
            app.EndmEditField.Value = [];

            % Create pitchkEditFieldLabel
            app.pitchkEditFieldLabel = uilabel(app.AddLineLoadsPanel);
            app.pitchkEditFieldLabel.HorizontalAlignment = 'center';
            app.pitchkEditFieldLabel.FontSize = 12;
            app.pitchkEditFieldLabel.Position = [14 93 55 22];
            app.pitchkEditFieldLabel.Text = '[pitch]';

            % Create pitchkEditField
            app.pitchkEditField = uieditfield(app.AddLineLoadsPanel, 'numeric');
            app.pitchkEditField.Position = [84 93 84 22];
            app.pitchkEditField.AllowEmpty = "on";
            app.pitchkEditField.Value = [];

            % Create StartheightEditFieldLabel
            app.StartheightEditFieldLabel = uilabel(app.AddLineLoadsPanel);
            app.StartheightEditFieldLabel.HorizontalAlignment = 'center';
            app.StartheightEditFieldLabel.FontSize = 12;
            app.StartheightEditFieldLabel.Position = [1 30 84 22];
            app.StartheightEditFieldLabel.Text = '[Start height] m';

            % Create StartheightEditField
            app.StartheightEditField = uieditfield(app.AddLineLoadsPanel, 'numeric');
            app.StartheightEditField.Position = [84 30 84 22];
            app.StartheightEditField.AllowEmpty = "on";
            app.StartheightEditField.Value = [];

            % Create ButtonGroupKraft
            app.ButtonGroupKraft = uibuttongroup(app.AddLoadsPanel);
            app.ButtonGroupKraft.Title = '';
            app.ButtonGroupKraft.Position = [1 118 150 40];
            app.ButtonGroupKraft.BorderWidth = 0;

            % Create ButtonPunkt
            app.ButtonPunkt = uitogglebutton(app.ButtonGroupKraft,"Icon","force.png","IconAlignment","top");
            app.ButtonPunkt.Icon = "force.png";
            app.ButtonPunkt.Text = '';
            app.ButtonPunkt.Position = [4 1 70 39];

            % Create ButtonMoment
            app.ButtonMoment = uitogglebutton(app.ButtonGroupKraft,"Icon","moment.png","IconAlignment","top");
            app.ButtonMoment.Icon = "moment.png";
            app.ButtonMoment.Text = '';
            app.ButtonMoment.Position = [77 1 70 39];

             % Create ButtonGroupStreckenlast
            app.ButtonGroupStrecke = uibuttongroup(app.AddLineLoadsPanel);
            app.ButtonGroupStrecke.Title = '';
            app.ButtonGroupStrecke.Position = [1 118 170 40];
            app.ButtonGroupStrecke.BorderWidth = 0;

            % Create Button konstante Streckenlast
            app.ButtonKonstant = uitogglebutton(app.ButtonGroupStrecke,"Icon","constant_load.png","IconAlignment","top");
            app.ButtonKonstant.Icon = "constant_load.png";
            app.ButtonKonstant.Text = '';
            app.ButtonKonstant.Position = [2 1 55 39];

            % Create Button lineare Streckenlast
            app.ButtonLinear = uitogglebutton(app.ButtonGroupStrecke,"Icon","linear_load.png","IconAlignment","top");
            app.ButtonLinear.Icon = "linear_load.png";
            app.ButtonLinear.Text = '';
            app.ButtonLinear.Position = [59 1 55 39];

            % Create Button quadratische Streckenlast
            app.ButtonKurve = uitogglebutton(app.ButtonGroupStrecke,"Icon","quadratic_load.png","IconAlignment","top");
            app.ButtonKurve.Icon = "quadratic_load.png";
            app.ButtonKurve.Text = '';
            app.ButtonKurve.Position = [116 1 55 39];

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

            

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end

    end

 % Callbacks that handle component events
    methods (Access = private)
 
        % Callback function for ResetButton
        function ResetButtonPushed(app, ~)
            % Reset all input fields
            app.barlengthmEditField.Value = [];
            app.EditField.Value = 0;
            app.EditField_2.Value = 0;
            app.PositionmEditField.Value = [];
            app.ForceNNmEditField.Value = [];
            app.PositionmEditField_2.Value = [];
            app.StartmEditField.Value = [];
            app.EndmEditField.Value = [];
            app.AngleEditField.Value = [];
            app.pitchkEditField.Value = [];
            app.StartheightEditField.Value = [];
            app.pitchkEditField.Value = [];
            %app.barlengthmEditField.Editable = "on";
            app.Lamp.Color = [0 1 0];
            cla (app.UIAxes, 'reset');

            structureinitiate;

        end

    end
 
    methods (Access = private)

        function barlengthmEditFieldValueChanged(app)
        %Graphische Darstellung
        cla (app.UIAxes, 'reset');
        X = [0 app.barlengthmEditField.Value];
        Y = [0 0];
        global lbar;
        lbar = app.barlengthmEditField.Value;
        plot(app.UIAxes,X,Y,'LineWidth',4,'Color','k');
        hold(app.UIAxes,'on')
        %xlim(app.UIAxes, [-1 (bar1length + 1)]);
        %ylim(app.UIAxes, [-1 1]);

        % if app.barlengthmEditField.Value ~= 0
        %     app.barlengthmEditField.Editable = 'off';
        % end

        %Statische Bestimmtheit
        app.EditField_2.Value = 3;
        app.EditField.Value = 0;
        staticallyindeterminateValueChanged(app);
        
        end

    end

    methods (Access = private)

        function CalculateButtonPushed(~)
            global lbar;
            calcformulas(lbar);
        end

    end
    
   %Implement Button für Lager
   methods (Access = private)

       function ImplementButton2pushed(app)

          if isempty(any(app.PositionmEditField_2.Value)) || (any(app.PositionmEditField_2.Value > app.barlengthmEditField.Value))
              return
          end

          %Festlager
        if app.ButtonFestlager.Value == true
            %Graphische Darstellung
            bearing1_pos = app.PositionmEditField_2.Value;   % position of bearing1
            bearing1_angle = 0; % angle of bearing1
            bearing1hatchingshift = 0;
    
            bearing1scale = (app.barlengthmEditField.Value/15);    % size of the bearing = 1/10 of bar length
            Bearing1X = [0 (1/2) (-1/2) 0];
            Bearing1Y = [0 (-1) (-1) 0];
            Bearing1BaseX = [-1 1];
            Bearing1BaseY = [-1 -1] + bearing1hatchingshift;
            Bearing1Hatching1X = [(-1/2) -1];
            Bearing1Hatching1Y = [-1 (-3/2)] + bearing1hatchingshift;
            Bearing1Hatching2X = [0 (-1/2)];
            Bearing1Hatching2Y = [-1 (-3/2)] + bearing1hatchingshift;
            Bearing1Hatching3X = [(1/2) 0];
            Bearing1Hatching3Y = [-1 (-3/2)] + bearing1hatchingshift;
            bearing1phi = deg2rad(bearing1_angle);
            BearingR1 = [cos(bearing1phi) -sin(bearing1phi); sin(bearing1phi) cos(bearing1phi)];
            Bearing1 = [Bearing1X NaN Bearing1BaseX NaN Bearing1Hatching1X NaN Bearing1Hatching2X NaN Bearing1Hatching3X; Bearing1Y NaN Bearing1BaseY NaN Bearing1Hatching1Y NaN Bearing1Hatching2Y NaN Bearing1Hatching3Y] * bearing1scale;
            Bearing1Rotated = BearingR1 * Bearing1;
            Bearing1XRotated = Bearing1Rotated(1,:) + bearing1_pos;
            Bearing1YRotated = Bearing1Rotated(2,:);
            plot(app.UIAxes,Bearing1XRotated,Bearing1YRotated,'LineWidth',2,'Color','k');   % plot bearing1
            grid(app.UIAxes,'on')
            axis(app.UIAxes,'equal')
            axis(app.UIAxes,'padded')
            hold(app.UIAxes,'on')

            %Statische Bestimmtheit
            app.EditField.Value = app.EditField.Value + 2;
            staticallyindeterminateValueChanged(app);

            %Übergabe in main.Bearing
            AddBearing(bearing1_pos, 1, 1, 0);

        end

        %Loslager
        if app.ButtonLoslager.Value == true
            %Graphische Darstellung
            bearing2_pos = app.PositionmEditField_2.Value;   % position of bearing1
            bearing2_angle = 0; % angle of bearing1
            % define bearing2
            bearing2hatchingshift = (-1/4);
            bearing2scale = (app.barlengthmEditField.Value/15);    % size of the bearing = 1/10 of bar length
            Bearing2X = [0 (1/2) (-1/2) 0];
            Bearing2Y = [0 (-1) (-1) 0];
            Bearing2BaseX = [-1 1];
            Bearing2BaseY = [-1 -1] + bearing2hatchingshift;
            Bearing2Hatching1X = [(-1/2) -1];
            Bearing2Hatching1Y = [-1 (-3/2)] + bearing2hatchingshift;
            Bearing2Hatching2X = [0 (-1/2)];
            Bearing2Hatching2Y = [-1 (-3/2)] + bearing2hatchingshift;
            Bearing2Hatching3X = [(1/2) 0];
            Bearing2Hatching3Y = [-1 (-3/2)] + bearing2hatchingshift;
            bearing2phi = deg2rad(bearing2_angle);
            BearingR2 = [cos(bearing2phi) -sin(bearing2phi); sin(bearing2phi) cos(bearing2phi)];
            Bearing2 = [Bearing2X NaN Bearing2BaseX NaN Bearing2Hatching1X NaN Bearing2Hatching2X NaN Bearing2Hatching3X; Bearing2Y NaN Bearing2BaseY NaN Bearing2Hatching1Y NaN Bearing2Hatching2Y NaN Bearing2Hatching3Y] * bearing2scale;
            Bearing2Rotated = BearingR2 * Bearing2;
            Bearing2XRotated = Bearing2Rotated(1,:) + bearing2_pos;
            Bearing2YRotated = Bearing2Rotated(2,:);
            plot(app.UIAxes, Bearing2XRotated,Bearing2YRotated,'LineWidth',2,'Color','k');   % plot bearing2
            grid(app.UIAxes,'on')
            axis(app.UIAxes,'equal')
            axis(app.UIAxes,'padded')
            hold(app.UIAxes,'on')

            %Statische Bestimmtheit
            app.EditField.Value = app.EditField.Value + 1;
            staticallyindeterminateValueChanged(app);

            %Übergabe in main.Bearing
            AddBearing(bearing2_pos, 1, 0, 0);

        end

            %Festspannung
            if (app.ButtonEinspannung.Value == true) &&  (app.PositionmEditField_2.Value == 0)
                %Graphische Darstellung
                clampedsupportscale = app.barlengthmEditField.Value/15;    % size of the support = 1/10 of bar length
                ClampedSupportX = [0 0 0];
                ClampedSupportY = [0 1 -1];
                ClampedSupportHatching1X = [0 (-1/2)];
                ClampedSupportHatching1Y = [0 (-1/2)] + 1;
                ClampedSupportHatching2X = [0 (-1/2)];
                ClampedSupportHatching2Y = [0 (-1/2)] + (1/2);
                ClampedSupportHatching3X = [0 (-1/2)];
                ClampedSupportHatching3Y = [0 (-1/2)];
                ClampedSupportHatching4X = [0 (-1/2)];
                ClampedSupportHatching4Y = [0 (-1/2)] + (-1/2);
                ClampedSupport = [...
        ClampedSupportX NaN ClampedSupportHatching1X NaN ClampedSupportHatching2X NaN ClampedSupportHatching3X NaN ClampedSupportHatching4X; 
        ClampedSupportY NaN ClampedSupportHatching1Y NaN ClampedSupportHatching2Y NaN ClampedSupportHatching3Y NaN ClampedSupportHatching4Y] ...
        * clampedsupportscale;
                ClampedSupportXRotated = ClampedSupport(1,:) + app.PositionmEditField_2.Value;
                ClampedSupportYRotated = ClampedSupport(2,:);
                plot(app.UIAxes,ClampedSupportXRotated,ClampedSupportYRotated,'LineWidth',2,'Color','k');   % plot bearing2
                grid(app.UIAxes,'on')
                axis(app.UIAxes,'equal')
                axis(app.UIAxes,'padded')
                hold(app.UIAxes,'on')

                %Statische Bestimmtheit
                app.EditField.Value = app.EditField.Value + 3;
                staticallyindeterminateValueChanged(app);
 
                %Übergabe in main.Bearing
                AddBearing(0, 1, 1, 1);

            end

            % if strcmp(selectedItem, 'Fixed') && (app.PositionmEditField_2.Value == app.barlengthmEditField.Value)
            %     %Graphische Darstellung
            %     clampedsupportscale = (app.barlengthmEditField.Value/15);    % size of the support = 1/10 of bar length
            %     support_position = app.PositionmEditField_2.Value;
            % 
            %     ClampedSupportX = [0 0 0] + support_position;
            %     ClampedSupportY = [0 1 -1];
            %     ClampedSupportHatching1X = [0 (1/2)] + support_position;
            %     ClampedSupportHatching1Y = [0 (-1/2)] + 1;
            %     ClampedSupportHatching2X = [0 (1/2)] + support_position;
            %     ClampedSupportHatching2Y = [0 (-1/2)] + (1/2);
            %     ClampedSupportHatching3X = [0 (1/2)] + support_position;
            %     ClampedSupportHatching3Y = [0 (-1/2)];
            %     ClampedSupportHatching4X = [0 (1/2)] + support_position;
            %     ClampedSupportHatching4Y = [0 (-1/2)] + (-1/2);
            %     ClampedSupport = [...
            %     ClampedSupportX NaN ClampedSupportHatching1X NaN ClampedSupportHatching2X NaN ClampedSupportHatching3X NaN ClampedSupportHatching4X; 
            %     ClampedSupportY NaN ClampedSupportHatching1Y NaN ClampedSupportHatching2Y NaN ClampedSupportHatching3Y NaN ClampedSupportHatching4Y] ...
            %     * clampedsupportscale;
            %     ClampedSupportXRotated = ClampedSupport(1,:) + app.PositionmEditField_2.Value;
            %     ClampedSupportYRotated = ClampedSupport(2,:);
            %     plot(app.UIAxes,ClampedSupportXRotated,ClampedSupportYRotated,'LineWidth',2,'Color','k');   % plot bearing2
            %     grid(app.UIAxes,'on')
            %     axis(app.UIAxes,'equal')
            %     axis(app.UIAxes,'padded')
            %     hold(app.UIAxes,'on')
            % 
            %     %Statische Bestimmtheit
            %     app.EditField.Value = app.EditField.Value + 3;
            %     staticallyindeterminateValueChanged(app);
            % 
            % end

            %Momentengelenk
            if app.ButtonGelenk.Value == true
                %Graphische Darstellung
                momentjoint1_pos = app.PositionmEditField_2.Value; 
                momentjoint1scale = (app.barlengthmEditField.Value/60);   % size of the joint = 1/60 of bar length
                MomentJoint1X = [0 1 (0.866) (0.5) 0 (-0.5) (-0.866) (-1) (-0.866) (-0.5) 0 (0.5) (0.866) 1] * momentjoint1scale;
                MomentJoint1Y = [0 0 (0.5) (0.866) 1 (0.866) (0.5) 0 (-0.5) (-0.866) (-1) (-0.866) (-0.5) 0] * momentjoint1scale;
                MomentJoint1XRotated = MomentJoint1X + momentjoint1_pos;
                MomentJoint1YRotated = MomentJoint1Y;
                plot(app.UIAxes, MomentJoint1XRotated(2:14),MomentJoint1YRotated(2:14),'LineWidth',2,'Color','k');   % plot momentjoint1
                grid(app.UIAxes,'on')
                axis(app.UIAxes,'equal')
                axis(app.UIAxes,'padded')
                hold(app.UIAxes,'on')
                
                %Statische Bestimmtheit
                app.EditField.Value = app.EditField.Value + 2;
                app.EditField_2.Value = app.EditField_2.Value + 3;
                staticallyindeterminateValueChanged(app);

            end

        end 
       
       end
 

   %Implement Button für Kräfte
   methods (Access = private)

       function ImplementButtonpushed(app)

        %punktuelle Kraft
        if app.ButtonPunkt.Value == true

            if any(app.ForceNNmEditField.Value == 0) || isempty(app.ForceNNmEditField.Value)
                return
            else
               %Graphische Darstellung
                arrow2_angle = app.AngleEditField.Value;    % angle of arrow2
                arrow2_pos = app.PositionmEditField.Value; % position of arrow2
                
                % define arrow2
                arrow2_length = 2;
                arrow2scale = ((app.barlengthmEditField.Value/arrow2_length)/10);    % length of the arrow = 1/10 of bar length
                arrow2phi = deg2rad(arrow2_angle-180);
                TextArrow2X = (-6/4) * arrow2_length;
                TextArrow2Y = (-2/4) * arrow2_length;
                Line2X = [(-4/4) (-1/4)] * arrow2_length;    % define the line of arrow2
                Line2Y = [0 0];  % define the line of arrow2
                Arrow2X = [(-1/4) (-1/4) 0 (-1/4) (-1/4)];   % define the tip of arrow2
                Arrow2Y = [0 (1/4) 0 (-1/4) 0];  % define the tip of arrow2
                Arrow2R = [cos(arrow2phi) -sin(arrow2phi); sin(arrow2phi) cos(arrow2phi)];
                Arrow2 = [TextArrow2X Line2X Arrow2X; TextArrow2Y Line2Y Arrow2Y] * arrow2scale;
                Arrow2Rotated = Arrow2R * Arrow2;
                Arrow2XRotated = Arrow2Rotated(1,:) + arrow2_pos;
                Arrow2YRotated = Arrow2Rotated(2,:);
                plot(app.UIAxes,Arrow2XRotated(2:8),Arrow2YRotated(2:8),'LineWidth',2,'Color','r');   % plot arrow2
                %text(app.UIAxes,Arrow2XRotated(1),Arrow2YRotated(1),'F','Fontsize',15,'Color','r');   % name arrow2
                grid(app.UIAxes,'on')
                axis(app.UIAxes,'equal')
                axis(app.UIAxes,'padded')
                
                %Aufrufen der Funktion
                AddForce(app.PositionmEditField.Value,app.AngleEditField.Value,app.ForceNNmEditField.Value);
            end
        end
        if app.ButtonMoment.Value == true

            %Moment
            if any(app.ForceNNmEditField.Value == 0) || isempty(app.ForceNNmEditField.Value)
                return
            else
            %Graphische Darstellung
            moment1_pos = app.PositionmEditField.Value;
            moment1scale = (app.barlengthmEditField.Value/30);   % size of the joint = 1/30 of bar length
            Moment1X = [0 NaN 1 (0.866) (0.5) 0 NaN (-1) (-0.866) (-0.5) 0 (0.5) (0.866) 1];
            Moment1Y = [0 NaN 0 (0.5) (0.866) 1 NaN 0 (-0.5) (-0.866) (-1) (-0.866) (-0.5) 0];
            MomentArrow1X = [(1/4) (1/4) 0 (1/4) (1/4)];   % define the tip of moment1
            MomentArrow1Y = [0 (1/4) 0 (-1/4) 0];  % define the tip of moment1
            momentarrow1phi = deg2rad(-15);
            MomentArrow1R = [cos(momentarrow1phi) -sin(momentarrow1phi); sin(momentarrow1phi) cos(momentarrow1phi)];
            MomentArrow1 = [MomentArrow1X; MomentArrow1Y];
            MomentArrow1Rotated = MomentArrow1R * MomentArrow1;
            TextMoment1X = 1 + (1/2);
            TextMoment1Y = 1 + (1/2);
            Moment1 = [TextMoment1X NaN Moment1X NaN MomentArrow1Rotated(1,:); TextMoment1Y NaN Moment1Y NaN MomentArrow1Rotated(2,:)+1] * moment1scale;
            Moment1XRotated = Moment1(1,:) + moment1_pos;
            Moment1YRotated = Moment1(2,:);
            plot(app.UIAxes, Moment1XRotated(2:22),Moment1YRotated(2:22),'LineWidth',2,'Color','green');
            grid(app.UIAxes,'on')
            axis(app.UIAxes,'equal')
            axis(app.UIAxes,'padded')

            %Übergabe in main-Structure
            AddTorque(app.PositionmEditField.Value,app.ForceNNmEditField.Value);
            end
        end
       

       end

   end
   

   %Streckenlasten
   methods (Access = private)

       function ImplementButtonpushed3(app)

          if isempty(app.pitchkEditField.Value) || isempty(app.StartheightEditField.Value) || isempty(app.EndmEditField.Value) || isempty(app.StartmEditField.Value) || (app.StartmEditField.Value > app.barlengthmEditField.Value) || (app.EndmEditField.Value > app.barlengthmEditField.Value)
            return
          end
        
          if app.ButtonKonstant.Value == true
              constshape1exponent = 0;
          elseif app.ButtonLinear.Value == true
              constshape1exponent = 1;
          elseif app.ButtonKurve.Value == true
              constshape1exponent = 2;
          end
             
        constshape1_startpos = app.StartmEditField.Value;    % start position of constshape1
        constshape1_endpos = app.EndmEditField.Value;   % end position of constshape1
        constshape1_angle = 90;  % angle of shape1

        %Streckenlast
        % define constshape1
        constshape1scale = (app.barlengthmEditField.Value/2);    % size of the shape = 1/10 of bar length
        constshape1pitch = app.pitchkEditField.Value;
        constshape1_startheigth = app.StartheightEditField.Value;
        %constshape1_endheight = ((constshape1_endpos - constshape1_startpos)^1) * constshape1_startpos;
        ConstShape1XBetween = linspace(constshape1_startpos,constshape1_endpos);
        ConstShape1YBetween = ((ConstShape1XBetween - constshape1_startpos) .^ constshape1exponent);                                          %linspace(0,((constshape1_endpos - constshape1_startpos)^1) * constshape1_startpos);
        ConstShape1X = [constshape1_startpos ConstShape1XBetween constshape1_endpos];
        ConstShape1Y = [0 (constshape1pitch*((ConstShape1YBetween/ConstShape1YBetween(99:99))*constshape1scale) + constshape1_startheigth) 0] * constshape1scale/80;
        TextConstShape1X = constshape1_endpos + (1/2);
        TextConstShape1Y = ConstShape1Y(102:102) + (1/2) * constshape1scale;
        constshape1phi = deg2rad(constshape1_angle-90);
        ConstShape1R = [cos(constshape1phi) -sin(constshape1phi); sin(constshape1phi) cos(constshape1phi)];
        ConstShape1 = [TextConstShape1X NaN ConstShape1X; TextConstShape1Y NaN ConstShape1Y];
        ConstShape1Rotated = ConstShape1R * ConstShape1;
        ConstShape1XRotated = ConstShape1Rotated(1,:);
        ConstShape1YRotated = ConstShape1Rotated(2,:);

        plot(app.UIAxes,ConstShape1XRotated(2:104),ConstShape1YRotated(2:104),'LineWidth',2,'Color',"blue");   % plot constshape1
        grid(app.UIAxes,'on')
        axis(app.UIAxes,'equal')
        axis(app.UIAxes,'padded')

        AddDistl(app.StartmEditField.Value,app.EndmEditField.Value,app.StartheightEditField.Value,1,constshape1exponent,app.pitchkEditField.Value);
       end

   end
     
   methods (Access = private)

       function staticallyindeterminateValueChanged(app)

           if app.EditField.Value == app.EditField_2.Value
                app.Lamp.Color = [0 1 0];
           else
               app.Lamp.Color = [1 0 0];
           end

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