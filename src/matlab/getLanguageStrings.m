function langStruct = getLanguageStrings()
    % English Language Strings
    langStruct.english.FileMenu = 'File';
    langStruct.english.Menu_New = 'New...';
    langStruct.english.OpenMenu = 'Open...';
    langStruct.english.SaveMenu = 'Save';
    langStruct.english.SaveAsMenu = 'Save As...';
    langStruct.english.ExportMenu = 'Export';
    langStruct.english.PDFMenu = 'PDF';
    langStruct.english.ExitMenu = 'Exit';
    langStruct.english.EditMenu = 'Edit';
    langStruct.english.Menu_Undo = 'Undo';
    langStruct.english.Menu_Redo = 'Redo';
    langStruct.english.PreferencesMenu = 'Preferences';
    langStruct.english.HelpMenu = 'Help';
    langStruct.english.UserManualMenu = 'User Manual';
    langStruct.english.AboutMenu = 'About';
    langStruct.english.AboutMenu_2 = 'About';
    langStruct.english.WebsiteMenu = 'Website';

    % Tabs
    langStruct.english.Tab_Setup = 'Setup';
    langStruct.english.BarTab = 'Bar';
    langStruct.english.BarprofileTab = 'Bar profile';
    langStruct.english.SupportsTab = 'Supports';
    langStruct.english.HingesTab = 'Hinges';
    langStruct.english.PointloadsTab = 'Point loads';
    langStruct.english.DistributedloadsTab = 'Distributed loads';
    langStruct.english.Tab_Results = 'Results';

    % Panels
    langStruct.english.BarSetupPanel = 'Bar Setup';
    langStruct.english.SupportsPanel = 'Supports';
    langStruct.english.Panel_Loads = 'Loads';
    langStruct.english.BearingReactionsPanel = 'Bearing Reactions';
    langStruct.english.CalculateForcesataspecificpointPanel = 'Calculate Forces at a specific point';
    langStruct.english.SumofsquarederrorsPanel = 'Sum of squared errors';
    langStruct.english.AdditionalDetailsPanel = 'Additional Details';

    % Labels
    langStruct.english.LengthSpinnerLabel = 'Length';
    langStruct.english.MaterialDropDownLabel = 'Material';
    langStruct.english.SteelDropDownLabel = 'Steel';
    langStruct.english.PositionSpinnerLabel = 'Position';
    langStruct.english.PositionSpinner_2Label = 'Position';
    langStruct.english.PositionSpinner_3Label = 'Position';
    langStruct.english.ForceSpinnerLabel = 'Force';
    langStruct.english.AngleSpinnerLabel = 'Angle';
    langStruct.english.StartPositionSpinnerLabel = 'Start Position';
    langStruct.english.EndPositionSpinnerLabel = 'End Position';
    langStruct.english.StartValueSpinnerLabel = 'Start Value';
    langStruct.english.PitchSpinnerLabel = 'Pitch';
    langStruct.english.SafetyyieldingEditFieldLabel = 'Safety yielding';
    langStruct.english.SafetyfractureEditFieldLabel = 'Safety fracture';
    langStruct.english.PositionEditFieldLabel = 'Position';
    langStruct.english.XForceEditFieldLabel = 'X-Force';
    langStruct.english.ZForceEditFieldLabel = 'Z-Force';
    langStruct.english.MomentEditFieldLabel = 'Moment';
    langStruct.english.ForceNNmEditFieldLabel = '[Force] N N/m';
    langStruct.english.PositionmLabel = '[Position] m';
    langStruct.english.AngledegEditFieldLabel = '[Angle] deg';

    % Buttons
    langStruct.english.Button_BarAdd = 'Add';
    langStruct.english.Button_SupportAdd = 'Add';
    langStruct.english.Button_HingeAdd = 'Add';
    langStruct.english.Button_PointloadsAdd = 'Add';
    langStruct.english.Button_DistributedLoadsAdd = 'Add';
    langStruct.english.Button_SetupCalculate = 'Calculate!';
    langStruct.english.Button_BarprofileRektangle = '';
    langStruct.english.Button_BarprofileSquarehollow = '';
    langStruct.english.Button_BarprofileRound = '';
    langStruct.english.Button_BarprofileH = '';
    langStruct.english.Button_PointLoadsForce = '';
    langStruct.english.Button_PointloadsMoment = '';
    langStruct.english.Button_DistributedLoadsConstant = '';
    langStruct.english.Button_DistributedLoadsLinear = '';
    langStruct.english.Button_DistributedLoadsQuadratic = '';

    % Tooltips
    langStruct.english.Spinner_PointLoadsAngle_Tooltip = '0° = leftward, 90° = upward';
    langStruct.english.Spinner_PointLoadsForce_Tooltip = 'Enter force value in Newton (N)';
    langStruct.english.Spinner_DistributedLoadsPitch_Tooltip = 'Defines the pitch for the distributed load';
    langStruct.english.Spinner_DistributedLoadsStartValue_Tooltip = 'Starting value of the distributed load in N/m';
    langStruct.english.Button_HingeShearforce_Tooltip = 'Coming soon';
    langStruct.english.Button_HingeNormalforce_Tooltip = 'Coming soon';

    % UI Axis Labels
    langStruct.english.UIAxes_Setup = 'Setup';
    langStruct.english.UIAxes_ResultsNormalForce = 'Normal-Force';
    langStruct.english.UIAxes_ResultsShearForce = 'Shear-Force';
    langStruct.english.UIAxes_ResultsMoment = 'Moment';
    langStruct.english.UIAxes_Setup_XLabel = 'X';
    langStruct.english.UIAxes_Setup_YLabel = 'Z';
    langStruct.english.UIAxes_ResultsNormalForce_XLabel = 'X';
    langStruct.english.UIAxes_ResultsNormalForce_YLabel = 'Z';
    langStruct.english.UIAxes_ResultsShearForce_XLabel = 'X';
    langStruct.english.UIAxes_ResultsShearForce_YLabel = 'Z';
    langStruct.english.UIAxes_ResultsMoment_XLabel = 'X';
    langStruct.english.UIAxes_ResultsMoment_YLabel = 'Z';

    % Placeholders
    langStruct.english.Spinner_BarprofileA_Placeholder = 'A';
    langStruct.english.Spinner_BarprofileB_Placeholder = 'B';

    % Preferences Window
    langStruct.english.PreferencesPanel = 'Preferences';
    langStruct.english.GeneralTab = 'General';
    langStruct.english.UnitsDropDownLabel = 'Units';
    langStruct.english.LanguageDropDownLabel = 'Language';
    langStruct.english.Checkbox_InitialSetup = 'Hide initial setup at start';
    langStruct.english.SaveButton = 'Save';
    %langStruct.english.Units_Metric = 'Metric';
    %langStruct.english.Units_Imperial = 'Imperial';
    %langStruct.english.Language_English = 'English';
    %langStruct.english.Language_German = 'Deutsch';

    % Help
    langStruct.english.HelpPanel = 'User Manual';
    langStruct.english.TextArea = { ...
        'Step 1: Add the Bar', ...
        'Input the bar length in the "Length" field under the Bar Setup panel.', ...
        'Click "Add" to implement the bar in the workspace.', '', ...
        'Step 2: Define Supports', ...
        'Select the type of support (e.g., clamped, roller, or hinge) from the Support panel.', ...
        'For hinges, navigate to the "Hinge" tab within the panel.', ...
        'Specify the position for the support or hinge and click "Add" to place it.', ...
        'You can also add a moment hinge here,', ...
        'although at present it may introduce some minor numerical inaccuracies in the results;', ...
        'these results are still qualitatively valid.', '', ...
        'Step 3: Add Forces and Moments', ...
        'Navigate to the "Add Loads" panel.', ...
        'For forces, specify the magnitude, angle, and position.', ...
        'For moments, specify the magnitude and position.', ...
        'Click "Add" to implement the load.', '', ...
        'Step 4: Add Distributed Line Loads', ...
        'Navigate to the "Distributed Loads" tab.', ...
        'Select the type of line load: linear or quadratic.', ...
        'Define the start and end positions, start value (height), and pitch', ...
        '(positive for an increasing load, negative for a decreasing load).', ...
        'Click "Add" to implement the load.', ...
        'For constant loads, use the dedicated "Constant Load" button.', '', ...
        'Step 5: Modify or Adjust Inputs', ...
        'Use the Undo and Redo buttons in the top menu', ...
        'to revert or restore actions.', ...
        '(Coming soon: Click on graphical elements—e.g., force arrows—to', ...
        'view and edit their properties in the bottom panel.)', '', ...
        'Step 6: Verify and Calculate', ...
        'Check the status indicator (lamp).', ...
        'Green indicates the structure is statically determinate and calculations can proceed.', ...
        'Once verified, click "Calculate" to compute and display the results graphically.', '', ...
        'Additional Features', '', ...
        'Material and Profile Selection:', ...
        'Under "Material", you can choose a material, and under "Bar Profile",', ...
        'you can define the cross-section. These selections are used to compute', ...
        'the safety against yielding and fracture, which is also displayed in the output window.', '', ...
        'Future Updates:', ...
        'Interactive editing by clicking elements in the workspace', ...
        'will be available soon.' ...
    };


    %%%%%%
    % German Language Strings
    langStruct.german.FileMenu = 'Datei';
    langStruct.german.Menu_New = 'Neu...';
    langStruct.german.OpenMenu = 'Öffnen...';
    langStruct.german.SaveMenu = 'Speichern';
    langStruct.german.SaveAsMenu = 'Speichern unter...';
    langStruct.german.ExportMenu = 'Exportieren';
    langStruct.german.PDFMenu = 'PDF';
    langStruct.german.ExitMenu = 'Beenden';
    langStruct.german.EditMenu = 'Bearbeiten';
    langStruct.german.Menu_Undo = 'Rückgängig';
    langStruct.german.Menu_Redo = 'Wiederholen';
    langStruct.german.PreferencesMenu = 'Einstellungen';
    langStruct.german.HelpMenu = 'Hilfe';
    langStruct.german.UserManualMenu = 'Benutzerhandbuch';
    langStruct.german.AboutMenu = 'Über';
    langStruct.german.AboutMenu_2 = 'Über';
    langStruct.german.WebsiteMenu = 'Website';

    % Tabs
    langStruct.german.Tab_Setup = 'Einrichtung';
    langStruct.german.BarTab = 'Balken';
    langStruct.german.BarprofileTab = 'Balkenprofil';
    langStruct.german.SupportsTab = 'Lager';
    langStruct.german.HingesTab = 'Gelenke';
    langStruct.german.PointloadsTab = 'Punktlasten';
    langStruct.german.DistributedloadsTab = 'Verteilte Lasten';
    langStruct.german.Tab_Results = 'Ergebnisse';

    % Panels
    langStruct.german.BarSetupPanel = 'Balkeneinstellungen';
    langStruct.german.SupportsPanel = 'Lager';
    langStruct.german.Panel_Loads = 'Lasten';
    langStruct.german.BearingReactionsPanel = 'Lagerreaktionen';
    langStruct.german.CalculateForcesataspecificpointPanel = 'Kräfte an einem bestimmten Punkt berechnen';
    langStruct.german.SumofsquarederrorsPanel = 'Fehlerquadratsumme';
    langStruct.german.AdditionalDetailsPanel = 'Zusätzliche Details';

    % Labels
    langStruct.german.LengthSpinnerLabel = 'Länge';
    langStruct.german.MaterialDropDownLabel = 'Material';
    langStruct.german.SteelDropDownLabel = 'Stahl';
    langStruct.german.PositionSpinnerLabel = 'Position';
    langStruct.german.PositionSpinner_2Label = 'Position';
    langStruct.german.PositionSpinner_3Label = 'Position';
    langStruct.german.ForceSpinnerLabel = 'Kraft';
    langStruct.german.AngleSpinnerLabel = 'Winkel';
    langStruct.german.StartPositionSpinnerLabel = 'Startposition';
    langStruct.german.EndPositionSpinnerLabel = 'Endposition';
    langStruct.german.StartValueSpinnerLabel = 'Startwert';
    langStruct.german.PitchSpinnerLabel = 'Steigung';
    langStruct.german.SafetyyieldingEditFieldLabel = 'Sicherheit Streckgrenze';
    langStruct.german.SafetyfractureEditFieldLabel = 'Sicherheit Bruchgrenze';
    langStruct.german.PositionEditFieldLabel = 'Position';
    langStruct.german.XForceEditFieldLabel = 'X-Kraft';
    langStruct.german.ZForceEditFieldLabel = 'Z-Kraft';
    langStruct.german.MomentEditFieldLabel = 'Moment';
    langStruct.german.ForceNNmEditFieldLabel = '[Kraft] N N/m';
    langStruct.german.PositionmLabel = '[Position] m';
    langStruct.german.AngledegEditFieldLabel = '[Winkel] Grad';

    % Buttons
    langStruct.german.Button_BarAdd = 'Hinzufügen';
    langStruct.german.Button_SupportAdd = 'Hinzufügen';
    langStruct.german.Button_HingeAdd = 'Hinzufügen';
    langStruct.german.Button_PointloadsAdd = 'Hinzufügen';
    langStruct.german.Button_DistributedLoadsAdd = 'Hinzufügen';
    langStruct.german.Button_SetupCalculate = 'Berechnen!';
    langStruct.german.Button_BarprofileRektangle = '';
    langStruct.german.Button_BarprofileSquarehollow = '';
    langStruct.german.Button_BarprofileRound = '';
    langStruct.german.Button_BarprofileH = '';
    langStruct.german.Button_PointLoadsForce = '';
    langStruct.german.Button_PointloadsMoment = '';
    langStruct.german.Button_DistributedLoadsConstant = '';
    langStruct.german.Button_DistributedLoadsLinear = '';
    langStruct.german.Button_DistributedLoadsQuadratic = '';

    % Tooltips
    langStruct.german.Spinner_PointLoadsAngle_Tooltip = '0° = links, 90° = nach oben';
    langStruct.german.Spinner_PointLoadsForce_Tooltip = 'Kraftwert in Newton (N) eingeben';
    langStruct.german.Spinner_DistributedLoadsPitch_Tooltip = 'Definiert die Steigung für die verteilte Last';
    langStruct.german.Spinner_DistributedLoadsStartValue_Tooltip = 'Startwert der verteilten Last in N/m';
    langStruct.german.Button_HingeShearforce_Tooltip = 'Kommt bald';
    langStruct.german.Button_HingeNormalforce_Tooltip = 'Kommt bald';

    % UI Axis Labels
    langStruct.german.UIAxes_Setup = 'Einrichtung';
    langStruct.german.UIAxes_ResultsNormalForce = 'Normalkraft';
    langStruct.german.UIAxes_ResultsShearForce = 'Querkraft';
    langStruct.german.UIAxes_ResultsMoment = 'Moment';
    langStruct.german.UIAxes_Setup_XLabel = 'X';
    langStruct.german.UIAxes_Setup_YLabel = 'Z';
    langStruct.german.UIAxes_ResultsNormalForce_XLabel = 'X';
    langStruct.german.UIAxes_ResultsNormalForce_YLabel = 'Z';
    langStruct.german.UIAxes_ResultsShearForce_XLabel = 'X';
    langStruct.german.UIAxes_ResultsShearForce_YLabel = 'Z';
    langStruct.german.UIAxes_ResultsMoment_XLabel = 'X';
    langStruct.german.UIAxes_ResultsMoment_YLabel = 'Z';

    % Placeholders
    langStruct.german.Spinner_BarprofileA_Placeholder = 'A';
    langStruct.german.Spinner_BarprofileB_Placeholder = 'B';

    % Preferences Window
    langStruct.german.PreferencesPanel = 'Einstellungen';
    langStruct.german.GeneralTab = 'Allgemein';
    langStruct.german.UnitsDropDownLabel = 'Einheiten';
    langStruct.german.LanguageDropDownLabel = 'Sprache';
    langStruct.german.Checkbox_InitialSetup = 'Initiale Einrichtung beim Start ausblenden';
    langStruct.german.SaveButton = 'Speichern';
    %langStruct.german.Units_Metric = 'Metrisch';
    %langStruct.german.Units_Imperial = 'Imperial';
    %langStruct.german.Language_English = 'English';
    %langStruct.german.Language_German = 'Deutsch';

    % Help
    langStruct.german.HelpPanel = 'Benutzerhandbuch';
    langStruct.german.TextArea = { ...
        'Schritt 1: Balken hinzufügen', ...
        'Geben Sie die Balkenlänge im Feld "Länge" unter dem Balkeneinstellungs-Panel ein.', ...
        'Klicken Sie auf "Hinzufügen", um den Balken in den Arbeitsbereich einzufügen.', '', ...
        'Schritt 2: Lager definieren', ...
        'Wählen Sie die Art des Lagers (z. B. fest, Rollenlager oder Gelenk) im Lager-Panel.', ...
        'Für Gelenke navigieren Sie zum "Gelenk"-Tab im Panel.', ...
        'Geben Sie die Position des Lagers oder Gelenks an und klicken Sie auf "Hinzufügen",', ...
        'um es zu platzieren. Sie können hier auch ein Momentgelenk hinzufügen,', ...
        'was jedoch momentan zu kleinen numerischen Ungenauigkeiten in den Ergebnissen führen kann;', ...
        'die Ergebnisse sind dennoch qualitativ gültig.', '', ...
        'Schritt 3: Kräfte und Momente hinzufügen', ...
        'Navigieren Sie zum Panel "Lasten hinzufügen".', ...
        'Für Kräfte geben Sie die Größe, den Winkel und die Position an.', ...
        'Für Momente geben Sie die Größe und die Position an.', ...
        'Klicken Sie auf "Hinzufügen", um die Last zu implementieren.', '', ...
        'Schritt 4: Verteilte Linienlasten hinzufügen', ...
        'Navigieren Sie zum Tab "Verteilte Lasten".', ...
        'Wählen Sie den Lasttyp: linear oder quadratisch.', ...
        'Definieren Sie die Start- und Endpositionen, den Startwert (Höhe) und die Steigung', ...
        '(positiv für eine zunehmende Last, negativ für eine abnehmende Last).', ...
        'Klicken Sie auf "Hinzufügen", um die Last zu implementieren.', ...
        'Für konstante Lasten verwenden Sie die spezielle Schaltfläche "Konstante Last".', '', ...
        'Schritt 5: Eingaben ändern oder anpassen', ...
        'Verwenden Sie die "Rückgängig" und "Wiederholen"-Schaltflächen im oberen Menü,', ...
        'um Aktionen rückgängig zu machen oder wiederherzustellen.', ...
        '(Bald verfügbar: Klicken Sie auf grafische Elemente – z. B. Kraftpfeile –,', ...
        'um deren Eigenschaften im unteren Panel anzuzeigen und zu bearbeiten.)', '', ...
        'Schritt 6: Überprüfen und Berechnen', ...
        'Überprüfen Sie die Statusanzeige (Lampe).', ...
        'Grün bedeutet, dass die Struktur statisch bestimmt ist und die Berechnungen durchgeführt werden können.', ...
        'Sobald dies bestätigt ist, klicken Sie auf "Berechnen",', ...
        'um die Ergebnisse grafisch zu berechnen und anzuzeigen.', '', ...
        'Zusätzliche Funktionen', '', ...
        'Material- und Profilwahl:', ...
        'Unter "Material" können Sie ein Material auswählen, und unter "Balkenprofil"', ...
        'können Sie den Querschnitt definieren. Diese Auswahl wird verwendet,', ...
        'um die Sicherheit gegen Fließen und Bruch zu berechnen,', ...
        'die ebenfalls im Ausgabefenster angezeigt wird.', '', ...
        'Zukünftige Updates:', ...
        'Interaktive Bearbeitung durch Klicken auf Elemente im Arbeitsbereich', ...
        'wird bald verfügbar sein.' ...
    };


end
