function PlotDistl(app)
global main;
    [~,j] = size(main.Distl);
    for i=1:j
        distlexponent = main.Distl(5,i);
        distl_startpos = main.Distl(1,i);    % start position of distl
        distl_endpos = main.Distl(2,i);   % end position of distl
        distldirection = sign(main.Distl(6,i));   % 1 or -1 sign(x)
        distl_startheight = sign(main.Distl(3,i));
    
        % Distributed Load
        % define distl
        distlscale = (main.BarLgh/4); %(1 / bar1length * (distl_endpos - distl_startpos));    % size of the shape = 1/10 of bar length 
        if (distlexponent == 0) && (distl_startheight == 0)
            distlscale = 0;
        elseif (distlexponent == 0) && (distl_startheight == -1)
            distlscale = distlscale * (-1);
        end
        
        %disp(distldirection)
        %distl_endheight = ((distl_endpos - distl_startpos)^1) * distl_startpos;
        disp(distl_startpos)      % Display the actual value
        disp(distlexponent)
        disp(distldirection)
        disp(distl_startheight)

        if isempty(distl_startpos)
            distl_startpos = 0; % Or any default scalar value
        end
    
        if isempty(distl_endpos)
            distl_endpos = 0; % Or any default scalar value
        end
    
    
            DistlXBetween = linspace(distl_startpos,distl_endpos,10);
            DistlYBetween = ((DistlXBetween - distl_startpos) .^ distlexponent);                 %linspace(0,((distl_endpos - distl_startpos)^1) * distl_startpos);
            DistlX = [distl_startpos DistlXBetween distl_endpos];
            DistlY = [0 (distldirection * (DistlYBetween ./ DistlYBetween(10:10)) + distl_startheight) 0];
            disp(DistlY)
            %DistlY = [0 (distldirection * (DistlYBetween ./ max(DistlYBetween)) + distl_startheight) 0];
            TextDistlX = distl_endpos + (1/2);
            TextDistlY = DistlY(12:12) + (1/2);
        % distlphi = deg2rad(distl_angle-90);
        % DistlR = [cos(distlphi) -sin(distlphi); sin(distlphi) cos(distlphi)];
            Distl = [TextDistlX NaN DistlX; TextDistlY NaN DistlY];
            DistlRotated = Distl; %DistlR * Distl;
            DistlXRotated = DistlRotated(1,:);
            DistlYRotated = DistlRotated(2,:) * distlscale * (1 / main.BarLgh * (distl_endpos - distl_startpos));
            hold(app.UIAxes_Setup,"on")
            plot(app.UIAxes_Setup, DistlXRotated(2:14),DistlYRotated(2:14),'LineWidth',2,'Color',"blue");   % plot distl
            text(app.UIAxes_Setup, DistlXRotated(1),DistlYRotated(1),strcat("q = (", num2str(main.Distl(3,i)),")+(", num2str(main.Distl(6,i)), '*x^{' , num2str(distlexponent) , '}',") N/m" ),'Fontsize',15,'Color',"blue");   % name distl
                       
            
            grid(app.UIAxes_Setup,'on')
            axis(app.UIAxes_Setup,'equal')
            axis(app.UIAxes_Setup,'padded')
    end
end