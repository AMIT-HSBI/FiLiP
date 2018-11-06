within PNlib.PN.Examples.HybTest;
model InputConflictType3
  extends Modelica.Icons.Example;
  PNlib.PN.Components.PC P1(nInDis = 1, nInCon=1, nOutCon = 1, maxTokens=4) annotation(Placement(transformation(extent={{10, -10}, {30, 10}})));
  PNlib.PN.Components.TC T1(nInCon = 1) annotation(Placement(transformation(extent = {{40, -10}, {60, 10}})));
  PNlib.PN.Components.TD T2(nInDis = 1, nOutCon = 1) annotation(Placement(visible = true, transformation(extent = {{-20, -30}, {0, -10}}, rotation = 0)));
  PNlib.PN.Components.TC T3(nInCon = 1, nOutCon = 1, maximumSpeed=2) annotation(Placement(visible = true, transformation(extent = {{-20, 14}, {0, 34}}, rotation = 0)));
  PNlib.PN.Components.PD P2(startTokens = 5, nOutDis = 1) annotation(Placement(visible = true, transformation(extent = {{-50, -30}, {-30, -10}}, rotation = 0)));
  PNlib.PN.Components.PC P3(nOutCon = 1, startTokens=5) annotation(Placement(visible = true, transformation(extent = {{-50, 14}, {-30, 34}}, rotation = 0)));
  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent = {{40, 20}, {60, 40}})));
equation
  connect(T2.outPlacesCon[1], P1.inTransitionDis[1]) annotation(
    Line(points = {{-5, -31}, {0, -31}, {0, -8}, {12, -8}}, thickness = 0.5));
  connect(P2.outTransitionDis[1], T2.inPlacesDis[1]) annotation(
    Line(points = {{-29.2, -20}, {-15.2, -20}, {-15.2, -20}, {-13.2, -20}}, thickness = 0.5));
  connect(T3.outPlacesCon[1], P1.inTransitionCon[1]) annotation(
    Line(points = {{-5, 26}, {2.5, 26}, {2.5, 0}, {10, 0}}, thickness = 0.5));
  connect(P3.outTransitionCon[1], T3.inPlacesCon[1]) annotation(
    Line(points = {{-29.2, 24}, {-15.2, 24}, {-15.2, 24}, {-13.2, 24}}, thickness = 0.5));
  connect(P1.outTransitionCon[1], T1.inPlacesCon[1]) annotation(
    Line(points = {{30, 0}, {46, 0}, {46, 0}, {46, 0}}, thickness = 0.5));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-60, -40}, {60, 40}}), graphics), experiment(StartTime = 0.0, StopTime = 10.0, Tolerance = 1e-6));
end InputConflictType3;
