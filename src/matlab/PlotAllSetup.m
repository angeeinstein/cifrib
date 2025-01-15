function PlotAllSetup(app)

    cla(app.UIAxes_Setup)
    PlotBearing(app);
    PlotHinge(app);
    PlotForce(app);
    PlotTourque(app);
    PlotDistl(app);

end