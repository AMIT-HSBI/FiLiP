within PNlib.PN.Examples.DisTest;
model TTandTDtest2
  extends Modelica.Icons.Example;
  inner PNlib.PN.Components.Settings settings annotation(Placement(visible = true, transformation(extent = {{-80, 20}, {-60, 40}}, rotation = 0)));
  PNlib.PN.Components.PD P2( enablingPrioOut = {2, 1},nOutDis = 2, startTokens = 1)  annotation(
    Placement(visible = true, transformation(origin = {-38, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T3( nInDis = 1, nOutDis = 1, syncroTact = true, timeType = PNlib.Types.TimeType.Tact, timeValue = {1, 1})  annotation(
    Placement(visible = true, transformation(origin = {-10, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P3(nInDis = 1)  annotation(
    Placement(visible = true, transformation(origin = {14, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T4( nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.Delay, timeValue = {1})  annotation(
    Placement(visible = true, transformation(origin = {-8, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P4(nInDis = 1)  annotation(
    Placement(visible = true, transformation(origin = {16, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(T4.inPlacesDis[1], P2.outTransitionDis[2]) annotation(
    Line(points = {{-12.8, -20}, {-20.8, -20}, {-20.8, 0}, {-28.8, 0}, {-28.8, 0}}, thickness = 0.5));
  connect(T4.outPlacesDis[1], P4.inTransitionDis[1]) annotation(
    Line(points = {{-3.2, -20}, {5.8, -20}}, thickness = 0.5));
  connect(T3.outPlacesDis[1], P3.inTransitionDis[1]) annotation(
    Line(points = {{-5.2, 24}, {4.8, 24}, {4.8, 24}, {4.8, 24}}, thickness = 0.5));
  connect(T3.inPlacesDis[1], P2.outTransitionDis[1]) annotation(
    Line(points = {{-14.8, 24}, {-20.8, 24}, {-20.8, 2}, {-27.8, 2}}, thickness = 0.5));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent={{-80, -40},
            {40, 40}}), graphics), experiment(StartTime=0.0, StopTime=5.0, Tolerance = 1e-6));
end TTandTDtest2;
