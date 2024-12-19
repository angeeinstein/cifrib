% Create a figure and plot
fig = figure;
ax = axes(fig); % Create axes
x = rand(10,1); % X data
y = rand(10,1); % Y data
scatter(ax, x, y);

% Set ButtonDownFcn for the axes (or scatter object)
set(ax, 'ButtonDownFcn', @scatterClickCallback);

% Callback function to handle mouse clicks on the axes
function scatterClickCallback(src, event)
    % Get the current mouse position in data coordinates
    point = event.IntersectionPoint;
    
    % Display or modify the data based on the click
    disp(['You clicked at: X = ', num2str(point(1)), ', Y = ', num2str(point(2))]);
    
    % Optionally, you could add code to update the plot
    hold on;
    plot(point(1), point(2), 'ro'); % Add a red 'o' where the click occurred
end
