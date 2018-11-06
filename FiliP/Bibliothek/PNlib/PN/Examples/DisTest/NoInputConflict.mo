within PNlib.PN.Examples.DisTest;
model NoInputConflict
  extends Modelica.Icons.Example;
  PNlib.PN.Components.TD T1(nOutDis = 1) annotation(Placement(visible = true, transformation(extent = {{-30, 10}, {-10, 30}}, rotation = 0)));
  PNlib.PN.Components.TD T2(nOutDis = 1, timeValue = {2}) annotation(Placement(visible = true, transformation(extent = {{-30, -30}, {-10, -10}}, rotation = 0)));
  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent={{-60, 20},
            {-40, 40}})));
  PNlib.PN.Components.PD P1(enablingPrioIn = {2, 1}, maxTokens = 1, nInDis = 2)  annotation(
    Placement(visible = true, transformation(origin = {16, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(T1.outPlacesDis[1], P1.inTransitionDis[1]) annotation(
    Line(points = {{-15.2, 20}, {-5.2, 20}, {-5.2, 2}, {6.8, 2}, {6.8, 2}}));
  connect(T2.outPlacesDis[1], P1.inTransitionDis[2]) annotation(
    Line(points = {{-15.2, -20}, {-5.2, -20}, {-5.2, 2}, {5.8, 2}}));
  annotation(experiment(StartTime=0.0, StopTime=3.0, Tolerance = 1e-6),
    Diagram(coordinateSystem(extent={{-60, -40}, {60, 40}})));
end NoInputConflict;
