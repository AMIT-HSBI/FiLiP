within PNlib.PN.Examples.DisTest;

model TFDoutputConflict
  extends Modelica.Icons.Example;
  inner PNlib.PN.Components.Settings settings annotation(
    Placement(visible = true, transformation(extent = {{40, 20}, {60, 40}}, rotation = 0)));
  PNlib.PN.Components.PD P1(enablingType = PNlib.Types.EnablingType.Probability, localSeedIn = 1, localSeedOut = 2,nInDis = 1, nOutDis = 2) annotation(
    Placement(visible = true, transformation(extent = {{-40, 2}, {-20, 22}}, rotation = 0)));
  PNlib.PN.Components.PD P2(localSeedIn = 3, localSeedOut = 4, nInDis = 1) annotation(
    Placement(visible = true, transformation(origin = {30, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T1(nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.FireDuration) annotation(
    Placement(visible = true, transformation(origin = {0, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T3(nOutDis = 1)  annotation(
    Placement(visible = true, transformation(origin = {-54, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T2(nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.FireDuration)  annotation(
    Placement(visible = true, transformation(origin = {0, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P3(localSeedIn = 5, localSeedOut = 6, nInDis = 1)  annotation(
    Placement(visible = true, transformation(origin = {30, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(T2.outPlacesDis[1], P3.inTransitionDis[1]) annotation(
    Line(points = {{4.8, -22}, {18.8, -22}}));
  connect(T2.inPlacesDis[1], P1.outTransitionDis[2]) annotation(
    Line(points = {{-5, -20}, {-14.6, -20}, {-14.6, 12}, {-18.8, 12}}));
  connect(T1.outPlacesDis[1], P2.inTransitionDis[1]) annotation(
    Line(points = {{4.8, 12}, {18.8, 12}}));
  connect(P1.outTransitionDis[1], T1.inPlacesDis[1]) annotation(
    Line(points = {{-19.2, 12}, {-5, 12}}));
  connect(T3.outPlacesDis[1], P1.inTransitionDis[1]) annotation(
    Line(points = {{-49.2, 12}, {-40.2, 12}}));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-60, -40}, {60, 40}}), graphics),
    experiment(StartTime = 0.0, StopTime = 10.0, Tolerance = 1e-6));
end TFDoutputConflict;
