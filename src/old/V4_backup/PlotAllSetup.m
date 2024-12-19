function PlotAllSetup(app,exponent)

    cla(app.UIAxes_Setup)
    PlotBearing(app);
    PlotHinge(app);
    PlotForce(app);
    PlotTourque(app);
    PlotDistl(app,exponent);

end