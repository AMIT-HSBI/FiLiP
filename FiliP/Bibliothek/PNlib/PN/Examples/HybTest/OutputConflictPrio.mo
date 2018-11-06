within PNlib.PN.Examples.HybTest;

model OutputConflictPrio
  extends Modelica.Icons.Example;
  PNlib.PN.Components.PC P1(nInDis = 1, nOutDis = 2, minTokens=2, startTokens=4) annotation(Placement(transformation(extent = {{-30, -10}, {-10, 10}})));
  PNlib.PN.Components.TD T1(nInCon = 1, nOutDis = 1) annotation(Placement(transformation(extent = {{0, 10}, {20, 30}})));
  PNlib.PN.Components.TD T2(nInCon = 1, nOutDis = 1) annotation(Placement(transformation(extent = {{0, -30}, {20, -10}})));
  PNlib.PN.Components.PD P2(nInDis = 1) annotation(Placement(transformation(extent = {{30, 10}, {50, 30}})));
  PNlib.PN.Components.PD P3(nInDis = 1) annotation(Placement(transformation(extent = {{30, -30}, {50, -10}})));
  PNlib.PN.Components.TD T3(nOutCon = 1) annotation(Placement(transformation(extent = {{-60, -10}, {-40, 10}})));
  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent = {{-60, 20}, {-40, 40}})));
equation
  connect(T2.outPlacesDis[1], P3.inTransitionDis[1]) annotation(
    Line(points = {{14, -20}, {28, -20}, {28, -20}, {30, -20}}, thickness = 0.5));
  connect(T1.outPlacesDis[1], P2.inTransitionDis[1]) annotation(
    Line(points = {{14, 20}, {28, 20}, {28, 20}, {30, 20}}, thickness = 0.5));
  connect(P1.outTransitionDis[2], T2.inPlacesCon[1]) annotation(
    Line(points = {{-12, -8}, {-2, -8}, {-2, -28}, {6, -28}, {6, -28}}, thickness = 0.5));
  connect(P1.outTransitionDis[1], T1.inPlacesCon[1]) annotation(
    Line(points = {{-12, -8}, {-2, -8}, {-2, 12}, {6, 12}, {6, 12}}, thickness = 0.5));
  connect(T3.outPlacesCon[1], P1.inTransitionDis[1]) annotation(
    Line(points = {{-46, -8}, {-28, -8}, {-28, -8}, {-28, -8}}, thickness = 0.5));
  annotation(experiment(StartTime = 0.0, StopTime = 10.0, Tolerance = 1e-6), Diagram(coordinateSystem(extent = {{-60, -40}, {60, 40}})));
end OutputConflictPrio;
