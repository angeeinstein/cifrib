function PlotHinge(app)
global main;
    % for every Joint
    [~,j] = size(main.Joint);
    
    for i=1:j
        if main.Joint(2,i) == 1 && main.Joint(3,i) == 1 && main.Joint(4,i) == 0
            % Plot
                momentjoint1_pos = main.Joint(1,i); 
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

        elseif main.Joint(2,i) == 0 && main.Joint(3,i) == 1 && main.Joint(4,i) == 1
            % Plot
                momentjoint1_pos = main.Joint(1,i); 
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
        elseif main.Joint(2,i) == 1 && main.Joint(3,i) == 0 && main.Joint(4,i) == 1
            % Plot
                momentjoint1_pos = main.Joint(1,i); 
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

        end
    end

end