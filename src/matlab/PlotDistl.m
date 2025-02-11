function PlotDistl(app)
    % PlotDistl: Plots distributed loads on the bar using parameters stored in
    % the global "main" structure.
    %
    % The function computes the load shape based on an exponent value.
    % If exponent == 0, the load is constant; otherwise, it is variable.
    
    global main;
    nLoads = numel(main.Distl.StartPos);
    
    hold(app.UIAxes_Setup, 'on');
    
    for i = 1:nLoads
        % Extract parameters for this load
        exponent    = main.Distl.Exponent(i);
        startPos    = main.Distl.StartPos(i);
        endPos      = main.Distl.EndPos(i);
        pitch       = main.Distl.Pitch(i);
        startValue  = main.Distl.StartValue(i);
        
        % Determine the direction and constant load sign.
        direction   = sign(pitch);       % 1 or -1 from pitch
        heightSign  = sign(startValue);    % use sign if you only care about the direction
        
        % Define a scaling factor (relative to the overall bar length)
        distlScale = main.BarLgh / 4;
        
        % Compute the distributed load shape (x- and y-coordinates)
        numPoints = 10;
        [xCoords, yCoords] = computeLoadShape(exponent, startPos, endPos, direction, heightSign, numPoints);
        
        % Optionally adjust scale if the constant load is zero
        if (exponent == 0) && (heightSign == 0)
            distlScale = 0;
        end
        
        % Scale the y-coordinates based on the distributed load span relative to the bar length
        scaledY = yCoords * distlScale * ((endPos - startPos) / main.BarLgh);
        
        % Plot the load shape
        plot(app.UIAxes_Setup, xCoords, scaledY, 'LineWidth', 2, 'Color', 'blue');
        
        % Prepare text annotation near the end of the load
        textX = endPos + 0.5;
        textY = scaledY(end) + 0.5;
        annotationStr = sprintf('q = (%g)+(%g*x^{%g}) N/m', startValue, pitch, exponent);
        text(app.UIAxes_Setup, textX, textY, annotationStr, 'FontSize', 15, 'Color', 'blue');
    end
    
    grid(app.UIAxes_Setup, 'on');
    axis(app.UIAxes_Setup, 'equal');
    axis(app.UIAxes_Setup, 'padded');
end

function [xCoords, yCoords] = computeLoadShape(exponent, startPos, endPos, direction, heightSign, numPoints)
    % computeLoadShape: Computes the x- and y-coordinates for a distributed load.
    %
    % For a constant load (exponent == 0) the y-values are constant.
    % Otherwise, y-values are computed based on the exponent and normalized.
    
    % Generate x-coordinates
    xBetween = linspace(startPos, endPos, numPoints);
    xCoords = [startPos, xBetween, endPos];
    
    if exponent == 0
        % Constant load: y-values remain at the given sign value.
        yCoords = [0, heightSign * ones(1, numPoints), 0];
    else
        % Varying load: compute y-values based on the exponent.
        yBetween = (xBetween - startPos) .^ exponent;
        normFactor = max(yBetween);
        if normFactor == 0
            normFactor = 1;  % Prevent division by zero
        end
        yCoords = [0, (direction * (yBetween ./ normFactor) + heightSign), 0];
    end
end

