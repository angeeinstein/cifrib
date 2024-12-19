classdef IndicatorTypes
    % INDICATORS Summary of this class goes here
    % contains all indicators for forces, torques and line loads
    
    properties
        Forces      % vector of type Indicator (each element contains an force-indicator)
        Torques     % vector of type Indicator (each element contains an torque-indicator)
        LineLoads   % vector of type Indicator (each element contains an line load-indicator)
    end
    
    methods
        function obj = IndicatorTypes(forces, torques, lineLoad)
            % INDICATORS Construct an instance of this class
            obj.Forces = forces;
            obj.Torques = torques;
            obj.LineLoads = lineLoad;
        end
    end
end

