within PNlib.PN.Examples.DisTest;

model TFDtest
  extends Modelica.Icons.Example;
  inner PNlib.PN.Components.Settings settings annotation(
    Placement(visible = true, transformation(extent = {{20, 20}, {40, 40}}, rotation = 0)));
  PNlib.PN.Components.PD P1(nOutDis = 1, startTokens = 5) annotation(
    Placement(visible = true, transformation(extent = {{-38, -10}, {-18, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P2(nInDis = 1) annotation(
    Placement(visible = true, transformation(origin = {28, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T1(nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.FireDuration) annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(P1.outTransitionDis[1], T1.inPlacesDis[1]) annotation(
    Line(points = {{-17.2, 0}, {-5.2, 0}}));
  connect(T1.outPlacesDis[1], P2.inTransitionDis[1]) annotation(
    Line(points = {{4.8, 0}, {16.8, 0}}));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-40, -40}, {40, 40}}), graphics),
    experiment(StartTime = 0.0, StopTime = 10.0, Tolerance = 1e-6));
end TFDtest;
