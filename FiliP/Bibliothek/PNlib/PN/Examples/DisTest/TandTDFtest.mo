within PNlib.PN.Examples.DisTest;
model TandTDFtest
  extends Modelica.Icons.Example;
  inner PNlib.PN.Components.Settings settings annotation(Placement(visible = true, transformation(extent = {{-80, 20}, {-60, 40}}, rotation = 0)));
  PNlib.PN.Components.PD P1(nInDis = 1,nOutDis = 1) annotation(Placement(visible = true, transformation(extent = {{-46, -12}, {-26, 8}}, rotation = 0)));
  PNlib.PN.Components.TD T2( nOutDis = 1, timeType = PNlib.Types.TimeType.Event,timeValue = {1, 2, 3, 4})  annotation(
    Placement(visible = true, transformation(origin = {-62, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P2(nInDis = 1, nOutDis = 2)  annotation(
    Placement(visible = true, transformation(origin = {12, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T1(arcWeightInDis = {2}, arcWeightOutDis = {3}, nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.Immediate, timeValue = {0})  annotation(
    Placement(visible = true, transformation(origin = {-12, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T3(arcWeightInDis = {2}, arcWeightOutDis = {2}, nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.FireDuration, timeValue = {0.5})  annotation(
    Placement(visible = true, transformation(origin = {40, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P3(nInDis = 1)  annotation(
    Placement(visible = true, transformation(origin = {64, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T4(arcWeightInDis = {2}, arcWeightOutDis = {2}, nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.Immediate, timeValue = {0})  annotation(
    Placement(visible = true, transformation(origin = {42, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P4(nInDis = 1)  annotation(
    Placement(visible = true, transformation(origin = {66, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(T4.inPlacesDis[1], P2.outTransitionDis[2]) annotation(
    Line(points = {{38, -22}, {30, -22}, {30, -2}, {22, -2}, {22, -2}}, thickness = 0.5));
  connect(T4.outPlacesDis[1], P4.inTransitionDis[1]) annotation(
    Line(points = {{47, -22}, {56, -22}}, thickness = 0.5));
  connect(T3.outPlacesDis[1], P3.inTransitionDis[1]) annotation(
    Line(points = {{44.8, 22}, {54.8, 22}, {54.8, 22}, {54.8, 22}}, thickness = 0.5));
  connect(T3.inPlacesDis[1], P2.outTransitionDis[1]) annotation(
    Line(points = {{35, 20}, {29, 20}, {29, -2}, {22, -2}}, thickness = 0.5));
  connect(T1.outPlacesDis[1], P2.inTransitionDis[1]) annotation(
    Line(points = {{-7, -2}, {-1, -2}}, thickness = 0.5));
  connect(P1.outTransitionDis[1], T1.inPlacesDis[1]) annotation(
    Line(points = {{-25, -2}, {-15, -2}}, thickness = 0.5));
  connect(T2.outPlacesDis[1], P1.inTransitionDis[1]) annotation(
    Line(points = {{-57.2, -2}, {-45, -2}}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent={{-80, -40},
            {80, 40}}), graphics), experiment(StartTime=0.0, StopTime=5.0, Tolerance = 1e-6));
end TandTDFtest;
