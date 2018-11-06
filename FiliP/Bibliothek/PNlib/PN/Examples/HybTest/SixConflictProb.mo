within PNlib.PN.Examples.HybTest;
model SixConflictProb
  extends Modelica.Icons.Example;
  PNlib.PN.Components.PC P1(enablingType = PNlib.Types.EnablingType.Probability, nOutDis = 6, startTokens=1,
    localSeedIn=1,
    localSeedOut=2)                                     annotation(Placement(transformation(extent = {{-50, -10}, {-30, 10}})));
  PNlib.PN.Components.TD T1(nInCon = 1) annotation(Placement(transformation(extent = {{-20, 30}, {0, 50}})));
  PNlib.PN.Components.TD T2(nInCon = 1) annotation(Placement(transformation(extent = {{0, 20}, {20, 40}})));
  PNlib.PN.Components.TD T3(nInCon = 1) annotation(Placement(transformation(extent = {{20, 10}, {40, 30}})));
  PNlib.PN.Components.TD T4(nInCon = 1) annotation(Placement(transformation(extent = {{20, -30}, {40, -10}})));
  PNlib.PN.Components.TD T5(nInCon = 1) annotation(Placement(transformation(extent = {{0, -40}, {20, -20}})));
  PNlib.PN.Components.TD T6(nInCon = 1) annotation(Placement(transformation(extent = {{-20, -50}, {0, -30}})));
  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent = {{-60, 40}, {-40, 60}})));
equation
  connect(P1.outTransitionDis[6], T6.inPlacesCon[1]) annotation(
    Line(points = {{-32, -8}, {-24, -8}, {-24, -50}, {-14, -50}, {-14, -48}}, thickness = 0.5));
  connect(P1.outTransitionDis[5], T5.inPlacesCon[1]) annotation(
    Line(points = {{-32, -8}, {0, -8}, {0, -38}, {6, -38}, {6, -38}}, thickness = 0.5));
  connect(P1.outTransitionDis[4], T4.inPlacesCon[1]) annotation(
    Line(points = {{-32, -8}, {20, -8}, {20, -28}, {26, -28}, {26, -28}}, thickness = 0.5));
  connect(P1.outTransitionDis[3], T3.inPlacesCon[1]) annotation(
    Line(points = {{-32, -8}, {20, -8}, {20, 12}, {26, 12}, {26, 12}}, thickness = 0.5));
  connect(P1.outTransitionDis[2], T2.inPlacesCon[1]) annotation(
    Line(points = {{-32, -8}, {-4, -8}, {-4, 22}, {6, 22}, {6, 22}}, thickness = 0.5));
  connect(P1.outTransitionDis[1], T1.inPlacesCon[1]) annotation(
    Line(points = {{-32, -8}, {-24, -8}, {-24, 32}, {-14, 32}, {-14, 32}}, thickness = 0.5));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-60, -60}, {40, 60}}), graphics), experiment(StartTime = 0.0, StopTime = 10.0, Tolerance = 1e-6));
end SixConflictProb;
