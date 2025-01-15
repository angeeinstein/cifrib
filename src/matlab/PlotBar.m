function PlotBar(app)
global main;
    [~,j] = size(main.BarLgh);
    for i = 1:j
        cla (app.UIAxes_Setup, 'reset');
        X = [0 main.BarLgh(1,i)];
        Y = [0 0];
        plot(app.UIAxes_Setup,X,Y,'LineWidth',4,'Color','k');
        hold(app.UIAxes_Setup,'on')
           
    end
end