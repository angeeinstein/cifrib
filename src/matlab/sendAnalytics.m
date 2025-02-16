function latestVersion = sendAnalytics(sessionId, deviceId, programVersion, eventType, additionalData)
    % Flask server URL
    url = 'https://analytics-ingress.schnittgroessen.com/log_event'; % Flask server API

    % Construct event data
    data = struct('session_id', sessionId, 'device_id', deviceId, 'program_version', programVersion, 'event', eventType);
    
    if nargin > 4 && ~isempty(additionalData)
        % Add additional fields if provided
        fields = fieldnames(additionalData);
        for i = 1:numel(fields)
            data.(fields{i}) = additionalData.(fields{i});
        end
    end

    % Define the API key
    apiKey = 'we-all-love-andracher';
    
    % Configure weboptions with Timeout (e.g., 3 seconds) and the API key header
    try
        options = weboptions('ContentType', 'json', 'Timeout', 3, ...
                             'HeaderFields', {'X-API-KEY', apiKey});
        response = webwrite(url, data, options); % Send request
        disp(['Logged event: ', eventType]);
        disp(response);

        % Check if the server sent a version update
        if isfield(response, 'latest_version')
            latestVersion = response.latest_version;
        else
            latestVersion = programVersion; % If no version info, assume same version
        end
    catch
        disp(['Failed to log event: ', eventType]);
        latestVersion = programVersion; % Default to current version if request fails
    end
end

% Example Usage:
% sendAnalytics('session123', 'device456', '1.0.', 'app_start');
% sendAnalytics('session123', 'device456', '1.0.', 'button_press');
% 
% errorDetails = struct('error_message', 'File not found', 'severity', 'critical');
% sendAnalytics('session123', 'device456', '1.0.', 'error', errorDetails);
