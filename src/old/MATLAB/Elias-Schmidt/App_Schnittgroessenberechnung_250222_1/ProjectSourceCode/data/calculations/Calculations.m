classdef Calculations
    % CALCULATIONS Summary of this class goes here
    % contains all results and information produced by the main calculating
    % function "statics Calculations" in order to pass them to the GUI
    
    properties
        X           % whole vector x
        Reaction    % object of type Reaction (contains all information regarding the system's reaction)
        Limits      % object of type Limits (contains the limits for N, Q and Mb)
        Indicators  % object of type Indicators (contains the indicators for N, Q and Mb)
    end
    
    methods
        function obj = Calculations(x, reaction, limits, indicators)
            % CALCULATIONS Construct an instance of this class
            obj.X = x;
            obj.Reaction = reaction;
            obj.Limits = limits;
            obj.Indicators = indicators;
        end
    end
end

