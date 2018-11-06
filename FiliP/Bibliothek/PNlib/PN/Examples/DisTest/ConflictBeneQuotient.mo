within PNlib.PN.Examples.DisTest;
model ConflictBeneQuotient
  extends Modelica.Icons.Example;
  PNlib.PN.Components.PD P1(benefitType = PNlib.Types.BenefitType.BenefitQuotient, enablingBeneOut = {10, 7}, enablingType = PNlib.Types.EnablingType.Benefit, nInDis = 1, nOutDis = 2, startTokens = 9) annotation(Placement(transformation(extent = {{-30, -10}, {-10, 10}})));
  PNlib.PN.Components.TD T1(arcWeightInDis = {5},nInDis = 1, nOutDis = 1) annotation(Placement(transformation(extent = {{0, 10}, {20, 30}})));
  PNlib.PN.Components.TD T2(arcWeightInDis = {3},nInDis = 1, nOutDis = 1) annotation(Placement(transformation(extent = {{0, -30}, {20, -10}})));
  PNlib.PN.Components.PD P2(nInDis = 1) annotation(Placement(transformation(extent = {{30, 10}, {50, 30}})));
  PNlib.PN.Components.PD P3(nInDis = 1) annotation(Placement(transformation(extent = {{30, -30}, {50, -10}})));
  PNlib.PN.Components.TD T3(arcWeightOutDis = {4}, nOutDis = 1) annotation(Placement(transformation(extent = {{-60, -10}, {-40, 10}})));
  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent = {{-60, 20}, {-40, 40}})));
equation
  connect(T3.outPlacesDis[1], P1.inTransitionDis[1]) annotation(Line(points = {{-45.2, 0}, {-30.8, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(P1.outTransitionDis[1], T1.inPlacesDis[1]) annotation(Line(points = {{-9.2, -0.5}, {0, -0.5}, {0, 20}, {5.2, 20}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T1.outPlacesDis[1], P2.inTransitionDis[1]) annotation(Line(points = {{14.8, 20}, {29.2, 20}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T2.inPlacesDis[1], P1.outTransitionDis[2]) annotation(Line(points = {{5.2, -20}, {-0.4, -20}, {-0.4, 0.5}, {-9.2, 0.5}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T2.outPlacesDis[1], P3.inTransitionDis[1]) annotation(Line(points = {{14.8, -20}, {29.2, -20}}, color = {0, 0, 0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-60, -40}, {60, 40}}), graphics), experiment(StartTime = 0.0, StopTime = 10.0, Tolerance = 1e-6));
end ConflictBeneQuotient;
