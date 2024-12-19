classdef Indicators
    % INDICATORS Summary of this class goes here
    % contains all indicators for N, Q and Mb
    
    properties
        IndicatorsN     % object of type IndicatorTypes (contains all indicators for N split into forces, torques and line loads)
        IndicatorsQ     % object of type IndicatorTypes (contains all indicators for Q split into forces, torques and line loads)
        IndicatorsMb    % object of type IndicatorTypes (contains all indicators for Mb split into forces, torques and line loads)
    end
    
    methods
        function obj = Indicators(indicatorsN, indicatorsQ, indicatorsMb)
            % INDICATORS Construct an instance of this class
            obj.IndicatorsN = indicatorsN;
            obj.IndicatorsQ = indicatorsQ;
            obj.IndicatorsMb = indicatorsMb;
        end
    end
end

