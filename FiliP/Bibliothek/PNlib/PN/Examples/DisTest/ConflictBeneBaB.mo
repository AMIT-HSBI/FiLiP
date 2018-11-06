within PNlib.PN.Examples.DisTest;
model ConflictBeneBaB
  extends Modelica.Icons.Example;
  PNlib.PN.Components.PD P1(nInDis = 1) annotation(Placement(visible = true, transformation(extent = {{30, 70}, {50, 90}}, rotation = 0)));
  PNlib.PN.Components.TD T1(arcWeightInDis = {4},nInDis = 1, nOutDis = 1) annotation(Placement(visible = true, transformation(extent = {{-6, 70}, {14, 90}}, rotation = 0)));
  PNlib.PN.Components.TD T2(arcWeightInDis = {3},nInDis = 1, nOutDis = 1) annotation(Placement(visible = true, transformation(extent = {{-6, 30}, {14, 50}}, rotation = 0)));
  PNlib.PN.Components.PD P2(nInDis = 1) annotation(Placement(visible = true, transformation(extent = {{30, 30}, {50, 50}}, rotation = 0)));
  PNlib.PN.Components.PD P3(nInDis = 1) annotation(Placement(visible = true, transformation(extent = {{30, -10}, {50, 10}}, rotation = 0)));
  inner PNlib.PN.Components.Settings settings annotation(Placement(visible = true, transformation(extent = {{-60, 80}, {-40, 100}}, rotation = 0)));
  PNlib.PN.Components.TD T3(arcWeightInDis = {1},nInDis = 1, nOutDis = 1)  annotation(
    Placement(visible = true, transformation(origin = {4, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T4(arcWeightInDis = {1},nInDis = 1, nOutDis = 1)  annotation(
    Placement(visible = true, transformation(origin = {4, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T5(arcWeightInDis = {1},nInDis = 1, nOutDis = 1)  annotation(
    Placement(visible = true, transformation(origin = {4, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P4(nInDis = 1)  annotation(
    Placement(visible = true, transformation(origin = {40, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P5(maxTokens = 1, nInDis = 1, nOutDis = 1, startTokens = 1)  annotation(
    Placement(visible = true, transformation(origin = {40, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P7(benefitType = PNlib.Types.BenefitType.BranchAndBound, enablingBeneOut = {6, 5, 3, 4, 2, 0}, enablingType = PNlib.Types.EnablingType.Benefit, nInDis = 1, nOutDis = 6, startTokens = 4)  annotation(
    Placement(visible = true, transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T7(arcWeightOutDis = {4}, nInDis = 1, nOutDis = 1, timeValue = {2})  annotation(
    Placement(visible = true, transformation(origin = {-40, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.PN.Components.TD T6(arcWeightInDis = {1},nInDis = 1, nOutDis = 1)  annotation(
    Placement(visible = true, transformation(origin = {4, -120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P6(nInDis = 1)  annotation(
    Placement(visible = true, transformation(origin = {40, -120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(T6.inPlacesDis[1], P7.outTransitionDis[6]) annotation(
    Line(points = {{0, -120}, {-12, -120}, {-12, 0}, {-20, 0}, {-20, 0}}));
  connect(T6.outPlacesDis[1], P6.inTransitionDis[1]) annotation(
    Line(points = {{8, -120}, {28, -120}, {28, -120}, {30, -120}}));
  connect(T4.outPlacesDis[1], P5.inTransitionDis[1]) annotation(
    Line(points = {{8, -80}, {30, -80}, {30, -80}, {30, -80}, {30, -80}}));
  connect(T5.outPlacesDis[1], P4.inTransitionDis[1]) annotation(
    Line(points = {{8, -40}, {28, -40}, {28, -40}, {30, -40}}));
  connect(T3.outPlacesDis[1], P3.inTransitionDis[1]) annotation(
    Line(points = {{8, 0}, {28, 0}, {28, 0}, {30, 0}}));
  connect(T2.outPlacesDis[1], P2.inTransitionDis[1]) annotation(
    Line(points = {{8, 40}, {28, 40}, {28, 40}, {30, 40}}));
  connect(T1.outPlacesDis[1], P1.inTransitionDis[1]) annotation(
    Line(points = {{8, 80}, {30, 80}, {30, 80}, {30, 80}}));
  connect(P7.outTransitionDis[5], T4.inPlacesDis[1]) annotation(
    Line(points = {{-20, 0}, {-12, 0}, {-12, -80}, {0, -80}, {0, -80}}));
  connect(P7.outTransitionDis[4], T5.inPlacesDis[1]) annotation(
    Line(points = {{-20, 0}, {-12, 0}, {-12, -40}, {0, -40}, {0, -40}}));
  connect(P7.outTransitionDis[3], T3.inPlacesDis[1]) annotation(
    Line(points = {{-20, 0}, {0, 0}, {0, 0}, {0, 0}}));
  connect(P7.outTransitionDis[2], T2.inPlacesDis[1]) annotation(
    Line(points = {{-20, 0}, {-12, 0}, {-12, 40}, {-2, 40}, {-2, 40}, {0, 40}}));
  connect(P7.outTransitionDis[1], T1.inPlacesDis[1]) annotation(
    Line(points = {{-20, 0}, {-12, 0}, {-12, 80}, {0, 80}, {0, 80}, {0, 80}}));
  connect(T7.outPlacesDis[1], P7.inTransitionDis[1]) annotation(
    Line(points = {{-40, -56}, {-40, -56}, {-40, 0}, {-40, 0}}));
  connect(T7.inPlacesDis[1], P5.outTransitionDis[1]) annotation(
    Line(points = {{-40, -64}, {-40, -64}, {-40, -96}, {56, -96}, {56, -80}, {50, -80}, {50, -80}}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-60, -140}, {60, 100}}), graphics), experiment(StartTime = 0.0, StopTime = 5.0, Tolerance = 1e-6));
end ConflictBeneBaB;
