classdef Limit
    % LIMIT Summary of this class goes here
    % contains the upper and lower limit for one single distribution graph
    
    properties
        UpperLimit
        LowerLimit
    end
    
    methods
        function obj = Limit(upperLimit, lowerLimit)
            % LIMIT Construct an instance of this classre
            obj.UpperLimit = upperLimit;
            obj.LowerLimit = lowerLimit;
        end
    end
end

