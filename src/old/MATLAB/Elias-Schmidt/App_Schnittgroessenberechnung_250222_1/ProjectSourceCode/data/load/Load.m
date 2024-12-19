classdef Load
    % LOAD Summary:
    %   contains all different types of loads
    %   1. A line vector "forces" of type Force
    %       contains one single force in each element of the vector
    
    %   2. A line vector "torques" of type Torque
    %       contains one single torque in each element of the vector
    
    %   3. A line vector "lineLoads" of type LineLoads
    %       contains one single line load in each element of the vector
    
    properties
        Forces
        Torques
        LineLoads
    end
    
    methods
        function obj = Load(forces, torques, lineLoads)
            % LOAD Construct an instance of this class
            obj.Forces = forces;
            obj.Torques = torques;
            obj.LineLoads = lineLoads;
        end
    end
end

