within PNlib.PN.Examples.DisTest;
model PDtoTT
  extends Modelica.Icons.Example;

  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent={{20, 20},
            {40, 40}})));
  PNlib.PN.Components.PD P1(nOutDis = 1, startTokens = 10) annotation(Placement(transformation(extent={{-30, -10},
            {-10, 10}})));
  PNlib.PN.Components.TD T1(nInDis = 1, timeType = PNlib.Types.TimeType.Tact, timeValue = {1, 1})  annotation(
    Placement(visible = true, transformation(origin = {18, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(P1.outTransitionDis[1], T1.inPlacesDis[1]) annotation(
    Line(points = {{-10, 0}, {14, 0}, {14, 0}, {14, 0}}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent={{-40, -40},
            {40, 40}}), graphics), experiment(StartTime=0.0, StopTime=10.0, Tolerance = 1e-6));
end PDtoTT;
