function applyLanguageHelp(app)

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
    app.HelpPanel.Title = selectedLang.HelpPanel;
    app.TextArea.Value = selectedLang.TextArea;
    
end
