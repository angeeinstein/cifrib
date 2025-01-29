function PlotHinge(app)
global main;
    % for every Joint
    j = length(main.Joint.Position);
    
    for i=1:j
        if main.Joint.XSupport(i) == 1 && main.Joint.ZSupport(i) == 1 && main.Joint.TSupport(i) == 0
            % Plot
            disp('momentjoint')    
            momentjoint1_pos = main.Joint.Position(i); 
            momentjoint1scale = (main.BarLgh/60);   % size of the joint = 1/60 of bar length
            MomentJoint1X = [0 1 (0.866) (0.5) 0 (-0.5) (-0.866) (-1) (-0.866) (-0.5) 0 (0.5) (0.866) 1] * momentjoint1scale;
            MomentJoint1Y = [0 0 (0.5) (0.866) 1 (0.866) (0.5) 0 (-0.5) (-0.866) (-1) (-0.866) (-0.5) 0] * momentjoint1scale;
            MomentJoint1XRotated = MomentJoint1X + momentjoint1_pos;
            MomentJoint1YRotated = MomentJoint1Y;
            plot(app.UIAxes_Setup, MomentJoint1XRotated(2:14),MomentJoint1YRotated(2:14),'LineWidth',2,'Color','k');   % plot momentjoint1
            grid(app.UIAxes_Setup,'on')
            axis(app.UIAxes_Setup,'equal')
            axis(app.UIAxes_Setup,'padded')
            hold(app.UIAxes_Setup,'on')

        elseif main.Joint.XSupport(i) == 0 && main.Joint.ZSupport(i) == 1 && main.Joint.TSupport(i) == 1
            % Plot
            disp('normalforcejoint')
            normalforcejoint1_pos = main.Joint.Position(i);
            normalforcejoint1scale = (main.BarLgh/60);   % size of the joint = 1/60 of bar length
            NormalforceJoint1X = [0 (-1)  1 NaN (-3/4) (3/4) NaN 1 (-1)] * normalforcejoint1scale;
            NormalforceJoint1Y = [0 (1/2) (1/2) NaN 0 0 NaN (-1/2) (-1/2)] * normalforcejoint1scale;
            NormalforceJoint1XRotated = NormalforceJoint1X + normalforcejoint1_pos;
            NormalforceJoint1YRotated = NormalforceJoint1Y;
            plot(app.UIAxes_Setup, NormalforceJoint1XRotated(2:4),NormalforceJoint1YRotated(2:4),'LineWidth',2,'Color','k');   % plot normalforcejoint1
            plot(app.UIAxes_Setup, NormalforceJoint1XRotated(5:6),NormalforceJoint1YRotated(5:6),'LineWidth',4,'Color','w');
            plot(app.UIAxes_Setup, NormalforceJoint1XRotated(7:9),NormalforceJoint1YRotated(7:9),'LineWidth',2,'Color','k');
            grid(app.UIAxes_Setup,'on')
            axis(app.UIAxes_Setup,'equal')
            axis(app.UIAxes_Setup,'padded')
            hold(app.UIAxes_Setup,'on')

        elseif main.Joint.XSupport(i) == 1 && main.Joint.ZSupport(i) == 0 && main.Joint.TSupport(i) == 1
            % Plot
            disp('shearforcejoint')
            shearforcejoint1_pos = main.Joint.Position(i); 
            shearforcejoint1scale = (main.BarLgh/60);   % size of the joint = 1/60 of bar length
            ShearforceJoint1X = [0 (1/2) (1/2) NaN (-1/2) (1/2) NaN (-1/2) (-1/2)] * shearforcejoint1scale;
            ShearforceJoint1Y = [0 (-1)  1 NaN 0 0 NaN 1 (-1)] * shearforcejoint1scale;
            ShearforceJoint1XRotated = ShearforceJoint1X + shearforcejoint1_pos;
            ShearforceJoint1YRotated = ShearforceJoint1Y;
            plot(app.UIAxes_Setup, ShearforceJoint1XRotated(2:4),ShearforceJoint1YRotated(2:4),'LineWidth',2,'Color','k');   % plot shearforcejoint1
            plot(app.UIAxes_Setup, ShearforceJoint1XRotated(5:6),ShearforceJoint1YRotated(5:6),'LineWidth',4,'Color','W');
            plot(app.UIAxes_Setup, ShearforceJoint1XRotated(7:9),ShearforceJoint1YRotated(7:9),'LineWidth',2,'Color','k');
            grid(app.UIAxes_Setup,'on')
            axis(app.UIAxes_Setup,'equal')
            axis(app.UIAxes_Setup,'padded')
            hold(app.UIAxes_Setup,'on')

        end
    end

end