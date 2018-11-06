within PNlib.PN.Examples.ConTest;
model ConflictLoop
  extends Modelica.Icons.Example;

  PNlib.PN.Components.TC T1(nOutCon = 1, nInCon = 2, arcWeightOutCon = {3}, arcWeightInCon = {2, 1}) annotation(Placement(transformation(extent={{-60, -10},
            {-40, 10}})));
  PNlib.PN.Components.TC T2(nInCon = 1, nOutCon = 1, maximumSpeed = 4) annotation(Placement(transformation(extent={{0, 10}, {
            20, 30}})));
  PNlib.PN.Components.TC T3(nInCon = 1, nOutCon = 1, maximumSpeed = 2) annotation(Placement(transformation(extent={{2, -30},
            {22, -10}})));
  PNlib.PN.Components.PC P1(nInCon = 1, nOutCon = 2) annotation(Placement(transformation(extent={{-30, -10},
            {-10, 10}})));
  PNlib.PN.Components.PC P2(nInCon = 1, nOutCon = 1, startTokens = 2) annotation(Placement(transformation(extent={{30, 10},
            {50, 30}})));
  PNlib.PN.Components.PC P3(nInCon = 1, nOutCon = 1, startTokens = 1) annotation(Placement(transformation(extent={{30, -30},
            {50, -10}})));
  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent={{30, 50},
            {50, 70}})));
equation
  connect(T1.outPlacesCon[1], P1.inTransitionCon[1]) annotation(Line(points={{-45.2, 0},
          {-30.8, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(P1.outTransitionCon[1], T2.inPlacesCon[1]) annotation(Line(points={{-9.2,
          -0.5}, {0, -0.5}, {0, 20}, {5.2, 20}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T2.outPlacesCon[1], P2.inTransitionCon[1]) annotation(Line(points={{14.8, 20},
          {29.2, 20}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T3.inPlacesCon[1], P1.outTransitionCon[2]) annotation(Line(points={{7.2, -20},
          {0, -20}, {0, 0.5}, {-9.2, 0.5}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(P3.inTransitionCon[1], T3.outPlacesCon[1]) annotation(Line(points={{29.2,
          -20}, {16.8, -20}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(P2.outTransitionCon[1], T1.inPlacesCon[1]) annotation(Line(points={{50.8, 20},
          {60, 20}, {60, 40}, {-60, 40}, {-60, -0.5}, {-54.8, -0.5}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(P3.outTransitionCon[1], T1.inPlacesCon[2]) annotation(Line(points={{50.8,
          -20}, {60, -20}, {60, -40}, {-60, -40}, {-60, 0.5}, {-54.8, 0.5}}, color = {0, 0, 0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent={{-80, -60},
            {80, 80}}), graphics), experiment(StartTime=0.0, StopTime=10.0, Tolerance = 1e-6));
end ConflictLoop;
