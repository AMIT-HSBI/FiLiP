within PNlib.PN.Examples.DisTest;
model TTtoPD
  extends Modelica.Icons.Example;

  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent={{20, 20},
            {40, 40}})));
  PNlib.PN.Components.PD P1(nInDis = 1) annotation(Placement(visible = true, transformation(extent = {{10, -10}, {30, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T1(nOutDis = 1, timeType = PNlib.Types.TimeType.Tact, timeValue = {1, 1})  annotation(
    Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(T1.outPlacesDis[1], P1.inTransitionDis[1]) annotation(
    Line(points = {{-16, 0}, {8, 0}, {8, 0}, {10, 0}}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent={{-40, -40},
            {40, 40}}), graphics), experiment(StartTime=0.0, StopTime=10.0, Tolerance = 1e-6));
end TTtoPD;
