within PNlib.PN.Examples.Models.FiliP.ModellStationen;
model Station1
  extends Modelica.Icons.Example;
  parameter Real BeginFruehschicht = 6;
  parameter Real BeginSpaetschicht = 12.3;
  parameter Real BeginNachtschicht = 20.25;
  parameter Real DauerFruehschicht = 8.2;
  parameter Real DauerSpaetschicht = 8.2;
  parameter Real DauerNachtschicht = 10;
  parameter Real KrankDauer[:] = 1:31;
  parameter Real WkeitKrankDauer[:] = {75 / 237, 41 / 237, 24 / 237, 19 / 237, 22 / 237, 10 / 237, 13 / 237, 4 / 237, 2 / 237, 3 / 237, 2 / 237, 1 / 237, 3 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237};
  Real WK = if time <= 744 then 0.0117 else if time <= 1464 then 0.008 else if time <= 2208 then 0.0196 else if time <= 2928 then 0.0325 else if time <= 3672 then 0.0276 else if time <= 4416 then 0.031 else if time <= 5088 then 0.0344 else if time <= 5832 then 0.0458 else if time <= 6552 then 0.0084 else if time <= 7296 then 0.0118 else if time <= 8016 then 0.0315 else 0.0188;
  PNlib.PN.Examples.Models.FiliP.Station station( APFD = 1,APND = 1, APSD = 1, BeginFruehschicht = BeginFruehschicht, BeginNachtschicht = BeginNachtschicht, BeginSpaetschicht = BeginSpaetschicht, nP = 1) annotation(
    Placement(visible = true, transformation(extent = {{-20, 20}, {20, 60}}, rotation = 0)));
  PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft(BeginFruehschicht = BeginFruehschicht, BeginNachtschicht = BeginNachtschicht, BeginSpaetschicht = BeginSpaetschicht, DauerFruehschicht = DauerFruehschicht, DauerNachtschicht = DauerFruehschicht, DauerSpaetschicht = DauerSpaetschicht,Dienstbereit(maxTokens = 1), WEF = 1, WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WK) annotation(
    Placement(visible = true, transformation(extent = {{-60, -80}, {0, -20}}, rotation = 0)));
  inner PNlib.PN.Components.Settings settings annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(station.placeOutDis[1], pflegekraft.transitionInDis[1]);
  connect(station.placeOutDis[2], pflegekraft.transitionInDis[2]);
  connect(station.placeOutDis[3], pflegekraft.transitionInDis[3]);

  connect(station.placeInDis[1], pflegekraft.transitionOutDis[1]);
  connect(station.placeInDis[2], pflegekraft.transitionOutDis[2]);
  connect(station.placeInDis[3], pflegekraft.transitionOutDis[3]);
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
    experiment(StartTime = 0, StopTime = 365, Tolerance = 1e-06));
end Station1;
