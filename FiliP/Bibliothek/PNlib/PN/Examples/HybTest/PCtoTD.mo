within PNlib.PN.Examples.HybTest;

model PCtoTD
  extends Modelica.Icons.Example;
  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent = {{20, 20}, {40, 40}})));
  PNlib.PN.Components.PC P1(nOutDis = 1, startTokens = 8) annotation(Placement(transformation(extent = {{-30, -10}, {-10, 10}})));
  PNlib.PN.Components.TD T1(nInCon = 1) annotation(Placement(transformation(extent = {{10, -10}, {30, 10}})));
equation
  connect(P1.outTransitionDis[1], T1.inPlacesCon[1]) annotation(
    Line(points = {{-12, -8}, {16, -8}, {16, -8}, {16, -8}}, thickness = 0.5));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-40, -40}, {40, 40}}), graphics), experiment(StartTime = 0.0, StopTime = 10.0, Tolerance = 1e-6));
end PCtoTD;
