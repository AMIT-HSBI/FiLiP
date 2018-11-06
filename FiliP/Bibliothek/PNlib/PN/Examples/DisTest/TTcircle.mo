within PNlib.PN.Examples.DisTest;
model TTcircle
  extends Modelica.Icons.Example;
  inner PNlib.PN.Components.Settings settings annotation(Placement(visible = true, transformation(extent = {{30, 30}, {50, 50}}, rotation = 0)));
  PNlib.PN.Components.PD P1(nInDis = 1,nOutDis = 1, startTokens = 1) annotation(Placement(visible = true, transformation(extent = {{-30, 8}, {-10, 28}}, rotation = 0)));
  PNlib.PN.Components.TD T1(nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.Tact, timeValue = {0, 1})  annotation(Placement(visible = true, transformation(origin = {0, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P2(nInDis = 1, nOutDis = 1)  annotation(Placement(visible = true, transformation(origin = {22, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T2(nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.Tact, timeValue = {1.5, 2})  annotation(Placement(visible = true, transformation(origin = {0, -22}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(T1.outPlacesDis[1], P2.inTransitionDis[1]) annotation(Line(points = {{4.8, 18}, {12.8, 18}, {12.8, 18}, {12.8, 18}}));
  connect(P2.outTransitionDis[1], T2.inPlacesDis[1]) annotation(Line(points = {{33, 18}, {40, 18}, {40, -22}, {4, -22}}));
  connect(P1.outTransitionDis[1], T1.inPlacesDis[1]) annotation(Line(points = {{-9.2, 18}, {-5.2, 18}}));
  connect(T2.outPlacesDis[1], P1.inTransitionDis[1]) annotation(Line(points = {{-4, -22}, {-40, -22}, {-40, 18}, {-31, 18}}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent={{-50, -50},
            {50, 50}}), graphics), experiment(StartTime=0.0, StopTime=10.0, Tolerance = 1e-6));
end TTcircle;
