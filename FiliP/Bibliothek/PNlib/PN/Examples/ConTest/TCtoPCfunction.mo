within PNlib.PN.Examples.ConTest;
model TCtoPCfunction
  extends Modelica.Icons.Example;

  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent={{20, 20},
            {40, 40}})));
  PNlib.PN.Components.TC T1(arcWeightOutCon = {P1.t}, nOutCon = 1) annotation(Placement(transformation(extent={{-40, -10}, {
            -20, 10}})));
  PNlib.PN.Components.PC P1(nInCon = 1, startTokens = 1) annotation(Placement(transformation(extent={{-10, -10}, {
            10, 10}})));
equation
  connect(T1.outPlacesCon[1], P1.inTransitionCon[1]) annotation(Line(points={{-25.2, 0},
          {-10.8, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent={{-40, -40},
            {40, 40}}), graphics), experiment(StartTime=0.0, StopTime=3.0, Tolerance = 1e-6));
end TCtoPCfunction;
