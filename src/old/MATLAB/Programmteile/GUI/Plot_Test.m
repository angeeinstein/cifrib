%% input
clear
clc
clf

bar1length = 30; % length of bar1

bearing1_pos = 0;   % position of bearing1
bearing1_angle = 0; % angle of bearing1
loose_bearing1 = false;
bearing1_enable = true;

bearing2_pos = bar1length;   % position of bearing1
bearing2_angle = 30; % angle of bearing1
loose_bearing2 = true;
bearing2_enable = true;

clampedsupport_pos = 0; % position of clamped support
clampedsupport_enable = false;

arrow1_angle = 45;    % angle of arrow1
arrow1_pos = bar1length/2; % position of arrow1
arrow1_sign = -1;    % direction of the arrow
arrow1_enable = true;

arrow2_angle = 90;    % angle of arrow2
arrow2_pos = bar1length/3; % position of arrow2
arrow2_enable = false;

constshape1_startpos = 10;    % start position of constshape1
constshape1_endpos = bar1length;   % end position of constshape1
constshape1_startheight = 3;    % start height of constshape1
constshape1_pitch = 1;
%constshape1_angle = 90;  % angle of shape1
constshape1_enable = true;

% linshape1_startpos = 2;    % start position of linshape1
% linshape1_endpos = bar1length-3;   % end position of linshape1
% linshape1_startheight = 3;    % start height of linshape1
% linshape1_angle = 90;   % angle of linshape1
% linshape1_enable = true;
% 
% quadshape1_startpos = 2;    % start position of quadshape1
% quadshape1_endpos = bar1length-3;   % end position of quadshape1
% quadshape1_startheight = 3;    % start height of quadshape1
% quadshape1_angle = 90;  % angle of quadshape1
% quadshape1_enable = true;

momentjoint1_pos = bar1length/2;    % position of momentjoint1
momentjoint1_enable = true;

shearforcejoint1_pos = bar1length/3;
shearforcejoint1_enable = true;

moment1_pos = bar1length/3;  % position of moment1
moment1_sign = 1;   % direction of the arrow. left for positive moment, right for negative moment
moment1_enable = 1;

quadshape1_startpos = 2;    % start position of quadshape1
quadshape1_endpos = bar1length-3;   % end position of quadshape1
quadshape1_angle = 90;  % angle of quadshape1
quadshape1_enable = true;


%% define shapes

% define bar
X = [0 bar1length];
Y = [0 0];

% define bearing1
if loose_bearing1 == true
    bearing1hatchingshift = (-1/4);
else
    bearing1hatchingshift = 0;
end
bearing1scale = (bar1length/15);    % size of the bearing = 1/10 of bar length
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

% define bearing2
if loose_bearing2 == true
    bearing2hatchingshift = (-1/4);
else
    bearing2hatchingshift = 0;
end
bearing2scale = (bar1length/15);    % size of the bearing = 1/10 of bar length
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

% define clamped support
clampedsupportscale = (bar1length/15);    % size of the support = 1/10 of bar length
ClampedSupportX = [0 0 0];
ClampedSupportY = [0 1 (-1)];
ClampedSupportHatching1X = [0 (-1/2)];
ClampedSupportHatching1Y = [0 (-1/2)] + (2/2);
ClampedSupportHatching2X = [0 (-1/2)];
ClampedSupportHatching2Y = [0 (-1/2)] + (1/2);
ClampedSupportHatching3X = [0 (-1/2)];
ClampedSupportHatching3Y = [0 (-1/2)] + (0/2);
ClampedSupportHatching4X = [0 (-1/2)];
ClampedSupportHatching4Y = [0 (-1/2)] + (-1/2);
ClampedSupport = [ClampedSupportX NaN ClampedSupportHatching1X NaN ClampedSupportHatching2X NaN ClampedSupportHatching3X NaN ClampedSupportHatching4X; ClampedSupportY NaN ClampedSupportHatching1Y NaN ClampedSupportHatching2Y NaN ClampedSupportHatching3Y NaN ClampedSupportHatching4Y] * clampedsupportscale;
ClampedSupportXRotated = [ClampedSupport(1,:)];
ClampedSupportYRotated = [ClampedSupport(2,:)];

