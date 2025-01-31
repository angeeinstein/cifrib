function loadPreferences(app)
    try
        % Load the units structure
            global unitsData Preferences

            try
                load('Preferences.mat', 'Preferences');
                
            catch
                warning('Error loading preferences. Using default values.');
                Preferences.Units.Value = 'metric';
                Preferences.Language.Value = 'English';
            end



            if 1%isfile('unitsData.mat')
                loadedData = load('unitsData.mat', 'unitsData');
                unitsData = loadedData.unitsData; % Store in app property
            else
                error('Units data file not found!');
            end
        
            % Apply the user's selected unit system
            %currentSystem = unitsData.SelectedSystem;
            %ApplyUnits(app, currentSystem);
            switch unitsData.SelectedSystem
                case 'Metric'
                    app.Spinner_BarLength.ValueDisplayFormat = strcat('%11.4g ',unitsData.Metric.Length);
                    app.Spinner_SupportPosition.ValueDisplayFormat = strcat('%11.4g ',unitsData.Metric.Length);
                    app.Spinner_HingePosition.ValueDisplayFormat = strcat('%11.4g ',unitsData.Metric.Length);
                    app.Spinner_PointLoadsPosition.ValueDisplayFormat = strcat('%11.4g ',unitsData.Metric.Length);
                    app.Spinner_DistributedLoadsStartPosition.ValueDisplayFormat = strcat('%11.4g ',unitsData.Metric.Length);
                    app.Spinner_DistributedLoadsEndPosition.ValueDisplayFormat = strcat('%11.4g ',unitsData.Metric.Length);
                case 'Imperial'
                    app.Spinner_BarLength.ValueDisplayFormat = strcat('%11.4g ',unitsData.Imperial.Length);
                    app.Spinner_SupportPosition.ValueDisplayFormat = strcat('%11.4g ',unitsData.Imperial.Length);
                    app.Spinner_HingePosition.ValueDisplayFormat = strcat('%11.4g ',unitsData.Imperial.Length);
                    app.Spinner_PointLoadsPosition.ValueDisplayFormat = strcat('%11.4g ',unitsData.Imperial.Length);
                    app.Spinner_DistributedLoadsStartPosition.ValueDisplayFormat = strcat('%11.4g ',unitsData.Imperial.Length);
                    app.Spinner_DistributedLoadsEndPosition.ValueDisplayFormat = strcat('%11.4g ',unitsData.Imperial.Length);
            end
    catch errormessage
        try
            global userid programVersion
            sendAnalytics(userid,programVersion,'error', errormessage);
        catch
        end
    end
end