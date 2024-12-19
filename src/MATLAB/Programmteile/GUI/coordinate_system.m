%% Coordinate System Plot
clear
clc
clf

arrow1_angle = 180;    % angle of arrow1
arrow1_pos = 0; % position of arrow1
arrow1_sign = 1;    % direction of the arrow

arrow2_angle = 90;    % angle of arrow2
arrow2_pos = 0; % position of arrow2
arrow2_sign = 1;    % direction of the arrow

arrow3_angle = 45;    % angle of arrow3
arrow3_pos = 0; % position of arrow3
arrow3_sign = 1;    % direction of the arrow

%% define arrow1
arrow1_length = 2;
arrow1scale = 1;
arrow1phi = deg2rad(arrow1_angle-180);
TextArrow1X = [(-6/4)] * arrow1_length + 3.2;
TextArrow1Y = [(-2/4)] * arrow1_length + 1;
Line1X = [(-4/4) (-1/4)] * arrow1_length;    % define the line of arrow1
Line1Y = [0 0] * arrow1_length;  % define the line of arrow1
Arrow1X = [(-1/4) (-1/4) 0 (-1/4) (-1/4)];   % define the tip of arrow1
Arrow1Y = [0 (1/4) 0 (-1/4) 0];  % define the tip of arrow1
Arrow1R = [cos(arrow1phi) -sin(arrow1phi); sin(arrow1phi) cos(arrow1phi)];
Arrow1 = [TextArrow1X Line1X Arrow1X; TextArrow1Y Line1Y Arrow1Y] * arrow1scale;
Arrow1Rotated = Arrow1R * Arrow1;
Arrow1XRotated = Arrow1Rotated(1,:)  + 2 + arrow1_pos;
Arrow1YRotated = Arrow1Rotated(2,:);

%% define arrow2
arrow2_length = 2;
arrow2scale = 1;
arrow2phi = deg2rad(arrow2_angle-180);
TextArrow2X = [(-6/4)] * arrow2_length + 3.2;
TextArrow2Y = [(-2/4)] * arrow2_length + 1;
Line2X = [(-4/4) (-1/4)] * arrow2_length;    % define the line of arrow1
Line2Y = [0 0] * arrow2_length;  % define the line of arrow1
Arrow2X = [(-1/4) (-1/4) 0 (-1/4) (-1/4)];   % define the tip of arrow1
Arrow2Y = [0 (1/4) 0 (-1/4) 0];  % define the tip of arrow1
Arrow2R = [cos(arrow2phi) -sin(arrow2phi); sin(arrow2phi) cos(arrow2phi)];
Arrow2 = [TextArrow2X Line2X Arrow2X; TextArrow2Y Line2Y Arrow2Y] * arrow2scale;
Arrow2Rotated = Arrow2R * Arrow2;
Arrow2XRotated = Arrow2Rotated(1,:) + arrow2_pos;
Arrow2YRotated = Arrow2Rotated(2,:) - 2;

%% define arrow3
arrow3_length = 2;
arrow3scale = 1;
arrow3phi = deg2rad(arrow3_angle-180);
TextArrow3X = [(-6/4)] * arrow3_length + 3.2;
TextArrow3Y = [(-2/4)] * arrow3_length + 1;
Line3X = [(-4/4) (-1/4)] * arrow3_length;    % define the line of arrow1
Line3Y = [0 0] * arrow3_length;  % define the line of arrow1
Arrow3X = [(-1/4) (-1/4) 0 (-1/4) (-1/4)];   % define the tip of arrow1
Arrow3Y = [0 (1/4) 0 (-1/4) 0];  % define the tip of arrow1
Arrow3R = [cos(arrow3phi) -sin(arrow3phi); sin(arrow3phi) cos(arrow3phi)];
Arrow3 = [TextArrow3X Line3X Arrow3X; TextArrow3Y Line3Y Arrow3Y] * arrow3scale;
Arrow3Rotated = Arrow3R * Arrow3;
Arrow3XRotated = Arrow3Rotated(1,:) - (2/sqrt(2)) + arrow3_pos;
Arrow3YRotated = Arrow3Rotated(2,:) - (2/sqrt(2));

%% Plot

figure(1);
ha = axes;
hs1 = subplot(1,1,1);
hold(hs1, 'on');
grid on
axis equal

arrow1 = plot(Arrow1XRotated(2:8),Arrow1YRotated(2:8),'LineWidth',2,'Color','b');   % plot arrow1
arrow1text = text(Arrow1XRotated(1),Arrow1YRotated(1),'x','Fontsize',25,'Color','b');   % name arrow1

arrow2 = plot(Arrow2XRotated(2:8),Arrow2YRotated(2:8),'LineWidth',2,'Color','b');   % plot arrow1
arrow2text = text(Arrow2XRotated(1),Arrow2YRotated(1),'z','Fontsize',25,'Color','b');   % name arrow1

arrow3 = plot(Arrow3XRotated(2:8),Arrow3YRotated(2:8),'LineWidth',2,'Color','b');   % plot arrow1
arrow3text = text(Arrow3XRotated(1),Arrow3YRotated(1),'y','Fontsize',25,'Color','b');   % name arrow1