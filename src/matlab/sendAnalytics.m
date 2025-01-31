function latestVersion = sendAnalytics(userId, programVersion, eventType, additionalData)
    % Flask server URL
    url = 'https://analytics-ingress.schnittgroessen.com/log_event'; % Flask server API

    % Construct event data
    data = struct('user_id', userId, 'program_version', programVersion, 'event', eventType);
    
    if nargin > 3 && ~isempty(additionalData)
        % Add additional fields if provided
        fields = fieldnames(additionalData);
        for i = 1:numel(fields)
            data.(fields{i}) = additionalData.(fields{i});
        end
    end

    % Configure weboptions with Timeout (e.g., 3 seconds)
    try
        options = weboptions('ContentType', 'json', 'Timeout', 3);
        response = webwrite(url, data, options); % Send request
        disp(['Logged event: ', eventType]);
        disp(response);

        % Check if server sent a version update
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




% Example Usage
% sendAnalytics('button_press');
% sendAnalytics('app_start');
% sendAnalytics('calculation');
% sendAnalytics('export_button_press');
% sendAnalytics('save_button_press');
% sendAnalytics('open_button_press');
% sendAnalytics('about_button_press');
% sendAnalytics('help_button_press');
% 
% errorDetails = struct('error_message', 'File not found', 'severity', 'critical');
% sendAnalytics(userid,programVersion,'error', errorDetails);

% try
%     A*B
% catch errorDetails
%     try
%         global userid
%         sendAnalytics(userid,'error', errorDetails);
%     catch
%     end
% end









% function sendAnalytics(eventType, additionalData)
%     % Flask server URL
%     url = 'https://analytics-ingress.schnittgroessen.com/log'; % Replace with your server's URL
% 
%     % Construct event data
%     data = struct('event', eventType);
%     if nargin > 1 && ~isempty(additionalData)
%         % Add additional fields if provided
%         fields = fieldnames(additionalData);
%         for i = 1:numel(fields)
%             data.(fields{i}) = additionalData.(fields{i});
%         end
%     end
% 
%     % Send data to the server
%     try
%         options = weboptions('ContentType', 'json');
%         response = webwrite(url, data, options);
%         disp(['Logged event: ', eventType]);
%         disp(response); % Display server response
%     catch ME
%         disp(['Failed to log event: ', eventType]);
%         disp(ME.message); % Display error message
%     end
% end
% 
% 
% % 
% % % Example usage
% % sendAnalytics('button_press');
% % sendAnalytics('app_start');
% % sendAnalytics('calculation');
% % sendAnalytics('export_button_press');
% % sendAnalytics('save_button_press');
% % sendAnalytics('open_button_press');
% % sendAnalytics('about_button_press');
% % sendAnalytics('help_button_press');
% 
% % errorDetails = struct('error_message', 'File not found', 'severity', 'critical');
% % sendAnalytics('error', errorDetails);