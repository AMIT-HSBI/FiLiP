within PNlib.PN.Examples.HybTest;

model ConflictType3
  extends Modelica.Icons.Example;
  PNlib.PN.Components.PC P1(nInCon = 1, nOutCon = 1, nOutDis=1, startTokens=2) annotation(Placement(transformation(extent = {{-30, -10}, {-10, 10}})));
  PNlib.PN.Components.TC T1(nInCon = 1, nOutCon = 1, maximumSpeed=2) annotation(Placement(transformation(extent = {{0, 10}, {20, 30}})));
  PNlib.PN.Components.TD T2(nInCon = 1, nOutDis = 1) annotation(Placement(transformation(extent = {{0, -30}, {20, -10}})));
  PNlib.PN.Components.PC P2(nInCon = 1) annotation(Placement(transformation(extent = {{30, 10}, {50, 30}})));
  PNlib.PN.Components.PD P3(nInDis = 1) annotation(Placement(transformation(extent = {{30, -30}, {50, -10}})));
  PNlib.PN.Components.TC T3(nOutCon = 1) annotation(Placement(transformation(extent = {{-60, -10}, {-40, 10}})));
  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent = {{-60, 20}, {-40, 40}})));
equation
  connect(T1.outPlacesCon[1], P2.inTransitionCon[1]) annotation(
    Line(points = {{14, 20}, {30, 20}, {30, 20}, {30, 20}}, thickness = 0.5));
  connect(T2.outPlacesDis[1], P3.inTransitionDis[1]) annotation(
    Line(points = {{14, -20}, {30, -20}, {30, -20}, {30, -20}}, thickness = 0.5));
  connect(T3.outPlacesCon[1], P1.inTransitionCon[1]) annotation(
    Line(points = {{-46, 0}, {-32, 0}, {-32, 0}, {-30, 0}}, thickness = 0.5));
  connect(P1.outTransitionCon[1], T1.inPlacesCon[1]) annotation(
    Line(points = {{-10, 0}, {-2, 0}, {-2, 20}, {6, 20}, {6, 20}}, thickness = 0.5));
  connect(P1.outTransitionDis[1], T2.inPlacesCon[1]) annotation(
    Line(points = {{-12, -8}, {-2, -8}, {-2, -28}, {6, -28}, {6, -28}}, thickness = 0.5));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-60, -40}, {60, 40}}), graphics), experiment(StartTime = 0.0, StopTime = 10.0, Tolerance = 1e-6));
end ConflictType3;