% function PlotDistl(app)
%     global main;
%     j = length(main.Distl.StartPos);
%     for i = 1:j
%         distlexponent = main.Distl.Exponent(i);
%         distl_startpos = main.Distl.StartPos(i);    % start position of distributed load
%         distl_endpos   = main.Distl.EndPos(i);        % end position of distributed load
%         distldirection = sign(main.Distl.Pitch(i));    % pitch direction (1 or -1)
%         % Use the actual start value if you want the magnitude,
%         % or sign(main.Distl.StartValue(i)) if you only care about the direction.
%         distl_startheight = sign(main.Distl.StartValue(i)); 
% 
%         % Define a scale factor (you already had this)
%         distlscale = main.BarLgh/4; 
% 
%         % Create x-coordinates between the start and end positions
%         DistlXBetween = linspace(distl_startpos, distl_endpos, 10);
%         DistlX = [distl_startpos, DistlXBetween, distl_endpos];
% 
%         if distlexponent == 0
%             % For a constant load, just make the y-values constant.
%             % (We put a 0 at the beginning and end to “anchor” the shape.)
%             DistlY = [0, distl_startheight * ones(1, numel(DistlXBetween)), 0];
%         else
%             % For a varying load, calculate the y-values normally.
%             DistlYBetween = ((DistlXBetween - distl_startpos).^distlexponent);
%             % It is better to use max(DistlYBetween) rather than a hard-coded index:
%             DistlY = [0, (distldirection * (DistlYBetween ./ max(DistlYBetween)) + distl_startheight), 0];
%         end
% 
%         % (Optional) Adjust the scale if needed. The following block was in your code:
%         if (distlexponent == 0) && (distl_startheight == 0)
%             distlscale = 0;
%         %elseif (distlexponent == 0) && (distl_startheight == -1)
%             %distlscale = distlscale * (-1);
%         end
% 
%         % Prepare for plotting
%         TextDistlX = distl_endpos + 0.5;
%         % Make sure you index correctly (here we assume the last element of DistlY is used)
%         TextDistlY = DistlY(end) + 0.5;
% 
%         % (If you have a rotation, include it here. Otherwise, it’s just an identity.)
%         DistlRotated = [DistlX; DistlY]; 
%         DistlXRotated = DistlRotated(1,:);
%         % Adjust Y-values using the scale factor.
%         DistlYRotated = DistlRotated(2,:) * distlscale * ((distl_endpos - distl_startpos) / main.BarLgh);
% 
%         hold(app.UIAxes_Setup, "on")
%         % Plot using all the points (adjust the indices if needed)
%         plot(app.UIAxes_Setup, DistlXRotated, DistlYRotated, 'LineWidth', 2, 'Color', "blue");
%         text(app.UIAxes_Setup, TextDistlX, TextDistlY, ...
%             strcat("q = (", num2str(main.Distl.StartValue(i)), ")+(", num2str(main.Distl.Pitch(i)), ...
%             "*x^{", num2str(distlexponent), "}) N/m"), 'FontSize', 15, 'Color', "blue");
% 
%         grid(app.UIAxes_Setup, 'on')
%         axis(app.UIAxes_Setup, 'equal')
%         axis(app.UIAxes_Setup, 'padded')
%     end
% end
% 
% % function PlotDistl(app)
% % global main;
% %     j = length(main.Distl.StartPos);
% %     for i=1:j
% %         distlexponent = main.Distl.Exponent(i);
% %         distl_startpos = main.Distl.StartPos(i);    % start position of distl
% %         distl_endpos = main.Distl.EndPos(i);   % end position of distl
% %         distldirection = sign(main.Distl.Pitch(i));   % 1 or -1 sign(x)
% %         distl_startheight = sign(main.Distl.StartValue(i));
% % 
% %         % Distributed Load
% %         % define distl
% %         distlscale = (main.BarLgh/4); %(1 / bar1length * (distl_endpos - distl_startpos));    % size of the shape = 1/10 of bar length 
% %         if (distlexponent == 0) && (distl_startheight == 0)
% %             distlscale = 0;
% %         elseif (distlexponent == 0) && (distl_startheight == -1)
% %             distlscale = distlscale * (-1);
% %         end
% %         if (distlexponent == 0)
% %             constantmaker = 0;
% %         elseif (distlexponent ~= 0)
% %             constantmaker = 1;
% %         end
% % 
% %         %disp(distldirection)
% %         %distl_endheight = ((distl_endpos - distl_startpos)^1) * distl_startpos;
% %         disp(distl_startpos)      % Display the actual value
% %         disp(distlexponent)
% %         disp(distldirection)
% %         disp(distl_startheight)
% % 
% %         if isempty(distl_startpos)
% %             distl_startpos = 0; % Or any default scalar value
% %         end
% % 
% %         if isempty(distl_endpos)
% %             distl_endpos = 0; % Or any default scalar value
% %         end
% % 
% % 
% %             DistlXBetween = linspace(distl_startpos,distl_endpos,10);
% %             DistlYBetween = ((DistlXBetween - distl_startpos) .^ distlexponent);                 %linspace(0,((distl_endpos - distl_startpos)^1) * distl_startpos);
% %             DistlX = [distl_startpos DistlXBetween distl_endpos];
% %             DistlY = [0 (distldirection * (DistlYBetween ./ DistlYBetween(10:10)) + distl_startheight) 0];
% %             disp(DistlY)
% %             %DistlY = [0 (distldirection * (DistlYBetween ./ max(DistlYBetween)) + distl_startheight) 0];
% %             TextDistlX = distl_endpos + (1/2);
% %             TextDistlY = DistlY(12:12) + (1/2);
% %         % distlphi = deg2rad(distl_angle-90);
% %         % DistlR = [cos(distlphi) -sin(distlphi); sin(distlphi) cos(distlphi)];
% %             Distl = [TextDistlX NaN DistlX; TextDistlY NaN DistlY];
% %             DistlRotated = Distl; %DistlR * Distl;
% %             DistlXRotated = DistlRotated(1,:);
% %             DistlYRotated = DistlRotated(2,:) * distlscale * (1 / main.BarLgh * (distl_endpos - distl_startpos));
% %             hold(app.UIAxes_Setup,"on")
% %             plot(app.UIAxes_Setup, DistlXRotated(2:14),DistlYRotated(2:14),'LineWidth',2,'Color',"blue");   % plot distl
% %             text(app.UIAxes_Setup, DistlXRotated(1),DistlYRotated(1),strcat("q = (", num2str(main.Distl.StartValue(i)),")+(", num2str(main.Distl.Pitch(i)), '*x^{' , num2str(distlexponent) , '}',") N/m" ),'Fontsize',15,'Color',"blue");   % name distl
% % 
% % 
% %             grid(app.UIAxes_Setup,'on')
% %             axis(app.UIAxes_Setup,'equal')
% %             axis(app.UIAxes_Setup,'padded')
% %     end
% % end