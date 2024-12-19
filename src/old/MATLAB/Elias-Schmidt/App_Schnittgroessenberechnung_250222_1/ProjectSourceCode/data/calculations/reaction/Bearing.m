classdef Bearing
    % BEARING Summary of this class goes here
    % contains horizontal and vertical force and moment for one bearing
    
    properties
        Fx
        Fz
        My
    end
    
    methods
        function obj = Bearing(fx, fz, my)
            %BEARING Construct an instance of this class
            obj.Fx = fx;
            obj.Fz = fz;
            obj.My = my;
        end
    end
end

