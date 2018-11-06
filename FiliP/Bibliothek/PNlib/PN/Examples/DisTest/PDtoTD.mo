within PNlib.PN.Examples.DisTest;
model PDtoTD
  extends Modelica.Icons.Example;

  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent={{20, 20},
            {40, 40}})));
  PNlib.PN.Components.PD P1(nOutDis = 1, startTokens = 10) annotation(Placement(transformation(extent={{-30, -10},
            {-10, 10}})));
  PNlib.PN.Components.TD T1(nInDis = 1) annotation(Placement(transformation(extent={{10, -10}, {30,
            10}})));
equation
  connect(T1.inPlacesDis[1], P1.outTransitionDis[1]) annotation(Line(points={{15.2, 0},
          {-9.2, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent={{-40, -40},
            {40, 40}}), graphics), experiment(StartTime=0.0, StopTime=10.0, Tolerance = 1e-6));
end PDtoTD;
