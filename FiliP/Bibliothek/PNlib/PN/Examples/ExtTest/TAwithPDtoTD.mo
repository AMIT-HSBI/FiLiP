within PNlib.PN.Examples.ExtTest;
model TAwithPDtoTD
  extends Modelica.Icons.Example;
  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent={{-60, 40}, {-40, 60}})));
  PNlib.PN.Components.PD P1(nOutDis = 1, nOutExt = 1, startTokens=5) annotation(Placement(transformation(extent={{-52, -10}, {-32, 10}})));
  PNlib.PN.Components.PD P2(nInDis=1) annotation(Placement(visible = true, transformation(extent = {{30, -44}, {50, -24}}, rotation = 0)));
  PNlib.PN.Components.PD P3(nInDis=1) annotation(Placement(visible = true, transformation(extent = {{30, 10}, {50, 30}}, rotation = 0)));
  PNlib.PN.Components.EA EA1(testValue=3) annotation(Placement(visible = true, transformation(extent = {{-18, 26}, {-4, 32}}, rotation = 0)));
  PNlib.PN.Components.TD T1(nInDis=1, nOutDis=1) annotation(Placement(visible = true, transformation(extent = {{6, -44}, {26, -24}}, rotation = 0)));
  PNlib.PN.Components.TD T2(nInExt = 1, nOutDis=1) annotation(Placement(visible = true, transformation(extent = {{6, 10}, {26, 30}}, rotation = 0)));
equation
  connect(P1.outTransitionDis[1], T1.inPlacesDis[1]) annotation(
    Line(points = {{-32, 0}, {-26, 0}, {-26, -34}, {12, -34}, {12, -34}}, thickness = 0.5));
  connect(T2.outPlacesDis[1], P3.inTransitionDis[1]) annotation(
    Line(points = {{20.8, 20}, {28.8, 20}, {28.8, 20}, {30.8, 20}}, thickness = 0.5));
  connect(EA1.outExt, T2.extIn[1]) annotation(
    Line(points = {{-3.27778, 29.6727}, {12.7222, 29.6727}, {12.7222, 29.6727}, {12.7222, 29.6727}}));
  connect(EA1.inExt, P1.extOut[1]) annotation(
    Line(points = {{-19, 28}, {-26.5, 28}, {-26.5, 8}, {-34, 8}}));
  connect(T1.outPlacesDis[1], P2.inTransitionDis[1]) annotation(
    Line(points = {{20.8, -34}, {28.8, -34}, {28.8, -34}, {30.8, -34}}, thickness = 0.5));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60, -60}, {60, 60}}), graphics), experiment(StartTime=0.0, StopTime=10.0, Tolerance = 1e-6));
end TAwithPDtoTD;
