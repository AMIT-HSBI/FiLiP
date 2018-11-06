within PNlib.PN.Examples.HybTest;

model HybLoopAndArcweight
  extends Modelica.Icons.Example;
  PNlib.PN.Components.PC P1(nOutDis = 1, nInDis = 1, startTokens=2) annotation(Placement(transformation(extent = {{-10, -30}, {10, -10}})));
  PNlib.PN.Components.TD T1(nInCon = 1, nOutCon = 1, arcWeightInCon={1.5}, arcWeightOutCon={2.5}) annotation(Placement(transformation(extent = {{8, 10}, {-12, 30}})));
  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent = {{20, 40}, {40, 60}})));
equation
  connect(T1.outPlacesCon[1], P1.inTransitionDis[1]) annotation(
    Line(points = {{-6, 12}, {-18, 12}, {-18, -28}, {-8, -28}, {-8, -28}, {-8, -28}}, thickness = 0.5));
  connect(P1.outTransitionDis[1], T1.inPlacesCon[1]) annotation(
    Line(points = {{8, -28}, {20, -28}, {20, 12}, {2, 12}, {2, 12}}, thickness = 0.5));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-40, -40}, {40, 60}}), graphics), experiment(StartTime = 0.0, StopTime = 10.0, Tolerance = 1e-6));
end HybLoopAndArcweight;
