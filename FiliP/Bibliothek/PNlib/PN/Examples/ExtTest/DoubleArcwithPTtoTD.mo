within PNlib.PN.Examples.ExtTest;
model DoubleArcwithPTtoTD
  extends Modelica.Icons.Example;
  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent={{-60, 40}, {-40, 60}})));
  PNlib.PN.Components.EA EA1(Arc = PNlib.Types.ArcType.RealInhibitorArc, testValue = 3) annotation(Placement(visible = true, transformation(extent = {{-24, 38}, {-12, 42}}, rotation = 0)));
  PNlib.PN.Components.PD P1(nOutDis = 2,nOutExt =2, startTokens=5) annotation(Placement(transformation(extent={{-54, -8}, {-34, 12}})));
  PNlib.PN.Components.PD P2(nInDis=1) annotation(Placement(transformation(extent={{30, 20}, {50, 40}})));
  PNlib.PN.Components.PD P3(nInDis=1) annotation(Placement(transformation(extent={{30, -38}, {50, -18}})));
  PNlib.PN.Components.EA EA2(testValue=2) annotation(Placement(visible = true, transformation(extent = {{-20, -22}, {-6, -16}}, rotation = 0)));
  PNlib.PN.Components.TD T1( nInDis=1, nInExt = 1,nOutDis=1) annotation(Placement(transformation(extent={{6, 20}, {26, 40}})));
  PNlib.PN.Components.TD T2(nInDis=1, nInExt = 1, nOutDis=1) annotation(Placement(transformation(extent={{6, -38}, {26, -18}})));
equation
  connect(P1.extOut[2], EA2.inExt) annotation(
    Line(points = {{-36, 10}, {-30, 10}, {-30, -18}, {-22, -18}, {-22, -18}}, thickness = 0.5));
  connect(P1.outTransitionDis[2], T2.inPlacesDis[1]) annotation(
    Line(points = {{-34, 2}, {2, 2}, {2, -28}, {12, -28}, {12, -28}}, thickness = 0.5));
  connect(EA1.outExt, T1.extIn[1]) annotation(
    Line(points = {{-10, 38}, {10, 38}, {10, 40}, {12, 40}}));
  connect(P1.extOut[1], EA1.inExt) annotation(
    Line(points = {{-36, 10}, {-30, 10}, {-30, 38}, {-25, 38}}, thickness = 0.5));
  connect(EA2.outExt, T2.extIn[1]) annotation(
    Line(points = {{-6, -18}, {10, -18}, {10, -18}, {12, -18}}));
  connect(T2.outPlacesDis[1], P3.inTransitionDis[1]) annotation(
    Line(points = {{20, -28}, {28, -28}, {28, -28}, {30, -28}}, thickness = 0.5));
  connect(T1.outPlacesDis[1], P2.inTransitionDis[1]) annotation(
    Line(points = {{20, 30}, {30, 30}, {30, 30}, {30, 30}}, thickness = 0.5));
  connect(P1.outTransitionDis[1], T1.inPlacesDis[1]) annotation(
    Line(points = {{-34, 2}, {-6, 2}, {-6, 2}, {2, 2}, {2, 30}, {12, 30}, {12, 30}}, thickness = 0.5));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60, -60}, {60, 60}})), experiment(StartTime=0.0, StopTime=10.0, Tolerance = 1e-6));
end DoubleArcwithPTtoTD;
