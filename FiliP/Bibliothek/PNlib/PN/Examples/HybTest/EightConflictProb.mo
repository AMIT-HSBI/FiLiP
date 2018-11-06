within PNlib.PN.Examples.HybTest;
model EightConflictProb
  extends Modelica.Icons.Example;
  PNlib.PN.Components.PC P1(enablingType = PNlib.Types.EnablingType.Probability, nOutDis = 8, startTokens=1,
    localSeedIn=1,
    localSeedOut=2)                                     annotation(Placement(transformation(extent = {{-50, -10}, {-30, 10}})));
  PNlib.PN.Components.TD T1(nInCon = 1) annotation(Placement(transformation(extent = {{-20, 30}, {0, 50}})));
  PNlib.PN.Components.TD T2(nInCon = 1) annotation(Placement(transformation(extent = {{0, 10}, {20, 30}})));
  PNlib.PN.Components.TD T3(nInCon = 1) annotation(Placement(transformation(extent = {{20, 20}, {40, 40}})));
  PNlib.PN.Components.TD T4(nInCon = 1) annotation(Placement(transformation(extent = {{40, 10}, {60, 30}})));
  PNlib.PN.Components.TD T5(nInCon = 1) annotation(Placement(visible = true, transformation(extent = {{40, -32}, {60, -12}}, rotation = 0)));
  PNlib.PN.Components.TD T6(nInCon = 1) annotation(Placement(visible = true, transformation(extent = {{-20, -52}, {0, -32}}, rotation = 0)));
  PNlib.PN.Components.TD T7(nInCon = 1) annotation(Placement(visible = true, transformation(extent = {{20, -42}, {40, -22}}, rotation = 0)));
  PNlib.PN.Components.TD T8(nInCon = 1) annotation(Placement(visible = true, transformation(extent = {{0, -32}, {20, -12}}, rotation = 0)));
  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent = {{-60, 40}, {-40, 60}})));
equation
  connect(P1.outTransitionDis[8], T6.inPlacesCon[1]) annotation(
    Line(points = {{-32, -8}, {-22, -8}, {-22, -50}, {-14, -50}, {-14, -50}}, thickness = 0.5));
  connect(P1.outTransitionDis[7], T8.inPlacesCon[1]) annotation(
    Line(points = {{-32, -8}, {0, -8}, {0, -30}, {6, -30}, {6, -30}}, thickness = 0.5));
  connect(P1.outTransitionDis[6], T7.inPlacesCon[1]) annotation(
    Line(points = {{-32, -8}, {20, -8}, {20, -42}, {26, -42}, {26, -40}}, thickness = 0.5));
  connect(P1.outTransitionDis[5], T5.inPlacesCon[1]) annotation(
    Line(points = {{-32, -8}, {40, -8}, {40, -32}, {46, -32}, {46, -30}}, thickness = 0.5));
  connect(P1.outTransitionDis[4], T4.inPlacesCon[1]) annotation(
    Line(points = {{-32, -8}, {40, -8}, {40, 10}, {46, 10}, {46, 12}}, thickness = 0.5));
  connect(P1.outTransitionDis[3], T3.inPlacesCon[1]) annotation(
    Line(points = {{-32, -8}, {18, -8}, {18, -8}, {20, -8}, {20, 22}, {26, 22}, {26, 22}}, thickness = 0.5));
  connect(P1.outTransitionDis[2], T2.inPlacesCon[1]) annotation(
    Line(points = {{-32, -8}, {0, -8}, {0, 12}, {6, 12}, {6, 12}}, thickness = 0.5));
  connect(P1.outTransitionDis[1], T1.inPlacesCon[1]) annotation(
    Line(points = {{-32, -8}, {-22, -8}, {-22, 32}, {-14, 32}, {-14, 32}}, thickness = 0.5));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-60, -60}, {60, 60}}), graphics), experiment(StartTime = 0.0, StopTime = 10.0, Tolerance = 1e-6));
end EightConflictProb;
