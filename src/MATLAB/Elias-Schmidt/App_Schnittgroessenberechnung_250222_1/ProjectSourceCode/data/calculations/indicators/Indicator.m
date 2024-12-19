classdef Indicator
    % INDICATOR Summary of this class goes here
    % contains all relevant information for one indicator
    
    properties
        SingleIndicator     % coordinates of the indicator
        IndicatorLabel      % name of the indicator
        IndicatorLabelPos   % coordinates of the indicator label
    end
    
    methods
        function obj = Indicator(pos, yUpperLim, yLowerLim, name)
            % INDICATOR Construct an instance of this class
                       
            if nargin == 1
                yUpperLim = nan;
                yLowerLim = nan;
                name = "false";
            end
            
            if yUpperLim==0 && yLowerLim==0
                name = "";
            end

            obj.SingleIndicator = [pos, pos;
                             yUpperLim, yLowerLim];
                         
            obj.IndicatorLabel = name;
            obj.IndicatorLabelPos = [pos, yUpperLim];
        end
    end
end

