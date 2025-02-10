function loadProject(app, project)
    try
        global main
        loadedData = load(project); % Load the data into a structure
        if isfield(loadedData, 'main') % Check if 'main' exists in the loaded data
            main = loadedData.main; % Assign the content of 'main' to the global variable
            uialert(app.CIFRIBUIFigure, "Project successfully loaded".', ...
                'Loaded', 'Icon', 'success');
        else 
            uialert(app.UIFigure, 'The file does not contain the expected structure "main".', ...
                'Load Error', 'Icon', 'error');
            return;
        end
        PlotAll(app);
        try
            app.Spinner_BarLength.Value = main.BarLgh;
        catch
        end
    
    catch errormessage
         uialert(app.CIFRIBUIFigure, ...
         errormessage.message, ...
         'Error', ...
         'Icon', 'error');
         try
            global userid programVersion
            sendAnalytics(userid,programVersion,'error', errormessage);
         catch
         end
    end
end