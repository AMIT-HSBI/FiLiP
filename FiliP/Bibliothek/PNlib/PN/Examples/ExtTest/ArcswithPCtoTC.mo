within PNlib.PN.Examples.ExtTest;

model ArcswithPCtoTC
  extends Modelica.Icons.Example;
  inner PNlib.PN.Components.Settings settings annotation(
    Placement(visible = true, transformation(extent = {{-60, 80}, {-40, 100}}, rotation = 0)));
  PNlib.PN.Components.PC P1(nOutExt = 1, startTokens = 1)  annotation(
    Placement(visible = true, transformation(origin = {-40, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PC P2(nInCon = 1)  annotation(
    Placement(visible = true, transformation(origin = {40, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PC P3(nOutExt = 1, startTokens = 1)  annotation(
    Placement(visible = true, transformation(origin = {-40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PC P4(nInCon = 1)  annotation(
    Placement(visible = true, transformation(origin = {40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PC P5(nOutExt = 1, startTokens = 1)  annotation(
    Placement(visible = true, transformation(origin = {-40,-20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PC P6(nInCon = 1)  annotation(
    Placement(visible = true, transformation(origin = {40, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PC P7(nOutExt = 1, startTokens = 1)  annotation(
    Placement(visible = true, transformation(origin = {-40, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PC P8(nInCon = 1)  annotation(
    Placement(visible = true, transformation(origin = {40, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TC T1( nInExt = 1, nOutCon = 1)  annotation(
    Placement(visible = true, transformation(origin = {10, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TC T2( nInExt = 1, nOutCon = 1)  annotation(
    Placement(visible = true, transformation(origin = {10, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TC T3( nInExt = 1, nOutCon = 1)  annotation(
    Placement(visible = true, transformation(origin = {10, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TC T4( nInExt = 1, nOutCon = 1)  annotation(
    Placement(visible = true, transformation(origin = {10, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.EA EA1 annotation(
    Placement(visible = true, transformation(origin = {-6, 68}, extent = {{-9.8, 0.4}, {2.8, 4.8}}, rotation = 0)));
  PNlib.PN.Components.EA EA2(Arc = PNlib.Types.ArcType.TestArc)  annotation(
    Placement(visible = true, transformation(origin = {-8, 28}, extent = {{-9.8, 0.4}, {2.8, 4.8}}, rotation = 0)));
  PNlib.PN.Components.EA EA3(Arc = PNlib.Types.ArcType.RealInhibitorArc)  annotation(
    Placement(visible = true, transformation(origin = {-8, -12}, extent = {{-9.8, 0.4}, {2.8, 4.8}}, rotation = 0)));
  PNlib.PN.Components.EA EA4(Arc = PNlib.Types.ArcType.InhibitorArc)  annotation(
    Placement(visible = true, transformation(origin = {-6, -52}, extent = {{-9.8, 0.4}, {2.8, 4.8}}, rotation = 0)));
equation
  connect(T1.outPlacesCon[1], P2.inTransitionCon[1]) annotation(
    Line(points = {{14, 60}, {28, 60}, {28, 60}, {30, 60}}, thickness = 0.5));
  connect(EA1.outExt, T1.extIn[1]) annotation(
    Line(points = {{-2, 70}, {4, 70}, {4, 70}, {6, 70}}));
  connect(P1.extOut[1], EA1.inExt) annotation(
    Line(points = {{-32, 68}, {-32, 68}, {-32, 70}, {-16, 70}, {-16, 70}}, thickness = 0.5));
  connect(T2.outPlacesCon[1], P4.inTransitionCon[1]) annotation(
    Line(points = {{14, 20}, {28, 20}, {28, 20}, {30, 20}}, thickness = 0.5));
  connect(EA2.outExt, T2.extIn[1]) annotation(
    Line(points = {{-4, 30}, {4, 30}, {4, 30}, {6, 30}}));
  connect(P3.extOut[1], EA2.inExt) annotation(
    Line(points = {{-32, 28}, {-32, 28}, {-32, 30}, {-18, 30}, {-18, 30}}, thickness = 0.5));
  connect(T3.outPlacesCon[1], P6.inTransitionCon[1]) annotation(
    Line(points = {{14, -20}, {30, -20}, {30, -20}, {30, -20}}, thickness = 0.5));
  connect(EA3.outExt, T3.extIn[1]) annotation(
    Line(points = {{-4, -10}, {4, -10}, {4, -10}, {6, -10}}));
  connect(P5.extOut[1], EA3.inExt) annotation(
    Line(points = {{-32, -12}, {-32, -12}, {-32, -10}, {-18, -10}, {-18, -10}}, thickness = 0.5));
  connect(T4.outPlacesCon[1], P8.inTransitionCon[1]) annotation(
    Line(points = {{14, -60}, {28, -60}, {28, -60}, {30, -60}}, thickness = 0.5));
  connect(EA4.outExt, T4.extIn[1]) annotation(
    Line(points = {{-2, -50}, {4, -50}, {4, -50}, {6, -50}}));
  connect(P7.extOut[1], EA4.inExt) annotation(
    Line(points = {{-32, -52}, {-32, -52}, {-32, -50}, {-16, -50}, {-16, -50}}, thickness = 0.5));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-60, -80}, {60, 100}})),
    experiment(StartTime = 0.0, StopTime = 1.0, Tolerance = 1e-6));
end ArcswithPCtoTC;
