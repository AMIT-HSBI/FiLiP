within PNlib.PN.Examples.ExtTest;
model TAwithWeaklyActivation
  extends Modelica.Icons.Example;
  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent={{-80, 60}, {-60, 80}})));
  PNlib.PN.Components.PC P1(nInCon=1, nOutCon=2, nOutExt = 1, startTokens=4) annotation(Placement(transformation(extent={{-40, 30}, {-20, 50}})));
  PNlib.PN.Components.PC P2(nInCon=1, maxTokens=3) annotation(Placement(visible = true, transformation(extent = {{50, 48}, {70, 68}}, rotation = 0)));
  PNlib.PN.Components.EA EA1(testValue=5) annotation(Placement(visible = true, transformation(origin = {9, 68}, extent = {{-7, -2}, {7, 2}}, rotation = 0)));
  PNlib.PN.Components.TC T1(nOutCon=1, maximumSpeed=if time > 2 then 2 else 1) annotation(Placement(transformation(extent={{-70, 30}, {-50, 50}})));
  PNlib.PN.Components.TC T2( nInCon=1, nInExt = 1,nOutCon=1) annotation(Placement(visible = true, transformation(extent = {{20, 48}, {40, 68}}, rotation = 0)));
  PNlib.PN.Components.TC T3(nInCon=1, maximumSpeed=if time > 3 then 2 else 0) annotation(Placement(visible = true, transformation(extent = {{20, 12}, {40, 32}}, rotation = 0)));
equation
  connect(P1.outTransitionCon[1], T3.inPlacesCon[1]) annotation(
    Line(points = {{-20, 40}, {0, 40}, {0, 20}, {25, 20}}, thickness = 0.5));
  connect(T2.outPlacesCon[1], P2.inTransitionCon[1]) annotation(
    Line(points = {{34, 58}, {48, 58}, {48, 58}, {50, 58}}, thickness = 0.5));
  connect(P1.outTransitionCon[2], T2.inPlacesCon[1]) annotation(
    Line(points = {{-20, 40}, {0, 40}, {0, 58}, {26, 58}, {26, 58}}, thickness = 0.5));
  connect(EA1.outExt, T2.extIn[1]) annotation(
    Line(points = {{16, 68}, {24, 68}, {24, 68}, {26, 68}}));
  connect(P1.extOut[1], EA1.inExt) annotation(
    Line(points = {{-22, 48}, {-22, 48}, {-22, 68}, {0, 68}, {0, 68}}, thickness = 0.5));
  connect(T1.outPlacesCon[1], P1.inTransitionCon[1]) annotation(
    Line(points = {{-56, 40}, {-40, 40}, {-40, 40}, {-40, 40}}, thickness = 0.5));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-80, 0}, {80, 80}})), experiment(StartTime=0.0, StopTime=5.0, Tolerance = 1e-6));
end TAwithWeaklyActivation;
