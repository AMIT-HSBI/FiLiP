within PNlib.PN.Examples.HybTest;
model InputConflictProb
extends Modelica.Icons.Example;
  PNlib.PN.Components.PC P1(enablingType = PNlib.Types.EnablingType.Probability, localSeedIn = 1, localSeedOut = 2, maxTokens=2,nInDis = 2, nOutDis = 1) annotation(Placement(transformation(extent = {{10, -10}, {30, 10}})));
  PNlib.PN.Components.TD T1(nInCon = 1) annotation(Placement(transformation(extent = {{40, -10}, {60, 10}})));
  PNlib.PN.Components.TD T2(nInDis = 1, nOutCon = 1) annotation(Placement(transformation(extent = {{-20, 10}, {0, 30}})));
  PNlib.PN.Components.TD T3(nInDis = 1, nOutCon = 1) annotation(Placement(transformation(extent = {{-20, -30}, {0, -10}})));
  PNlib.PN.Components.PD P2(startTokens = 5, nOutDis = 1) annotation(Placement(transformation(extent = {{-50, 10}, {-30, 30}})));
  PNlib.PN.Components.PD P3(startTokens = 5, nOutDis = 1) annotation(Placement(transformation(extent = {{-50, -30}, {-30, -10}})));
  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent = {{40, 20}, {60, 40}})));
equation
  connect(P1.outTransitionDis[1], T1.inPlacesCon[1]) annotation(
    Line(points = {{28, -8}, {46, -8}, {46, -8}, {46, -8}}, thickness = 0.5));
  connect(T3.outPlacesCon[1], P1.inTransitionDis[2]) annotation(
    Line(points = {{-6, -28}, {2, -28}, {2, -8}, {12, -8}, {12, -8}}, thickness = 0.5));
  connect(T2.outPlacesCon[1], P1.inTransitionDis[1]) annotation(
    Line(points = {{-6, 12}, {2, 12}, {2, -8}, {12, -8}, {12, -8}}, thickness = 0.5));
  connect(P3.outTransitionDis[1], T3.inPlacesDis[1]) annotation(
    Line(points = {{-30, -20}, {-16, -20}, {-16, -20}, {-14, -20}}, thickness = 0.5));
  connect(P2.outTransitionDis[1], T2.inPlacesDis[1]) annotation(
    Line(points = {{-30, 20}, {-14, 20}, {-14, 20}, {-14, 20}}, thickness = 0.5));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-60, -40}, {60, 40}}), graphics), experiment(StartTime = 0.0, StopTime = 10.0, Tolerance = 1e-6));
end InputConflictProb;
