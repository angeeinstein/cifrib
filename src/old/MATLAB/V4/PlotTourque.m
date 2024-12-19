function PlotTourque(app)
global main;

    [~,j] = size(main.Torque);
    for i= 1:j
        % Plot
            moment1_pos = main.Torque(1,i);
            moment1scale = (main.BarLgh/30);   % size of the joint = 1/30 of bar length
            moment1_sign = main.Torque(2,i);

            moment1_direction = sign(moment1_sign);
            Moment1X = [0 NaN 1 (0.866) (0.5) 0 NaN (-1) (-0.866) (-0.5) 0 (0.5) (0.866) 1];
            Moment1Y = [0 NaN 0 (0.5) (0.866) 1 NaN 0 (-0.5) (-0.866) (-1) (-0.866) (-0.5) 0];
            MomentArrow1X = [(1/4) (1/4) 0 (1/4) (1/4)];   % define the tip of moment1
            MomentArrow1Y = [0 (1/4) 0 (-1/4) 0];  % define the tip of moment1
            momentarrow1phi = deg2rad(-15);
            MomentArrow1R = [cos(momentarrow1phi) -sin(momentarrow1phi); sin(momentarrow1phi) cos(momentarrow1phi)];
            MomentArrow1 = [MomentArrow1X; MomentArrow1Y];
            MomentArrow1Rotated = MomentArrow1R * MomentArrow1;
            TextMoment1X = 1 + (1/2);
            TextMoment1Y = 1 + (1/2);
            Moment1 = [TextMoment1X NaN Moment1X NaN MomentArrow1Rotated(1,:); TextMoment1Y NaN Moment1Y NaN MomentArrow1Rotated(2,:)+1] * moment1scale;
            Moment1XRotated = (Moment1(1,:)*moment1_direction) + moment1_pos;
            Moment1YRotated = Moment1(2,:);
            plot(app.UIAxes_Setup, Moment1XRotated(2:22),Moment1YRotated(2:22),'LineWidth',2,'Color','green');
            text(app.UIAxes_Setup, Moment1XRotated(1),Moment1YRotated(1),strcat("M = ", num2str(main.Torque(2,i)), " Nm"),'Fontsize',15,'Color',"green");   % name moment1
            grid(app.UIAxes_Setup,'on')
            axis(app.UIAxes_Setup,'equal')
            axis(app.UIAxes_Setup,'padded')
    end

end