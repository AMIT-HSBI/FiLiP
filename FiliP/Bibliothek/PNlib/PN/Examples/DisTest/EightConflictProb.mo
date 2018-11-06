within PNlib.PN.Examples.DisTest;
model EightConflictProb
  extends Modelica.Icons.Example;

  PNlib.PN.Components.PD P1(startTokens = 1, enablingType = PNlib.Types.EnablingType.Probability, nOutDis = 8,
    localSeedIn=1,
    localSeedOut=2)                                        annotation(Placement(transformation(extent={{-50, -10},
            {-30, 10}})));
  PNlib.PN.Components.TD T1(nInDis = 1) annotation(Placement(transformation(extent={{-20, 30}, {0, 50}})));
  PNlib.PN.Components.TD T2(nInDis = 1) annotation(Placement(transformation(extent={{0, 10}, {20, 30}})));
  PNlib.PN.Components.TD T3(nInDis = 1) annotation(Placement(transformation(extent={{20, 20}, {40, 40}})));
  PNlib.PN.Components.TD T4(nInDis = 1) annotation(Placement(transformation(extent={{40, 10}, {60, 30}})));
  PNlib.PN.Components.TD T5(nInDis = 1) annotation(Placement(transformation(extent={{40, -30}, {60,
            -10}})));
  PNlib.PN.Components.TD T6(nInDis = 1) annotation(Placement(transformation(extent={{-20, -50}, {0,
            -30}})));
  PNlib.PN.Components.TD T7(nInDis = 1) annotation(Placement(transformation(extent={{20, -40}, {40,
            -20}})));
  PNlib.PN.Components.TD T8(nInDis = 1) annotation(Placement(transformation(extent={{0, -30}, {20, -10}})));
  inner PNlib.PN.Components.Settings settings
    annotation(Placement(transformation(extent={{-60, 40}, {-40, 60}})));
equation
  connect(P1.outTransitionDis[1], T1.inPlacesDis[1]) annotation(Line(points={{-29.2, -0.875},
          {-20, -0.875}, {-20, 40}, {-14.8, 40}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T2.inPlacesDis[1], P1.outTransitionDis[2]) annotation(Line(points={{5.2, 20},
          {0, 20}, {0, -0.625}, {-29.2, -0.625}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T3.inPlacesDis[1], P1.outTransitionDis[3]) annotation(Line(points={{25.2, 30},
          {20, 30}, {20, -0.375}, {-29.2, -0.375}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T4.inPlacesDis[1], P1.outTransitionDis[4]) annotation(Line(points={{45.2, 20},
          {40, 20}, {40, -0.125}, {-29.2, -0.125}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T5.inPlacesDis[1], P1.outTransitionDis[5]) annotation(Line(points={{45.2, -20},
          {40, -20}, {40, 0.125}, {-29.2, 0.125}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T6.inPlacesDis[1], P1.outTransitionDis[6]) annotation(Line(points={{-14.8, -40},
          {-20, -40}, {-20, 0.375}, {-29.2, 0.375}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T7.inPlacesDis[1], P1.outTransitionDis[7]) annotation(Line(points={{25.2, -30},
          {20, -30}, {20, 0.625}, {-29.2, 0.625}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T8.inPlacesDis[1], P1.outTransitionDis[8]) annotation(Line(points={{5.2, -20},
          {-0.4, -20}, {-0.4, 0.875}, {-29.2, 0.875}}, color = {0, 0, 0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent={{-60, -60},
            {60, 60}}), graphics), experiment(StartTime=0.0, StopTime=10.0, Tolerance = 1e-6));
end EightConflictProb;
