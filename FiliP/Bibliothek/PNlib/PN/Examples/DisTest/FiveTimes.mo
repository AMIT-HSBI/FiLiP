within PNlib.PN.Examples.DisTest;
model FiveTimes
  extends Modelica.Icons.Example;
  inner PNlib.PN.Components.Settings settings
    annotation(Placement(visible = true, transformation(extent = {{-60, 80}, {-40, 100}}, rotation = 0)));
  PNlib.PN.Components.PD P1(nInDis = 1, nOutDis = 1, startTokens = 3)  annotation(
    Placement(visible = true, transformation(origin = {-30, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P2(nInDis = 1)  annotation(
    Placement(visible = true, transformation(origin = {30, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P3(nInDis = 1, nOutDis = 1, startTokens = 3)  annotation(
    Placement(visible = true, transformation(origin = {-30, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P4(nInDis = 1)  annotation(
    Placement(visible = true, transformation(origin = {30, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P5( nInDis = 1, nOutDis = 1, startTokens = 3)  annotation(
    Placement(visible = true, transformation(origin = {-30, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P6(nInDis = 1)  annotation(
    Placement(visible = true, transformation(origin = {30, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P7(nInDis = 1, nOutDis = 1, startTokens = 3)  annotation(
    Placement(visible = true, transformation(origin = {-30, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P8(nInDis = 1)  annotation(
    Placement(visible = true, transformation(origin = {30, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T1(nInDis = 1, nOutDis = 1)  annotation(
    Placement(visible = true, transformation(origin = {0, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T2( nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.Event,timeValue = {1, 3, 4, 5, 6, 9})  annotation(
    Placement(visible = true, transformation(origin = {0, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T3(nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.FireDuration)  annotation(
    Placement(visible = true, transformation(origin = {0, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T4(nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.Tact, timeValue = {2,1})  annotation(
    Placement(visible = true, transformation(origin = {0, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T6(arcWeightOutCon = {3}, arcWeightOutDis = {3, 3, 3, 3}, nOutCon = 1, nOutDis = 4, timeType = PNlib.Types.TimeType.Event, timeValue = {5.5})  annotation(
    Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PC P9(nInDis = 1, nOutCon = 1, startTokens = 3)  annotation(
    Placement(visible = true, transformation(origin = {-30, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PC P10(nInCon = 1)  annotation(
    Placement(visible = true, transformation(origin = {30, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TC T5(nInCon = 1, nOutCon = 1)  annotation(
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(P9.inTransitionDis[1], T6.outPlacesCon[1]) annotation(
    Line(points = {{-38, -108}, {-64, -108}, {-64, -8}, {-66, -8}}, thickness = 0.5));
  connect(P9.outTransitionCon[1], T5.inPlacesCon[1]) annotation(
    Line(points = {{-20, -100}, {-6, -100}, {-6, -100}, {-4, -100}}));
  connect(T5.outPlacesCon[1], P10.inTransitionCon[1]) annotation(
    Line(points = {{4, -100}, {20, -100}, {20, -100}, {20, -100}}));
  connect(T4.outPlacesDis[1], P8.inTransitionDis[1]) annotation(
    Line(points = {{4, -60}, {18, -60}, {18, -60}, {20, -60}}));
  connect(P7.outTransitionDis[1], T4.inPlacesDis[1]) annotation(
    Line(points = {{-20, -60}, {-4, -60}, {-4, -60}, {-4, -60}}));
  connect(T6.outPlacesDis[4], P7.inTransitionDis[1]) annotation(
    Line(points = {{-66, 0}, {-52, 0}, {-52, -60}, {-40, -60}, {-40, -60}}));
  connect(T6.outPlacesDis[3], P5.inTransitionDis[1]) annotation(
    Line(points = {{-66, 0}, {-52, 0}, {-52, -20}, {-42, -20}, {-42, -20}, {-40, -20}}));
  connect(T6.outPlacesDis[2], P3.inTransitionDis[1]) annotation(
    Line(points = {{-66, 0}, {-52, 0}, {-52, 20}, {-40, 20}, {-40, 20}}));
  connect(T6.outPlacesDis[1], P1.inTransitionDis[1]) annotation(
    Line(points = {{-66, 0}, {-52, 0}, {-52, 60}, {-40, 60}, {-40, 60}}));
  connect(T3.outPlacesDis[1], P6.inTransitionDis[1]) annotation(
    Line(points = {{4, -20}, {18, -20}, {18, -20}, {20, -20}}));
  connect(P5.outTransitionDis[1], T3.inPlacesDis[1]) annotation(
    Line(points = {{-20, -20}, {-6, -20}, {-6, -20}, {-4, -20}}));
  connect(T2.outPlacesDis[1], P4.inTransitionDis[1]) annotation(
    Line(points = {{4, 20}, {18, 20}, {18, 20}, {20, 20}}));
  connect(P3.outTransitionDis[1], T2.inPlacesDis[1]) annotation(
    Line(points = {{-20, 20}, {-6, 20}, {-6, 20}, {-4, 20}}));
  connect(T1.outPlacesDis[1], P2.inTransitionDis[1]) annotation(
    Line(points = {{4, 60}, {18, 60}, {18, 60}, {20, 60}}));
  connect(P1.outTransitionDis[1], T1.inPlacesDis[1]) annotation(
    Line(points = {{-20, 60}, {-4, 60}, {-4, 60}, {-4, 60}}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent={{-80, -120},
            {60, 100}}), graphics), experiment(StartTime=0.0, StopTime=10.0, Tolerance = 1e-6));
end FiveTimes;