% define momentjoint1
momentjoint1scale = (bar1length/60);   % size of the joint = 1/60 of bar length
MomentJoint1X = [0 1 (0.866) (0.5) 0 (-0.5) (-0.866) (-1) (-0.866) (-0.5) 0 (0.5) (0.866) 1] * momentjoint1scale;
MomentJoint1Y = [0 0 (0.5) (0.866) 1 (0.866) (0.5) 0 (-0.5) (-0.866) (-1) (-0.866) (-0.5) 0] * momentjoint1scale;
MomentJoint1XRotated = MomentJoint1X + momentjoint1_pos;
MomentJoint1YRotated = MomentJoint1Y;

% define arrow1
arrow1_length = 3;
arrow1scale = ((bar1length/arrow1_length)/3);    % length of the arrow = 1/10 of bar length
arrow1_direction = sign(arrow1_sign);
arrow1phi = deg2rad(arrow1_angle-180);
TextArrow1X = [(-6/4)] * arrow1_length;
TextArrow1Y = [(-2/4)] * arrow1_length;
Line1X = [(-4/4) (-1/4)] * arrow1_length;    % define the line of arrow1
Line1Y = [0 0] * arrow1_length;  % define the line of arrow1
Arrow1X = [(-1/4) (-1/4) 0 (-1/4) (-1/4)];   % define the tip of arrow1
Arrow1Y = [0 (1/4) 0 (-1/4) 0];  % define the tip of arrow1
Arrow1R = [cos(arrow1phi) -sin(arrow1phi); sin(arrow1phi) cos(arrow1phi)];
Arrow1 = [TextArrow1X Line1X Arrow1X; TextArrow1Y Line1Y Arrow1Y] * arrow1scale;
Arrow1Rotated = Arrow1R * Arrow1;
Arrow1XRotated = Arrow1Rotated(1,:) * arrow1_direction + arrow1_pos;
Arrow1YRotated = Arrow1Rotated(2,:) * arrow1_direction;

% define arrow2
arrow2_length = 2;
arrow2scale = ((bar1length/arrow2_length)/10);    % length of the arrow = 1/10 of bar length
arrow2phi = deg2rad(arrow2_angle-180);
TextArrow2X = [(-6/4)] * arrow2_length;
TextArrow2Y = [(-2/4)] * arrow2_length;
Line2X = [(-4/4) (-1/4)] * arrow2_length;    % define the line of arrow2
Line2Y = [0 0];  % define the line of arrow2
Arrow2X = [(-1/4) (-1/4) 0 (-1/4) (-1/4)];   % define the tip of arrow2
Arrow2Y = [0 (1/4) 0 (-1/4) 0];  % define the tip of arrow2
Arrow2R = [cos(arrow2phi) -sin(arrow2phi); sin(arrow2phi) cos(arrow2phi)];
Arrow2 = [TextArrow2X Line2X Arrow2X; TextArrow2Y Line2Y Arrow2Y] * arrow2scale;
Arrow2Rotated = Arrow2R * Arrow2;
Arrow2XRotated = Arrow2Rotated(1,:) + arrow2_pos;
Arrow2YRotated = Arrow2Rotated(2,:);

% define constshape1
constshape1scale = (bar1length/2); %(1 / bar1length * (constshape1_endpos - constshape1_startpos));    % size of the shape = 1/10 of bar length 
constshape1exponent = 2;    % 0, 1 or 2
constshape1direction = sign(constshape1_pitch);   % 1 or -1 sign(x)
constshape1_startheight = 1;
%constshape1_endheight = ((constshape1_endpos - constshape1_startpos)^1) * constshape1_startpos;
ConstShape1XBetween = linspace(constshape1_startpos,constshape1_endpos,10);
ConstShape1YBetween = ((ConstShape1XBetween - constshape1_startpos) .^ constshape1exponent);                                          %linspace(0,((constshape1_endpos - constshape1_startpos)^1) * constshape1_startpos);
ConstShape1X = [constshape1_startpos ConstShape1XBetween constshape1_endpos];
ConstShape1Y = [0 (constshape1direction*(ConstShape1YBetween./ConstShape1YBetween(10:10)) + constshape1_startheight) 0];
TextConstShape1X = [constshape1_endpos + (1/2)];
TextConstShape1Y = [ConstShape1Y(12:12) + (1/2)];
% constshape1phi = deg2rad(constshape1_angle-90);
% ConstShape1R = [cos(constshape1phi) -sin(constshape1phi); sin(constshape1phi) cos(constshape1phi)];
ConstShape1 = [TextConstShape1X NaN ConstShape1X; TextConstShape1Y NaN ConstShape1Y];
ConstShape1Rotated = ConstShape1; %ConstShape1R * ConstShape1;
ConstShape1XRotated = ConstShape1Rotated(1,:);
ConstShape1YRotated = ConstShape1Rotated(2,:) * constshape1scale * (1 / bar1length * (constshape1_endpos - constshape1_startpos));

