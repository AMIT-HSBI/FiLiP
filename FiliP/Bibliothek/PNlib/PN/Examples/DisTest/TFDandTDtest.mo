within PNlib.PN.Examples.DisTest;
model TFDandTDtest
  extends Modelica.Icons.Example;
  inner PNlib.PN.Components.Settings settings annotation(Placement(visible = true, transformation(extent = {{-80, 20}, {-60, 40}}, rotation = 0)));
  PNlib.PN.Components.TD T2( arcWeightOutDis = {3},nOutDis = 1, timeType = PNlib.Types.TimeType.Event, timeValue = {1, 3})  annotation(
    Placement(visible = true, transformation(origin = {-62, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P2(nInDis = 1, nOutDis = 2)  annotation(
    Placement(visible = true, transformation(origin = {-38, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T3(arcWeightInDis = {2}, arcWeightOutDis = {2}, nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.Delay, timeValue = {0})  annotation(
    Placement(visible = true, transformation(origin = {-10, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P3(nInDis = 1)  annotation(
    Placement(visible = true, transformation(origin = {14, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T4(arcWeightInDis = {2}, arcWeightOutDis = {2}, nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.FireDuration, timeValue = {1})  annotation(
    Placement(visible = true, transformation(origin = {-8, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P4(nInDis = 1)  annotation(
    Placement(visible = true, transformation(origin = {16, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(T4.outPlacesDis[1], P4.inTransitionDis[1]) annotation(
    Line(points = {{-3.2, -22}, {5.8, -22}}, thickness = 0.5));
  connect(T4.inPlacesDis[1], P2.outTransitionDis[2]) annotation(
    Line(points = {{-12.8, -22}, {-20.8, -22}, {-20.8, -2}, {-28.8, -2}, {-28.8, -2}}, thickness = 0.5));
  connect(T3.outPlacesDis[1], P3.inTransitionDis[1]) annotation(
    Line(points = {{-5.2, 22}, {4.8, 22}, {4.8, 22}, {4.8, 22}}, thickness = 0.5));
  connect(T3.inPlacesDis[1], P2.outTransitionDis[1]) annotation(
    Line(points = {{-16.8, 22}, {-22.8, 22}, {-22.8, 0}, {-29.8, 0}}, thickness = 0.5));
  connect(T2.outPlacesDis[1], P2.inTransitionDis[1]) annotation(
    Line(points = {{-58, -2}, {-51, -2}}, thickness = 0.5));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent={{-80, -40},
            {40, 40}}), graphics), experiment(StartTime=0.0, StopTime=5.0, Tolerance = 1e-6));
end TFDandTDtest;
