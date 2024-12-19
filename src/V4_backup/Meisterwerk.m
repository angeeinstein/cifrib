            global results;
            app.MomentEditField.Value = eval(subs(results.Mb,x,app.PositionEditField.Value));
            app.ZForceEditField.Value = eval(subs(results.Fz,x,app.PositionEditField.Value));
            app.XForceEditField.Value = eval(subs(results.Fx,x,app.PositionEditField.Value));