% define moment1
moment1scale = (bar1length/15);   % size of the joint = 1/30 of bar length
moment1_direction = sign(moment1_sign);
Moment1X = [0 NaN 1 (0.866) (0.5) 0 NaN (-1) (-0.866) (-0.5) 0 (0.5) (0.866) 1];
Moment1Y = [0 NaN 0 (0.5) (0.866) 1 NaN 0 (-0.5) (-0.866) (-1) (-0.866) (-0.5) 0];
MomentArrow1X = [(1/4) (1/4) 0 (1/4) (1/4)];   % define the tip of moment1
MomentArrow1Y = [0 (1/4) 0 (-1/4) 0];  % define the tip of moment1
momentarrow1phi = deg2rad(-15);
MomentArrow1R = [cos(momentarrow1phi) -sin(momentarrow1phi); sin(momentarrow1phi) cos(momentarrow1phi)];
MomentArrow1 = [MomentArrow1X; MomentArrow1Y];
MomentArrow1Rotated = MomentArrow1R * MomentArrow1;
TextMoment1X = [1 + (1/2)];
TextMoment1Y = [1 + (1/2)];
Moment1 = [TextMoment1X NaN Moment1X NaN MomentArrow1Rotated(1,:); TextMoment1Y NaN Moment1Y NaN MomentArrow1Rotated(2,:)+1] * moment1scale;
Moment1XRotated = (Moment1(1,:)*moment1_direction) + moment1_pos;
Moment1YRotated = Moment1(2,:);



%% Plot

figure(1);
ha = axes;
hs1 = subplot(1,1,1);
hold(hs1, 'on');
grid on

bar1 = plot(X,Y,'LineWidth',4,'Color','k');  % plot the bar

if bearing1_enable == true
    bearing1 = plot(Bearing1XRotated,Bearing1YRotated,'LineWidth',2,'Color','k');   % plot bearing1
end

if bearing2_enable == true
    bearing2 = plot(Bearing2XRotated,Bearing2YRotated,'LineWidth',2,'Color','k');   % plot bearing2
end

if clampedsupport_enable == true
    clampedsupport = plot(ClampedSupportXRotated,ClampedSupportYRotated,'LineWidth',2,'Color','k');   % plot bearing2
end

if momentjoint1_enable == true
    momentjoint1 = plot(MomentJoint1XRotated(2:14),MomentJoint1YRotated(2:14),'LineWidth',2,'Color','k');   % plot momentjoint1
end

if arrow1_enable == true
    arrow1 = plot(Arrow1XRotated(2:8),Arrow1YRotated(2:8),'LineWidth',2,'Color','r');   % plot arrow1
    arrow1text = text(Arrow1XRotated(1),Arrow1YRotated(1),'F1','Fontsize',15,'Color','r');   % name arrow1
end

if arrow2_enable == true
    arrow2 = plot(Arrow2XRotated(2:8),Arrow2YRotated(2:8),'LineWidth',2,'Color','r');   % plot arrow2
    arrow2text = text(Arrow2XRotated(1),Arrow2YRotated(1),'F2','Fontsize',15,'Color','r');   % name arrow2
end

if constshape1_enable == true
    constshape1 = plot(ConstShape1XRotated(2:14),ConstShape1YRotated(2:14),'LineWidth',2,'Color',"#A2142F");   % plot constshape1
    constshape1text = text(ConstShape1XRotated(1),ConstShape1YRotated(1),'q1','Fontsize',15,'Color',"#A2142F");   % name constshape1
end

if moment1_enable == true
    moment1 = plot(Moment1XRotated(2:22),Moment1YRotated(2:22),'LineWidth',2,'Color',"#7E2F8E");   % plot moment1
    moment1text = text(Moment1XRotated(1),Moment1YRotated(1),'M1','Fontsize',15,'Color',"#7E2F8E");   % name moment1
end

axis equal
axis padded

% xlim([-(barlength * 0.1) (barlength * 1.1)])
% ylim([-(arrowscale * 0.1) (arrowscale * 11)])
