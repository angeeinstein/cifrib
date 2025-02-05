function applyLanguagePreferences(app)

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

    % Update UI Panel Titles
    app.PreferencesPanel.Title = selectedLang.PreferencesPanel;
    app.GeneralTab.Title = selectedLang.GeneralTab;

    % Update Labels
    app.UnitsDropDownLabel.Text = selectedLang.UnitsDropDownLabel;
    app.LanguageDropDownLabel.Text = selectedLang.LanguageDropDownLabel;
    app.Checkbox_InitialSetup.Text = selectedLang.Checkbox_InitialSetup;

    % Update Button Text
    app.SaveButton.Text = selectedLang.SaveButton;

    % Update Dropdown Items
    %app.DropDown_Units.Items = {selectedLang.Units_Metric, selectedLang.Units_Imperial};
    %app.DropDown_Language.Items = {selectedLang.Language_English, selectedLang.Language_German};
end
