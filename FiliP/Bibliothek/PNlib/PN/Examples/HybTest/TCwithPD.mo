within PNlib.PN.Examples.HybTest;

model TCwithPD
  extends Modelica.Icons.Example;
  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent={{-60,40},{-40,60}})));
  PNlib.PN.Components.PC P1(nOutCon = 1, startTokens = 10) annotation(Placement(transformation(extent={{-50,10},{-30,30}})));
  PNlib.PN.Components.PC P2(nInCon = 1)  annotation(Placement(transformation(extent={{30,10},{50,30}})));
  PNlib.PN.Components.TC T1(nDis = 1, nInCon = 1, nOutCon = 1)  annotation(Placement(transformation(extent={{-10,10},{10,30}})));
  PNlib.PN.Components.PD P3(nCon = 1, startTokens = 10) annotation(Placement(visible = true, transformation(origin = {-40, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(P3.inOutTransitionCon[1], T1.inOutPlacesDis[1]) annotation(
    Line(points = {{-32, -18}, {-14, -18}, {-14, 12}, {-4, 12}, {-4, 12}}, thickness = 0.5));
  connect(T1.outPlacesCon[1], P2.inTransitionCon[1]) annotation(
    Line(points = {{4, 20}, {28, 20}, {28, 20}, {30, 20}}, thickness = 0.5));
  connect(P1.outTransitionCon[1], T1.inPlacesCon[1]) annotation(
    Line(points = {{-30, 20}, {-6, 20}, {-6, 20}, {-4, 20}}, thickness = 0.5));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},{60,60}})), experiment(StartTime = 0.0, StopTime = 10.0, Tolerance = 1e-6));
end TCwithPD;
