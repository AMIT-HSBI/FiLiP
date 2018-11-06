within PNlib.PN.Examples.ConTest;
model Speed
  extends Modelica.Icons.Example;

  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent={{60, 20},
            {80, 40}})));
  PNlib.PN.Components.TC T1(nOutCon = 1, maximumSpeed = 2) annotation(Placement(transformation(extent={{-40, 10},
            {-20, 30}})));
  PNlib.PN.Components.PC P1(nInCon = 2, nOutCon = 1) annotation(Placement(transformation(extent={{-10, -10},
            {10, 10}})));
  PNlib.PN.Components.TC T2(nOutCon = 1, arcWeightOutCon = {2}) annotation(Placement(transformation(extent={{-40, -30},
            {-20, -10}})));
  PNlib.PN.Components.TC T3(nInCon = 1, nOutCon = 1, arcWeightInCon = {4}, arcWeightOutCon = {4}) annotation(Placement(transformation(extent={{20, -10},
            {40, 10}})));
  PNlib.PN.Components.PC P2(nInCon = 1) annotation(Placement(transformation(extent={{50, -10}, {70,
            10}})));
equation
  connect(T1.outPlacesCon[1], P1.inTransitionCon[1]) annotation(Line(points={{-25.2,
          20}, {-20, 20}, {-20, -0.5}, {-10.8, -0.5}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T2.outPlacesCon[1], P1.inTransitionCon[2]) annotation(Line(points={{-25.2,
          -20}, {-20, -20}, {-20, 0.5}, {-10.8, 0.5}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T3.inPlacesCon[1], P1.outTransitionCon[1]) annotation(Line(points={{25.2, 0},
          {10.8, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T3.outPlacesCon[1], P2.inTransitionCon[1]) annotation(Line(points={{34.8, 0},
          {49.2, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent={{-40, -40},
            {80, 40}}), graphics), experiment(StartTime=0.0, StopTime=10.0, Tolerance = 1e-6));
end Speed;
