function sendAnalytics(eventType, additionalData)
    % Flask server URL
    url = 'https://analytics-ingress.schnittgroessen.com/log_event'; % Use Flask server's local IP

    % Construct event data
    data = struct('event', eventType);
    if nargin > 1 && ~isempty(additionalData)
        % Add additional fields if provided
        fields = fieldnames(additionalData);
        for i = 1:numel(fields)
            data.(fields{i}) = additionalData.(fields{i});
        end
    end

    % Send data to Flask
    try
        options = weboptions('ContentType', 'json');
        response = webwrite(url, data, options);
        disp(['Logged event: ', eventType]);
        disp(response); % Display server response
    catch ME
        disp(['Failed to log event: ', eventType]);
        disp(ME.message); % Display error message
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
% sendAnalytics('error', errorDetails);







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