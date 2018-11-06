within PNlib.PN.Examples.DisTest;

model TFDoutCap
  extends Modelica.Icons.Example;
  inner PNlib.PN.Components.Settings settings annotation(
    Placement(visible = true, transformation(extent = {{40, 20}, {60, 40}}, rotation = 0)));
  PNlib.PN.Components.PD P1(nInDis = 1, nOutDis = 1) annotation(
    Placement(visible = true, transformation(extent = {{-34, -10}, {-14, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P2(maxTokens = 1, nInDis = 1, nOutDis = 1, startTokens = 1) annotation(
    Placement(visible = true, transformation(origin = {22, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T1(nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.FireDuration) annotation(
    Placement(visible = true, transformation(origin = {-2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T2(timeValue = {1, 2.5, 3.8}, nOutDis = 1, timeType = PNlib.Types.TimeType.Event)  annotation(
    Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T3(timeValue = {1.5, 4}, nInDis = 1, timeType = PNlib.Types.TimeType.Event)  annotation(
    Placement(visible = true, transformation(origin = {44, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(T2.outPlacesDis[1], P1.inTransitionDis[1]) annotation(
    Line(points = {{-46, 0}, {-36, 0}, {-36, 0}, {-34, 0}}));
  connect(P1.outTransitionDis[1], T1.inPlacesDis[1]) annotation(
    Line(points = {{-13, 0}, {-7, 0}}));
  connect(T1.outPlacesDis[1], P2.inTransitionDis[1]) annotation(
    Line(points = {{3, 0}, {11, 0}}));
  connect(P2.outTransitionDis[1], T3.inPlacesDis[1]) annotation(
    Line(points = {{32, 0}, {39, 0}}));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-60, -40}, {60, 40}}), graphics),
    experiment(StartTime = 0.0, StopTime = 5.0, Tolerance = 1e-6));
end TFDoutCap;
