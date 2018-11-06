within PNlib.PN.Examples.DisTest;
model DisLoopAndArcweight
  extends Modelica.Icons.Example;

  PNlib.PN.Components.PD P1(nOutDis = 1, nInDis = 1, startTokens = 2) annotation(Placement(transformation(extent={{-10, -30},
            {10, -10}})));
  PNlib.PN.Components.TD T1(nInDis = 1, nOutDis = 1, arcWeightInDis = {2}, arcWeightOutDis = {3}) annotation(Placement(transformation(extent={{8, 10}, {
            -12, 30}})));
  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent={{20, 40},
            {40, 60}})));
equation
  connect(P1.outTransitionDis[1], T1.inPlacesDis[1]) annotation(Line(points={{10.8, -20},
          {20, -20}, {20, 20}, {2.8, 20}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T1.outPlacesDis[1], P1.inTransitionDis[1]) annotation(Line(points={{-6.8, 20},
          {-20, 20}, {-20, -20}, {-10.8, -20}}, color = {0, 0, 0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent={{-40, -40},
            {40, 60}}), graphics), experiment(StartTime=0.0, StopTime=10.0, Tolerance = 1e-6));
end DisLoopAndArcweight;
