within PNlib.PN.Examples.DisTest;
model TEtest
  extends Modelica.Icons.Example;
  inner PNlib.PN.Components.Settings settings annotation(Placement(visible = true, transformation(extent = {{60, 20}, {80, 40}}, rotation = 0)));
  PNlib.PN.Components.PD P1(nInDis = 1,nOutDis = 1) annotation(Placement(visible = true, transformation(extent = {{-20, 10}, {0, 30}}, rotation = 0)));
  PNlib.PN.Components.TD T1(nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.Event, timeValue = {1, 2, 3}) annotation(Placement(visible = true, transformation(extent = {{20, 10}, {40, 30}}, rotation = 0)));
  PNlib.PN.Components.TD T2(timeValue = {0.5, 2.5, 2.8}, nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.Event)  annotation(
    Placement(visible = true, transformation(origin = {-54, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P2(nInDis = 1, nOutDis = 1, startTokens = 1)  annotation(
    Placement(visible = true, transformation(origin = {-10, -20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(P2.inTransitionDis[1], T1.outPlacesDis[1]) annotation(
    Line(points = {{1, -20}, {44, -20}, {44, 20}, {34, 20}}));
  connect(P2.outTransitionDis[1], T2.inPlacesDis[1]) annotation(
    Line(points = {{-21, -20}, {-70, -20}, {-70, 20}, {-58, 20}}));
  connect(T1.inPlacesDis[1], P1.outTransitionDis[1]) annotation(
    Line(points = {{25.2, 20}, {0.799999, 20}}));
  connect(T2.outPlacesDis[1], P1.inTransitionDis[1]) annotation(
    Line(points = {{-49.2, 20}, {-19.2, 20}, {-19.2, 20}, {-19.2, 20}}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent={{-80, -40},
            {80, 40}}), graphics), experiment(StartTime=0.0, StopTime=5.0, Tolerance = 1e-6));
end TEtest;
