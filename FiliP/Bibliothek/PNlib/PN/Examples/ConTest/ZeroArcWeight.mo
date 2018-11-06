within PNlib.PN.Examples.ConTest;
model ZeroArcWeight
  extends Modelica.Icons.Example;

  PNlib.PN.Components.PC P1(nOutCon=1)
    annotation(Placement(transformation(extent={{-50, 10}, {-30, 30}})));
  PNlib.PN.Components.PC P2(nOutCon=1, startTokens=10)
    annotation(Placement(transformation(extent={{-50, -30}, {-30, -10}})));
  PNlib.PN.Components.TC T1(nInCon=2, nOutCon=1, arcWeightInCon={0, 1})
    annotation(Placement(transformation(extent={{-10, -10}, {10, 10}})));
  PNlib.PN.Components.PC P3(nInCon=1)
    annotation(Placement(transformation(extent={{30, -10}, {50, 10}})));
  inner PNlib.PN.Components.Settings settings
    annotation(Placement(transformation(extent={{30, 20}, {50, 40}})));
equation
  connect(P1.outTransitionCon[1], T1.inPlacesCon[1]) annotation(Line(points={{-29.2, 20},
          {-20, 20}, {-20, -0.5}, {-4.8, -0.5}}, color={0, 0, 0}));
  connect(P2.outTransitionCon[1], T1.inPlacesCon[2]) annotation(Line(points={{-29.2, -20},
          {-20, -20}, {-20, 0.5}, {-4.8, 0.5}}, color={0, 0, 0}));
  connect(T1.outPlacesCon[1], P3.inTransitionCon[1])
    annotation(Line(points={{4.8, 0}, {29.2, 0}}, color={0, 0, 0}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60, -40},
            {60, 40}})), experiment(StartTime=0.0, StopTime=12.0, Tolerance = 1e-6));
end ZeroArcWeight;
