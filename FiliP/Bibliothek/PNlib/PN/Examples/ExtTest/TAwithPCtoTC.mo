within PNlib.PN.Examples.ExtTest;
model TAwithPCtoTC
   extends Modelica.Icons.Example;
  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent={{-60, 40}, {-40, 60}})));
  PNlib.PN.Components.EA EA1(Arc = PNlib.Types.ArcType.RealTestArc, testValue = 3) annotation(Placement(visible = true, transformation(extent = {{-20, 24}, {-6, 30}}, rotation = 0)));
  PNlib.PN.Components.PC P1(nOutCon = 1, nOutExt = 1, startTokens=5) annotation(Placement(transformation(extent={{-54, -10}, {-34, 10}})));
  PNlib.PN.Components.PC P2(nInCon=1) annotation(Placement(visible = true, transformation(extent = {{30, -36}, {50, -16}}, rotation = 0)));
  PNlib.PN.Components.PC P3(nInCon=1) annotation(Placement(visible = true, transformation(extent = {{30, 8}, {50, 28}}, rotation = 0)));
  PNlib.PN.Components.TC T1(nInCon=1, nOutCon=1) annotation(Placement(visible = true, transformation(extent = {{6, -36}, {26, -16}}, rotation = 0)));
  PNlib.PN.Components.TC T2(nInExt = 1, nOutCon=1) annotation(Placement(visible = true, transformation(extent = {{6, 8}, {26, 28}}, rotation = 0)));
equation
  connect(T1.outPlacesCon[1], P2.inTransitionCon[1]) annotation(
    Line(points = {{20, -26}, {28, -26}, {28, -26}, {30, -26}}, thickness = 0.5));
  connect(P1.outTransitionCon[1], T1.inPlacesCon[1]) annotation(
    Line(points = {{-34, 0}, {-14, 0}, {-14, -26}, {10, -26}, {10, -26}, {12, -26}}, thickness = 0.5));
  connect(P1.extOut[1], EA1.inExt) annotation(
    Line(points = {{-36, 8}, {-36, 8}, {-36, 28}, {-22, 28}, {-22, 28}}, thickness = 0.5));
  connect(T2.outPlacesCon[1], P3.inTransitionCon[1]) annotation(
    Line(points = {{20, 18}, {28, 18}, {28, 18}, {30, 18}}, thickness = 0.5));
  connect(EA1.outExt, T2.extIn[1]) annotation(
    Line(points = {{-6, 28}, {10, 28}, {10, 28}, {12, 28}}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60, -60}, {60, 60}}), graphics), experiment(StartTime=0.0, StopTime=10.0, Tolerance = 1e-6));
end TAwithPCtoTC;
