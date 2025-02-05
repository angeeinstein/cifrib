function applyLanguage(app)
    % Load language setting
    lang = getpref('cifrib', 'language');
    
    % Get all language strings
    langStruct = getLanguageStrings();
    
    % Select the appropriate language struct
    if isfield(langStruct, lang)
        selectedLang = langStruct.(lang);
    else
        selectedLang = langStruct.english; % Default to English if undefined
    end

    % Apply text translations
    app.FileMenu.Text = selectedLang.FileMenu;
    app.Menu_New.Text = selectedLang.Menu_New;
    app.OpenMenu.Text = selectedLang.OpenMenu;
    app.SaveMenu.Text = selectedLang.SaveMenu;
    app.SaveAsMenu.Text = selectedLang.SaveAsMenu;
    app.ExportMenu.Text = selectedLang.ExportMenu;
    app.PDFMenu.Text = selectedLang.PDFMenu;
    app.ExitMenu.Text = selectedLang.ExitMenu;
    app.EditMenu.Text = selectedLang.EditMenu;
    app.Menu_Undo.Text = selectedLang.Menu_Undo;
    app.Menu_Redo.Text = selectedLang.Menu_Redo;
    app.PreferencesMenu.Text = selectedLang.PreferencesMenu;
    app.HelpMenu.Text = selectedLang.HelpMenu;
    app.UserManualMenu.Text = selectedLang.UserManualMenu;
    app.AboutMenu.Text = selectedLang.AboutMenu;
    app.AboutMenu_2.Text = selectedLang.AboutMenu_2;
    app.WebsiteMenu.Text = selectedLang.WebsiteMenu;

    % Apply tab titles
    app.Tab_Setup.Title = selectedLang.Tab_Setup;
    app.BarTab.Title = selectedLang.BarTab;
    app.BarprofileTab.Title = selectedLang.BarprofileTab;
    app.SupportsTab.Title = selectedLang.SupportsTab;
    app.HingesTab.Title = selectedLang.HingesTab;
    app.PointloadsTab.Title = selectedLang.PointloadsTab;
    app.DistributedloadsTab.Title = selectedLang.DistributedloadsTab;
    app.Tab_Results.Title = selectedLang.Tab_Results;

    % Apply panel titles
    app.BarSetupPanel.Title = selectedLang.BarSetupPanel;
    app.SupportsPanel.Title = selectedLang.SupportsPanel;
    app.Panel_Loads.Title = selectedLang.Panel_Loads;
    app.BearingReactionsPanel.Title = selectedLang.BearingReactionsPanel;
    app.CalculateForcesataspecificpointPanel.Title = selectedLang.CalculateForcesataspecificpointPanel;
    app.SumofsquarederrorsPanel.Title = selectedLang.SumofsquarederrorsPanel;
    app.AdditionalDetailsPanel.Title = selectedLang.AdditionalDetailsPanel;

    % Apply labels
    app.LengthSpinnerLabel.Text = selectedLang.LengthSpinnerLabel;
    app.MaterialDropDownLabel.Text = selectedLang.MaterialDropDownLabel;
    app.SteelDropDownLabel.Text = selectedLang.SteelDropDownLabel;
    app.PositionSpinnerLabel.Text = selectedLang.PositionSpinnerLabel;
    app.PositionSpinner_2Label.Text = selectedLang.PositionSpinner_2Label;
    app.PositionSpinner_3Label.Text = selectedLang.PositionSpinner_3Label;
    app.ForceSpinnerLabel.Text = selectedLang.ForceSpinnerLabel;
    app.AngleSpinnerLabel.Text = selectedLang.AngleSpinnerLabel;
    app.StartPositionSpinnerLabel.Text = selectedLang.StartPositionSpinnerLabel;
    app.EndPositionSpinnerLabel.Text = selectedLang.EndPositionSpinnerLabel;
    app.StartValueSpinnerLabel.Text = selectedLang.StartValueSpinnerLabel;
    app.PitchSpinnerLabel.Text = selectedLang.PitchSpinnerLabel;
    app.SafetyyieldingEditFieldLabel.Text = selectedLang.SafetyyieldingEditFieldLabel;
    app.SafetyfractureEditFieldLabel.Text = selectedLang.SafetyfractureEditFieldLabel;
    app.PositionEditFieldLabel.Text = selectedLang.PositionEditFieldLabel;
    app.XForceEditFieldLabel.Text = selectedLang.XForceEditFieldLabel;
    app.ZForceEditFieldLabel.Text = selectedLang.ZForceEditFieldLabel;
    app.MomentEditFieldLabel.Text = selectedLang.MomentEditFieldLabel;
    app.ForceNNmEditFieldLabel.Text = selectedLang.ForceNNmEditFieldLabel;
    app.PositionmLabel.Text = selectedLang.PositionmLabel;
    app.AngledegEditFieldLabel.Text = selectedLang.AngledegEditFieldLabel;

    % Apply button text
    app.Button_BarAdd.Text = selectedLang.Button_BarAdd;
    app.Button_BarprofileRektangle.Text = selectedLang.Button_BarprofileRektangle;
    app.Button_BarprofileSquarehollow.Text = selectedLang.Button_BarprofileSquarehollow;
    app.Button_BarprofileRound.Text = selectedLang.Button_BarprofileRound;
    app.Button_BarprofileH.Text = selectedLang.Button_BarprofileH;
    app.Button_SupportAdd.Text = selectedLang.Button_SupportAdd;
    app.Button_HingeAdd.Text = selectedLang.Button_HingeAdd;
    app.Button_PointloadsAdd.Text = selectedLang.Button_PointloadsAdd;
    app.Button_PointLoadsForce.Text = selectedLang.Button_PointLoadsForce;
    app.Button_PointloadsMoment.Text = selectedLang.Button_PointloadsMoment;
    app.Button_DistributedLoadsAdd.Text = selectedLang.Button_DistributedLoadsAdd;
    app.Button_DistributedLoadsConstant.Text = selectedLang.Button_DistributedLoadsConstant;
    app.Button_DistributedLoadsLinear.Text = selectedLang.Button_DistributedLoadsLinear;
    app.Button_DistributedLoadsQuadratic.Text = selectedLang.Button_DistributedLoadsQuadratic;
    app.Button_SetupCalculate.Text = selectedLang.Button_SetupCalculate;

    % Apply UIAxes titles
    title(app.UIAxes_Setup, selectedLang.UIAxes_Setup);
    title(app.UIAxes_ResultsNormalForce, selectedLang.UIAxes_ResultsNormalForce);
    title(app.UIAxes_ResultsShearForce, selectedLang.UIAxes_ResultsShearForce);
    title(app.UIAxes_ResultsMoment, selectedLang.UIAxes_ResultsMoment);

    % Apply tooltips
    app.Spinner_PointLoadsAngle.Tooltip = {selectedLang.Spinner_PointLoadsAngle_Tooltip};
    app.Spinner_PointLoadsForce.Tooltip = {selectedLang.Spinner_PointLoadsForce_Tooltip};
    app.Spinner_DistributedLoadsPitch.Tooltip = {selectedLang.Spinner_DistributedLoadsPitch_Tooltip};
    app.Spinner_DistributedLoadsStartValue.Tooltip = {selectedLang.Spinner_DistributedLoadsStartValue_Tooltip};
    app.Button_HingeShearforce.Tooltip = {selectedLang.Button_HingeShearforce_Tooltip};
    app.Button_HingeNormalforce.Tooltip = {selectedLang.Button_HingeNormalforce_Tooltip};

    % Apply placeholders (if applicable)
    app.Spinner_BarprofileA.Placeholder = selectedLang.Spinner_BarprofileA_Placeholder;
    app.Spinner_BarprofileB.Placeholder = selectedLang.Spinner_BarprofileB_Placeholder;

    % Apply UI Labels/Headings for dynamically generated text
    title(app.UIAxes_Setup, selectedLang.UIAxes_Setup);
    xlabel(app.UIAxes_Setup, selectedLang.UIAxes_Setup_XLabel);
    ylabel(app.UIAxes_Setup, selectedLang.UIAxes_Setup_YLabel);

    title(app.UIAxes_ResultsNormalForce, selectedLang.UIAxes_ResultsNormalForce);
    xlabel(app.UIAxes_ResultsNormalForce, selectedLang.UIAxes_ResultsNormalForce_XLabel);
    ylabel(app.UIAxes_ResultsNormalForce, selectedLang.UIAxes_ResultsNormalForce_YLabel);

    title(app.UIAxes_ResultsShearForce, selectedLang.UIAxes_ResultsShearForce);
    xlabel(app.UIAxes_ResultsShearForce, selectedLang.UIAxes_ResultsShearForce_XLabel);
    ylabel(app.UIAxes_ResultsShearForce, selectedLang.UIAxes_ResultsShearForce_YLabel);

    title(app.UIAxes_ResultsMoment, selectedLang.UIAxes_ResultsMoment);
    xlabel(app.UIAxes_ResultsMoment, selectedLang.UIAxes_ResultsMoment_XLabel);
    ylabel(app.UIAxes_ResultsMoment, selectedLang.UIAxes_ResultsMoment_YLabel);

end
