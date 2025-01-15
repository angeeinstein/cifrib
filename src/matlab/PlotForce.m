function PlotForce(app)
global main;
    [~,j] = size(main.Force);
    for i=1:j
        % Plot
            arrow2_angle = main.Force(2,i);    % angle of arrow2
            arrow2_pos = main.Force(1,i);   % position of arrow2
                
        % define arrow2
            arrow2_length = 2;
            arrow2scale = ((main.BarLgh/arrow2_length)/10);    % length of the arrow = 1/10 of bar length
            arrow2phi = deg2rad(arrow2_angle-180);
            TextArrow2X = (-6/4) * arrow2_length;
            TextArrow2Y = (-2/4) * arrow2_length;
            Line2X = [(-4/4) (-1/4)] * arrow2_length;    % define the line of arrow2
            Line2Y = [0 0];  % define the line of arrow2
            Arrow2X = [(-1/4) (-1/4) 0 (-1/4) (-1/4)];   % define the tip of arrow2
            Arrow2Y = [0 (1/4) 0 (-1/4) 0];  % define the tip of arrow2
            Arrow2R = [cos(arrow2phi) -sin(arrow2phi); sin(arrow2phi) cos(arrow2phi)];
            Arrow2 = [TextArrow2X Line2X Arrow2X; TextArrow2Y Line2Y Arrow2Y] * arrow2scale;
            Arrow2Rotated = Arrow2R * Arrow2;
            Arrow2XRotated = Arrow2Rotated(1,:) + arrow2_pos;
            Arrow2YRotated = Arrow2Rotated(2,:);
            plot(app.UIAxes_Setup,Arrow2XRotated(2:8),Arrow2YRotated(2:8),'LineWidth',2,'Color','r');   % plot arrow2
            text(app.UIAxes_Setup,Arrow2XRotated(1),Arrow2YRotated(1),"F = "+ main.Force(1,i) + " N",'Fontsize',15,'Color','r');   % name arrow2
            grid(app.UIAxes_Setup,'on')
            axis(app.UIAxes_Setup,'equal')
            axis(app.UIAxes_Setup,'padded')
    end
end