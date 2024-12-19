classdef MaxLoad
    % MAXLOAD Summary of this class goes here
    % contains the maximum load and it's position/interval/intervals
    
    properties
        Value
        Position
    end
    
    methods
        function obj = MaxLoad(value, position)
            %MAXLOAD Construct an instance of this class
            obj.Value = value;
            obj.Position = position;
        end
    end
end

