function PlotBearing(app)
global main;
[~,j] = size(main.Bearing);
    for i = 1:j
        if main.Bearing(2,i) == 1 && main.Bearing(3,i) == 1 && main.Bearing(4,i) == 1           % Clamped Bearing
            % Plot
                clampedsupportscale = main.BarLgh/15;    % size of the support = 1/10 of bar length
                ClampedSupportX = [0 0 0];
                ClampedSupportY = [0 1 -1];
                ClampedSupportHatching1X = [0 (-1/2)];
                ClampedSupportHatching1Y = [0 (-1/2)] + 1;
                ClampedSupportHatching2X = [0 (-1/2)];
                ClampedSupportHatching2Y = [0 (-1/2)] + (1/2);
                ClampedSupportHatching3X = [0 (-1/2)];
                ClampedSupportHatching3Y = [0 (-1/2)];
                ClampedSupportHatching4X = [0 (-1/2)];
                ClampedSupportHatching4Y = [0 (-1/2)] + (-1/2);
                ClampedSupport = [...
        ClampedSupportX NaN ClampedSupportHatching1X NaN ClampedSupportHatching2X NaN ClampedSupportHatching3X NaN ClampedSupportHatching4X; 
        ClampedSupportY NaN ClampedSupportHatching1Y NaN ClampedSupportHatching2Y NaN ClampedSupportHatching3Y NaN ClampedSupportHatching4Y] ...
        * clampedsupportscale;
                ClampedSupportXRotated = ClampedSupport(1,:) + mian.Bearing(1,i);
                ClampedSupportYRotated = ClampedSupport(2,:);
                plot(app.UIAxes_Setup,ClampedSupportXRotated,ClampedSupportYRotated,'LineWidth',2,'Color','k');   % plot bearing2
                grid(app.UIAxes_Setup,'on')
                axis(app.UIAxes_Setup,'equal')
                axis(app.UIAxes_Setup,'padded')
                hold(app.UIAxes_Setup,'on')
        elseif main.Bearing(2,i) == 1 && main.Bearing(3,i) == 1 && main.Bearing(4,i) == 0       % Fixed Bearing
            % Plot
            bearing1_pos = main.Bearing(1,i);   % position of bearing1
            bearing1_angle = 0; % angle of bearing1
            bearing1hatchingshift = 0;
            bearing1scale = (main.BarLgh/15);    % size of the bearing = 1/10 of bar length
            Bearing1X = [0 (1/2) (-1/2) 0];
            Bearing1Y = [0 (-1) (-1) 0];
            Bearing1BaseX = [-1 1];
            Bearing1BaseY = [-1 -1] + bearing1hatchingshift;
            Bearing1Hatching1X = [(-1/2) -1];
            Bearing1Hatching1Y = [-1 (-3/2)] + bearing1hatchingshift;
            Bearing1Hatching2X = [0 (-1/2)];
            Bearing1Hatching2Y = [-1 (-3/2)] + bearing1hatchingshift;
            Bearing1Hatching3X = [(1/2) 0];
            Bearing1Hatching3Y = [-1 (-3/2)] + bearing1hatchingshift;
            bearing1phi = deg2rad(bearing1_angle);
            BearingR1 = [cos(bearing1phi) -sin(bearing1phi); sin(bearing1phi) cos(bearing1phi)];
            Bearing1 = [Bearing1X NaN Bearing1BaseX NaN Bearing1Hatching1X NaN Bearing1Hatching2X NaN Bearing1Hatching3X; Bearing1Y NaN Bearing1BaseY NaN Bearing1Hatching1Y NaN Bearing1Hatching2Y NaN Bearing1Hatching3Y] * bearing1scale;
            Bearing1Rotated = BearingR1 * Bearing1;
            Bearing1XRotated = Bearing1Rotated(1,:) + bearing1_pos;
            Bearing1YRotated = Bearing1Rotated(2,:);
            plot(app.UIAxes_Setup,Bearing1XRotated,Bearing1YRotated,'LineWidth',2,'Color','k');   % plot bearing1
            grid(app.UIAxes_Setup,'on')
            axis(app.UIAxes_Setup,'equal')
            axis(app.UIAxes_Setup,'padded')
            hold(app.UIAxes_Setup,'on')

        elseif main.Bearing(2,i) == 1 && main.Bearing(3,i) == 0 && main.Bearing(4,i) == 0       % Loose Bearing
            % Plot
            bearing2_pos = mian.Bearin(1,i);   % position of bearing1
            bearing2_angle = 0; % angle of bearing1
            % define bearing2
            bearing2hatchingshift = (-1/4);
            bearing2scale = (main.BarLgh/15);    % size of the bearing = 1/10 of bar length
            Bearing2X = [0 (1/2) (-1/2) 0];
            Bearing2Y = [0 (-1) (-1) 0];
            Bearing2BaseX = [-1 1];
            Bearing2BaseY = [-1 -1] + bearing2hatchingshift;
            Bearing2Hatching1X = [(-1/2) -1];
            Bearing2Hatching1Y = [-1 (-3/2)] + bearing2hatchingshift;
            Bearing2Hatching2X = [0 (-1/2)];
            Bearing2Hatching2Y = [-1 (-3/2)] + bearing2hatchingshift;
            Bearing2Hatching3X = [(1/2) 0];
            Bearing2Hatching3Y = [-1 (-3/2)] + bearing2hatchingshift;
            bearing2phi = deg2rad(bearing2_angle);
            BearingR2 = [cos(bearing2phi) -sin(bearing2phi); sin(bearing2phi) cos(bearing2phi)];
            Bearing2 = [Bearing2X NaN Bearing2BaseX NaN Bearing2Hatching1X NaN Bearing2Hatching2X NaN Bearing2Hatching3X; Bearing2Y NaN Bearing2BaseY NaN Bearing2Hatching1Y NaN Bearing2Hatching2Y NaN Bearing2Hatching3Y] * bearing2scale;
            Bearing2Rotated = BearingR2 * Bearing2;
            Bearing2XRotated = Bearing2Rotated(1,:) + bearing2_pos;
            Bearing2YRotated = Bearing2Rotated(2,:);
            plot(app.UIAxes_Setup, Bearing2XRotated,Bearing2YRotated,'LineWidth',2,'Color','k');   % plot bearing2
            grid(app.UIAxes_Setup,'on')
            axis(app.UIAxes_Setup,'equal')
            axis(app.UIAxes_Setup,'padded')
            hold(app.UIAxes_Setup,'on')
        end
           
    end


end