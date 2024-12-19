classdef BearingLoads
    % BEARINGLOADS Summary of this class goes here
    % contains the reacting loads of each bearing
    
    properties
        A   % object of type Bearing (contains reacting loads of bearing A)
        B   % object of type Bearing (contains reacting loads of bearing B)
    end
    
    methods
        function obj = BearingLoads(a, b)
            % BEARINGLOADS Construct an instance of this class
            obj.A = a;
            obj.B = b;
        end
    end
end

