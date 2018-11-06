within PNlib.PN.Examples.ExtTest;

model NoTokens
  extends Modelica.Icons.Example;
  inner PNlib.PN.Components.Settings settings annotation(
    Placement(visible = true, transformation(extent = {{-100, 60}, {-80, 80}}, rotation = 0)));
  PNlib.PN.Components.PC P1(nOutCon = 1, startTokens = 5) annotation(
    Placement(visible = true, transformation(origin = {-80, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PC P3(nOutCon = 1, startTokens = 5) annotation(
    Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PC P2(nOutCon = 1, nOutExt = 1, startTokens = 5) annotation(
    Placement(visible = true, transformation(origin = {-80, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TC T1(nInCon = 2, nOutCon = 1) annotation(
    Placement(visible = true, transformation(origin = {-16, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TC T2(nInCon = 1, nInExt = 1, nOutCon = 1) annotation(
    Placement(visible = true, transformation(origin = {-16, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PC P4(nInCon = 2) annotation(
    Placement(visible = true, transformation(origin = {40, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.EA ESA1(Arc = PNlib.Types.ArcType.RealInhibitorArc)  annotation(
    Placement(visible = true, transformation(origin = {-46, 42}, extent = {{-9.8, 0.4}, {2.8, 4.8}}, rotation = 0)));
equation
  connect(P2.outTransitionCon[1], T1.inPlacesCon[2]) annotation(
    Line(points = {{-70, 36}, {-56, 36}, {-56, -26}, {-20, -26}, {-20, -26}}, thickness = 0.5));
  connect(T1.outPlacesCon[1], P4.inTransitionCon[2]) annotation(
    Line(points = {{-12, -26}, {10, -26}, {10, 2}, {30, 2}, {30, 2}}, thickness = 0.5));
  connect(T2.outPlacesCon[1], P4.inTransitionCon[1]) annotation(
    Line(points = {{-12, 14}, {10, 14}, {10, 2}, {30, 2}, {30, 2}}, thickness = 0.5));
  connect(ESA1.outExt, T2.extIn[1]) annotation(
    Line(points = {{-42, 44}, {-36, 44}, {-36, 22}, {-20, 22}, {-20, 24}}));
  connect(P2.extOut[1], ESA1.inExt) annotation(
    Line(points = {{-72, 44}, {-58, 44}, {-58, 42}, {-57, 42}}, thickness = 0.5));
  connect(P3.outTransitionCon[1], T2.inPlacesCon[1]) annotation(
    Line(points = {{-70, 0}, {-36, 0}, {-36, 14}, {-20, 14}, {-20, 14}}, thickness = 0.5));
  connect(P1.outTransitionCon[1], T1.inPlacesCon[1]) annotation(
    Line(points = {{-70, -38}, {-36, -38}, {-36, -26}, {-22, -26}, {-22, -26}, {-20, -26}}, thickness = 0.5));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -80}, {60, 80}})),
    experiment(StartTime = 0, StopTime = 12, Tolerance = 1e-06, Interval = 0.024));
end NoTokens;
