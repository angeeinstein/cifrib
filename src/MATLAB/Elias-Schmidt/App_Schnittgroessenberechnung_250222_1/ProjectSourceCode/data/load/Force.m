classdef Force
    % FORCE Summary:
    % contains all relevant information of one single force
    
    properties
        Name
        Value
        Position
        Angle
    end
    
    methods  
        function obj = Force(name, value, position, angle)
            % FORCE Construct an instance of this class
            obj.Name = name;
            obj.Value = value;
            obj.Position = position;
            obj.Angle = angle;
        end
    end
end

