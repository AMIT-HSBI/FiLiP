within PNlib.PN.Examples.DisTest;
model TFDandTTtest2
extends Modelica.Icons.Example;
  inner PNlib.PN.Components.Settings settings annotation(
    Placement(visible = true, transformation(extent = {{-60, 20}, {-40, 40}}, rotation = 0)));
  Components.PD P1(enablingPrioIn = {2, 1},maxTokens = 1, nInDis = 2) annotation(
    Placement(visible = true, transformation(origin = {42, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T1(nInDis = 1, nOutDis = 1, syncroTact = true, timeType = PNlib.Types.TimeType.Tact, timeValue = {1, 1}) annotation(
    Placement(visible = true, transformation(origin = {8, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T2(nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.FireDuration) annotation(
    Placement(visible = true, transformation(origin = {8, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P2(nOutDis = 1, startTokens = 1) annotation(
    Placement(visible = true, transformation(origin = {-22, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P3(nOutDis = 1, startTokens = 1) annotation(
    Placement(visible = true, transformation(origin = {-22, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(T2.outPlacesDis[1], P1.inTransitionDis[2]) annotation(
    Line(points = {{12, -18}, {22, -18}, {22, -4}, {32, -4}, {32, -4}}, thickness = 0.5));
  connect(T1.outPlacesDis[1], P1.inTransitionDis[1]) annotation(
    Line(points = {{12, 18}, {22, 18}, {22, -4}, {32, -4}, {32, -4}}, thickness = 0.5));
  connect(P3.outTransitionDis[1], T2.inPlacesDis[1]) annotation(
    Line(points = {{-12, -18}, {2, -18}, {2, -18}, {4, -18}}, thickness = 0.5));
  connect(P2.outTransitionDis[1], T1.inPlacesDis[1]) annotation(
    Line(points = {{-12, 18}, {2, 18}, {2, 18}, {4, 18}}, thickness = 0.5));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-60, -40}, {60, 40}}), graphics),
    experiment(StartTime = 0, StopTime = 3, Tolerance = 1e-06));
end TFDandTTtest2;
