classdef LineLoad
    % LINELOAD Summary:
    % contains all relevant information of one single line load
    
    properties
        Name
        Equation
        StartPoint
        EndPoint
    end
    
    methods
        function obj = LineLoad(name, equation, startPoint, endPoint)
            % LINELOADS Construct an instance of this class
            obj.Name = name;
            obj.Equation = equation;
            obj.StartPoint = startPoint;
            obj.EndPoint = endPoint;
        end
    end
end

