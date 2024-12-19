classdef Torque
    % TORQUE Summary:
    % contains all relevant information of one single torque
    
    properties
        Name
        Value
        Direction
        Position
    end
    
    methods
        function obj = Torque(name, value, direction, position)
            % TORQUE Construct an instance of this class
            obj.Name = name;
            obj.Value = value;
            obj.Direction = direction;
            obj.Position = position;
        end
    end
end

