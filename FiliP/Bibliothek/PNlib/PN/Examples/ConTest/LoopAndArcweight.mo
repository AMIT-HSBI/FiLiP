within PNlib.PN.Examples.ConTest;
model LoopAndArcweight
  extends Modelica.Icons.Example;

  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent={{-40, 20},
            {-20, 40}})));
  PNlib.PN.Components.PC P1(nOutCon = 1, nInCon = 1, startTokens = 1) annotation(Placement(transformation(extent={{-10, -10},
            {10, 10}},
        rotation=180,
        origin={0, -30})));
  PNlib.PN.Components.TC T1(nInCon = 1, nOutCon = 2, arcWeightInCon = {3}, arcWeightOutCon = {2, 2}) annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation=180, origin={0, 0})));
  PNlib.PN.Components.PC P2(nInCon = 1) annotation(Placement(transformation(extent={{10, -10}, {-10, 10}}, rotation=270, origin={20, 30})));
equation
  connect(P1.outTransitionCon[1], T1.inPlacesCon[1]) annotation(Line(points={{-10.8,
          -30}, {-20, -30}, {-20, 4.44089e-016}, {-4.8, 4.44089e-016}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(P1.inTransitionCon[1], T1.outPlacesCon[1]) annotation(Line(points={{10.8,
          -30}, {20, -30}, {20, 0.5}, {4.8, 0.5}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(P2.inTransitionCon[1], T1.outPlacesCon[2]) annotation(Line(points={{20, 19.2},
          {20, -0.5}, {4.8, -0.5}}, color = {0, 0, 0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent={{-40, -40},
            {40, 40}}), graphics), experiment(StartTime=0.0, StopTime=10.0, Tolerance = 1e-6));
end LoopAndArcweight;
