classdef MaxLoads
    % MAXLOADS Summary of this class goes here
    % contains the maximum values and their positions/intervals for N, Q and Mb
    
    properties
        MaxN    % object of type MaxLoad (contains the maximum load and it's position/interval/intervals for N)
        MaxQ    % object of type MaxLoad (contains the maximum load and it's position/interval/intervals for Q)
        MaxMb   % object of type MaxLoad (contains the maximum load and it's position/interval/intervals for Mb)
    end
    
    methods
        function obj = MaxLoads(maxN, maxQ, maxMb)
            %MAXLOADS Construct an instance of this class
            obj.MaxN = maxN;
            obj.MaxQ = maxQ;
            obj.MaxMb = maxMb;
        end
    end
end

