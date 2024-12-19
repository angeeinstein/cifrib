classdef Limits
    % LIMITS Summary of this class goes here
    % contains the limits for N, Q and Mb
    
    properties
        LimitsN     % object of type Limit (contains the upper and lower limit for N)
        LimitsQ     % object of type Limit (contains the upper and lower limit for Q)
        LimitsMb    % object of type Limit (contains the upper and lower limit for Mb)
    end
    
    methods
        function obj = Limits(limitsN, limitsQ, limitsMb)
            % LIMITS Construct an instance of this class
            obj.LimitsN = limitsN;
            obj.LimitsQ = limitsQ;
            obj.LimitsMb = limitsMb;
        end
    end
end

