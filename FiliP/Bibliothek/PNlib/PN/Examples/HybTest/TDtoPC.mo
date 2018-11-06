within PNlib.PN.Examples.HybTest;

model TDtoPC
  extends Modelica.Icons.Example;
  PNlib.PN.Components.PC P1(nInDis = 1)  annotation(Placement(visible = true, transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T1(nOutCon = 1)  annotation(Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner PNlib.PN.Components.Settings settings annotation(Placement(visible = true, transformation(origin = {30, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(T1.outPlacesCon[1], P1.inTransitionDis[1]) annotation(
    Line(points = {{-16, -8}, {12, -8}, {12, -8}, {12, -8}}, thickness = 0.5));
  annotation(Diagram(coordinateSystem(extent = {{-40, -40}, {40, 40}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0.0, StopTime = 10.0, Tolerance = 1e-6));
end TDtoPC;
