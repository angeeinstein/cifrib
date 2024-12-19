classdef Kraefteverlauf_skript < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure           matlab.ui.Figure
        KrfteverlaufPanel  matlab.ui.container.Panel
        UITable3           matlab.ui.control.Table
        UITable2           matlab.ui.control.Table
        UITable            matlab.ui.control.Table
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 901 528];
            app.UIFigure.Name = 'MATLAB App';

            % Create KrfteverlaufPanel
            app.KrfteverlaufPanel = uipanel(app.UIFigure);
            app.KrfteverlaufPanel.TitlePosition = 'centertop';
            app.KrfteverlaufPanel.Title = 'Kräfteverlauf';
            app.KrfteverlaufPanel.FontWeight = 'bold';
            app.KrfteverlaufPanel.FontSize = 14;
            app.KrfteverlaufPanel.Position = [1 2 901 528];

            % Create UITable
            app.UITable = uitable(app.KrfteverlaufPanel);
            app.UITable.ColumnName = {'Normalkraftverlauf'};
            app.UITable.RowName = {};
            app.UITable.Position = [1 256 385 238];

            % Create UITable2
            app.UITable2 = uitable(app.KrfteverlaufPanel);
            app.UITable2.ColumnName = {'Biegemomentenverlauf'};
            app.UITable2.RowName = {};
            app.UITable2.Position = [249 0 385 256];

            % Create UITable3
            app.UITable3 = uitable(app.KrfteverlaufPanel);
            app.UITable3.ColumnName = {'Querkraftverlauf'};
            app.UITable3.RowName = {};
            app.UITable3.Position = [520 256 385 238];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Kraefteverlauf_skript

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end