t=0:.5:5; y=sin(t); hPlot=plot(t,y);
hPlot.ButtonDownFcn = @(h,e) disp(e.IntersectionPoint);