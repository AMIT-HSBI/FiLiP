within PNlib.PN.Examples.ExtTest;
model TATest
 extends Modelica.Icons.Example;
  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent={{100, 20}, {120, 40}})));
  PNlib.PN.Components.EA EA1(Arc = PNlib.Types.ArcType.RealTestArc, testValue = 1) annotation(Placement(visible = true, transformation(extent = {{-40, 8}, {-26, 12}}, rotation = 0)));
  PNlib.PN.Components.EA EA2(testValue=2) annotation(Placement(visible = true, transformation(origin = {54, 9}, extent = {{-6, -3}, {6, 3}}, rotation = 0)));
  PNlib.PN.Components.PC P1( nInCon=1,nOutCon=2, nOutExt = 1) annotation(Placement(transformation(extent={{-70, -10}, {-50, 10}})));
  PNlib.PN.Components.PC P2(nInCon=1, nOutExt=1) annotation(Placement(transformation(extent={{10, -10}, {30, 10}})));
  PNlib.PN.Components.PC P3(nInCon=1) annotation(Placement(transformation(extent={{90, -10}, {110, 10}})));
  PNlib.PN.Components.TC T1( nInCon=1, nInExt = 1,nOutCon=1) annotation(Placement(transformation(extent={{-20, -10}, {0, 10}})));
  PNlib.PN.Components.TC T2(nOutCon=1, maximumSpeed=1.5) annotation(Placement(transformation(extent={{-100, -10}, {-80, 10}})));
  PNlib.PN.Components.TC T3( arcWeightInCon={ 2}, maximumSpeed= 1,nInCon= 1, nInExt = 1, nOutCon=1) annotation(Placement(transformation(extent={{-10, -10}, {10, 10}}, rotation=0, origin={80, 0})));
equation
  connect(EA1.outExt, T1.extIn[1]) annotation(
    Line(points = {{-26, 10}, {-16, 10}, {-16, 10}, {-14, 10}}));
  connect(EA1.inExt, P1.extOut[1]) annotation(
    Line(points = {{-42, 10}, {-52, 10}, {-52, 8}, {-52, 8}, {-52, 8}}));
  connect(T1.outPlacesCon[1], P2.inTransitionCon[1]) annotation(
    Line(points = {{-6, 0}, {8, 0}, {8, 0}, {10, 0}}, thickness = 0.5));
  connect(T3.outPlacesCon[1], P3.inTransitionCon[1]) annotation(
    Line(points = {{84, 0}, {90, 0}, {90, 0}, {90, 0}}, thickness = 0.5));
  connect(P2.extOut[1], EA2.inExt) annotation(
    Line(points = {{28, 8}, {28, 8}, {28, 10}, {48, 10}, {48, 10}}, thickness = 0.5));
  connect(EA2.outExt, T3.extIn[1]) annotation(
    Line(points = {{62, 10}, {74, 10}, {74, 10}, {76, 10}}));
  connect(P1.outTransitionCon[2], T3.inPlacesCon[1]) annotation(
    Line(points = {{-50, 0}, {-34, 0}, {-34, -24}, {68, -24}, {68, 0}, {76, 0}, {76, 0}}, thickness = 0.5));
  connect(P1.outTransitionCon[1], T1.inPlacesCon[1]) annotation(
    Line(points = {{-50, 0}, {-16, 0}, {-16, 0}, {-14, 0}}, thickness = 0.5));
  connect(T2.outPlacesCon[1], P1.inTransitionCon[1]) annotation(
    Line(points = {{-86, 0}, {-70, 0}, {-70, 0}, {-70, 0}}, thickness = 0.5));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100, -40}, {120, 40}})), experiment(StartTime=0.0, StopTime=6.0, Tolerance = 1e-6));
end TATest;
