clear
clc
% Create a figure
fig = figure;

% Create axes for plotting
ax = axes(fig);

% Define positions and directions of multiple arrows
x = [1, 3, 5, 7];
y = [2, 4, 6, 8];
u = [1, -1, 1, -1];  % X-components of the arrow directions
v = [1, 1, -1, -1];  % Y-components of the arrow directions

% Plot the arrows using quiver
hold on
for j = 1:length(x)
    h(j) = quiver(ax, x(j), y(j), u(1), v(j), 'AutoScale', 'off'); % 'AutoScale' off to maintain original arrow sizes
end

for j = 1:length(x)
    qhandles(j) = h(j);
end


% Store the arrow data (position and direction) in the figure using setappdata
setappdata(fig, 'arrowData', struct('x', x, 'y', y, 'u', u, 'v', v, 'quiverHandle', qhandles));

% Set ButtonDownFcn for the axes to detect mouse clicks
set(ax, 'ButtonDownFcn', @onClick);

% Display information in the command window
disp('Click on an arrow to see the output in the command window...');

% Callback function that will be triggered by mouse clicks
function onClick(~, event)  % The first argument is the axes object (unused, so we use ~)
    % Get the current mouse position in data coordinates
    mousePos = event.IntersectionPoint;
    mouseX = mousePos(1);
    mouseY = mousePos(2);
    
    % Display the mouse click position in the command window
    disp(['Mouse clicked at: (', num2str(mouseX), ', ', num2str(mouseY), ')']);
    
    % Retrieve arrow data from the figure
    arrowData = getappdata(gcf, 'arrowData'); % Get the stored arrow data

    % Loop through all arrows and check if the mouse click is close to any of them
    for i = 1:length(arrowData.x)
        % Calculate the distance between the mouse click and the start point of the arrow
        dist = sqrt((mouseX - arrowData.x(i))^2 + (mouseY - arrowData.y(i))^2);
        
        % Display the distance to the arrow
        disp(['Distance to arrow ', num2str(i), ' starting point: ', num2str(dist)]);
        
        % You can adjust this threshold for how close the mouse click must be
        if dist < 1  % Threshold for selecting an arrow (you can adjust this)
            disp(['Clicked on arrow ', num2str(i), ' at position (', num2str(arrowData.x(i)), ', ', num2str(arrowData.y(i)), ')']);
            
            % Highlight the selected arrow by changing its color (just changing quiver handle's properties)
            for k = 1:length(arrowData.x)
                arrowData.quiverHandle(k).Color = 'blue'; %[0, 0, 1];  % Reset all arrows to blue
            end
            % If you want to change the specific arrow's color, you would need to modify individual arrow handles
            arrowData.quiverHandle(i).Color = 'red'; % Change selected arrow to red
            %arrowData.quiverHandle(i).linewidth = 5; % Change selected arrow linewidth to 5
            return;
        else
            % Highlight the selected arrow by changing its color (just changing quiver handle's properties)
            for k = 1:length(arrowData.x)
                arrowData.quiverHandle(k).Color = 'blue'; %[0, 0, 1];  % Reset all arrows to blue
            end
        end
    end
end
