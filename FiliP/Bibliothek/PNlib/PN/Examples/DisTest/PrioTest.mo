within PNlib.PN.Examples.DisTest;
model PrioTest
 extends Modelica.Icons.Example;
  inner PNlib.PN.Components.Settings settings annotation(Placement(visible = true, transformation(extent = {{-60, 50}, {-40, 70}}, rotation = 0)));
 PNlib.PN.Components.PD P1(enablingPrioOut = {4, 3, 2, 1}, nInDis = 1, nOutDis = 4, startTokens = 1)  annotation(Placement(visible = true, transformation(origin = {-26, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 PNlib.PN.Components.TD T1(nOutDis = 1)  annotation(Placement(visible = true, transformation(origin = {-52, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 PNlib.PN.Components.TD T2(nInDis = 1, nOutDis = 1)  annotation(Placement(visible = true, transformation(origin = {16, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 PNlib.PN.Components.TD T3(nInDis = 1, nOutDis = 1)  annotation(Placement(visible = true, transformation(origin = {16, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 PNlib.PN.Components.TD T4(nInDis = 1, nOutDis = 1)  annotation(Placement(visible = true, transformation(origin = {16, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 PNlib.PN.Components.TD T5(nInDis = 1, nOutDis = 1)  annotation(Placement(visible = true, transformation(origin = {16, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 PNlib.PN.Components.PD P2(maxTokens = 1, nInDis = 1)  annotation(Placement(visible = true, transformation(origin = {40, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 PNlib.PN.Components.PD P3(maxTokens = 1, nInDis = 1)  annotation(Placement(visible = true, transformation(origin = {40, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 PNlib.PN.Components.PD P4(maxTokens = 1, nInDis = 1)  annotation(Placement(visible = true, transformation(origin = {40, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 PNlib.PN.Components.PD P5(maxTokens = 1, nInDis = 1)  annotation(Placement(visible = true, transformation(origin = {40, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(T1.outPlacesDis[1], P1.inTransitionDis[1]) annotation(
    Line(points = {{-47.2, 6}, {-37.2, 6}, {-37.2, 6}, {-35.2, 6}}));
  connect(P1.outTransitionDis[2], T3.inPlacesDis[1]) annotation(
    Line(points = {{-15, 4}, {0, 4}, {0, 24}, {11, 24}}));
  connect(P1.outTransitionDis[3], T4.inPlacesDis[1]) annotation(
    Line(points = {{-15, 4}, {0, 4}, {0, -10}, {11, -10}}));
  connect(P1.outTransitionDis[1], T2.inPlacesDis[1]) annotation(
    Line(points = {{-15, 4}, {0, 4}, {0, 56}, {11, 56}}));
  connect(P1.outTransitionDis[4], T5.inPlacesDis[1]) annotation(
    Line(points = {{-15, 4}, {0, 4}, {0, -46}, {11, -46}}));
  connect(T4.outPlacesDis[1], P4.inTransitionDis[1]) annotation(
    Line(points = {{20.8, -10}, {28.8, -10}, {28.8, -10}, {30.8, -10}}));
  connect(T3.outPlacesDis[1], P3.inTransitionDis[1]) annotation(
    Line(points = {{20.8, 24}, {30.8, 24}, {30.8, 24}, {30.8, 24}}));
  connect(T2.outPlacesDis[1], P2.inTransitionDis[1]) annotation(
    Line(points = {{20.8, 56}, {30.8, 56}, {30.8, 56}, {30.8, 56}}));
  connect(T5.outPlacesDis[1], P5.inTransitionDis[1]) annotation(Line(points = {{20, -46}, {30, -46}, {30, -46}, {30, -46}}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-60, -70}, {60, 70}}), graphics), experiment(StartTime = 0.0, StopTime = 5.0, Tolerance = 1e-6));

end PrioTest;
