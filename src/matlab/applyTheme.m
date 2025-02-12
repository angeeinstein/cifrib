function applyTheme(app)
    %APPLYTHEME Summary of this function goes here
    %   Detailed explanation goes here
    
    % Load theme setting
    theme = getpref('cifrib', 'theme');
    
    % Get all color strings
    themeStruct = getColors();
    
    % Select the appropriate theme struct
    if isfield(themeStruct, theme)
        selectedTheme = themeStruct.(theme);
    else
        selectedTheme = themeStruct.light; % Default to light if undefined
    end

    % Apply colors
    % app.CIFRIBUIFigure.Color = selectedTheme.Background;
    % app.UIAxes_Setup.Color = selectedTheme.Background;
    % app.Panel_6.BackgroundColor = selectedTheme.Background;
    % app.CIFRIBUIFigure.Color = selectedTheme.Background;
    % app.CIFRIBUIFigure.Color = selectedTheme.Background;
    % app.CIFRIBUIFigure.Color = selectedTheme.Background;
end