within PNlib.PN.Examples.ConTest;
model PCtoTCfunction
  extends Modelica.Icons.Example;

  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent={{20, 20},
            {40, 40}})));
  PNlib.PN.Components.PC P1(nOutCon = 1, startTokens = 1) annotation(Placement(transformation(extent={{-10, -10},
            {10, 10}})));
  PNlib.PN.Components.TC T1(arcWeightInCon = {P1.t}, nInCon = 1) annotation(Placement(transformation(extent={{20, -10}, {40,
            10}})));
equation
  connect(P1.outTransitionCon[1], T1.inPlacesCon[1]) annotation(Line(points={{10.8, 0},
          {25.2, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent={{-40, -40},
            {40, 40}}), graphics), experiment(StartTime=0.0, StopTime=10.0, Tolerance = 1e-6));
end PCtoTCfunction;
