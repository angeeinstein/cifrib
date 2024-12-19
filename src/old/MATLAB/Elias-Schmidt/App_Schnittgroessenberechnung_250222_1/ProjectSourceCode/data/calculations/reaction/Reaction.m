classdef Reaction
    % REACTION Summary of this class goes here
    % contains all information regarding the system's reaction
    
    properties
        BearingLoads    % object of type BearingLoads (contains the reacting loads of each bearing)
        Graphs          % object of type Graphs (contains the vector for the distribution graphs of N, Q and Mb)
        MaxLoads        % object of type MaxLoads (contains the maximum values and their positions/intervals for N, Q and Mb)
    end
    
    methods
        function obj = Reaction(bearingLoads, graphs, maxLoads)
            % REACTION Construct an instance of this class
            obj.BearingLoads = bearingLoads;
            obj.Graphs = graphs;
            obj.MaxLoads = maxLoads;
        end
    end
end

