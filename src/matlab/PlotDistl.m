function PlotDistl(app)
global main;
    [~,j] = size(main.Distl);
    for i =1:j
             constshape1exponent = main.Distl(4,i);
        %constshape1exponent = exponent;
    
        constshape1_startpos = main.Distl(1,i);    % start position of constshape1
        constshape1_endpos = main.Distl(2,i);   % end position of constshape1
    
        % Distributed Load
        % define constshape1
            constshape1scale = (main.BarLgh/2); %(1 / bar1length * (constshape1_endpos - constshape1_startpos));    % size of the shape = 1/10 of bar length 
            constshape1direction = sign(main.Distl(5,i));   % 1 or -1 sign(x)
            constshape1_startheight = sign(main.Distl(3,i));
        %constshape1_endheight = ((constshape1_endpos - constshape1_startpos)^1) * constshape1_startpos;
        whos constshape1_startpos constshape1_endpos
        disp(class(constshape1_startpos)); % Display the type
        disp(size(constshape1_startpos)); % Display the dimensions
        disp(constshape1_startpos);       % Display the actual value
        if isempty(constshape1_startpos)
            constshape1_startpos = 0; % Or any default scalar value
        end
    
        if isempty(constshape1_endpos)
            constshape1_endpos = 0; % Or any default scalar value
        end
    
    
            ConstShape1XBetween = linspace(constshape1_startpos,constshape1_endpos,10);
            ConstShape1YBetween = ((ConstShape1XBetween - constshape1_startpos) .^ constshape1exponent);                                          %linspace(0,((constshape1_endpos - constshape1_startpos)^1) * constshape1_startpos);
            ConstShape1X = [constshape1_startpos ConstShape1XBetween constshape1_endpos];
            ConstShape1Y = [0 (constshape1direction*(ConstShape1YBetween./ConstShape1YBetween(10:10)) + constshape1_startheight) 0];
            TextConstShape1X = constshape1_endpos + (1/2);
            TextConstShape1Y = ConstShape1Y(12:12) + (1/2);
        % constshape1phi = deg2rad(constshape1_angle-90);
        % ConstShape1R = [cos(constshape1phi) -sin(constshape1phi); sin(constshape1phi) cos(constshape1phi)];
            ConstShape1 = [TextConstShape1X NaN ConstShape1X; TextConstShape1Y NaN ConstShape1Y];
            ConstShape1Rotated = ConstShape1; %ConstShape1R * ConstShape1;
            ConstShape1XRotated = ConstShape1Rotated(1,:);
            ConstShape1YRotated = ConstShape1Rotated(2,:) * constshape1scale * (1 / main.BarLgh * (constshape1_endpos - constshape1_startpos));
            hold(app.UIAxes_Setup,"on")
            plot(app.UIAxes_Setup, ConstShape1XRotated(2:14),ConstShape1YRotated(2:14),'LineWidth',2,'Color',"blue");   % plot constshape1
            text(app.UIAxes_Setup, ConstShape1XRotated(1),ConstShape1YRotated(1),strcat("q = ", num2str(main.Distl(3,i)),"+", num2str(main.Distl(5,i)), '*x^{' , num2str(constshape1exponent) , '}'," N/m" ),'Fontsize',15,'Color',"blue");   % name constshape1
                       
            
            grid(app.UIAxes_Setup,'on')
            axis(app.UIAxes_Setup,'equal')
            axis(app.UIAxes_Setup,'padded')
    end
end