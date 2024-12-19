classdef Graphs
    % GRAPHS Summary of this class goes here
    % contains the vector for the distribution graphs of N, Q and Mb
    
    properties
        N
        Q
        Mb
    end
    
    methods
        function obj = Graphs(n, q, mb)
            % MAXLOADS Construct an instance of this class
            obj.N = n;
            obj.Q = q;
            obj.Mb = mb;
        end
    end
end

