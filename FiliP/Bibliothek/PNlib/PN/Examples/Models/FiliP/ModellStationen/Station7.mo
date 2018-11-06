within PNlib.PN.Examples.Models.FiliP.ModellStationen;
model Station7
  extends Modelica.Icons.Example;
parameter Real BeginFruehschicht = 6;
  parameter Real BeginSpaetschicht = 12.3;
  parameter Real BeginNachtschicht = 20.25;
  parameter Real DauerFruehschicht = 8.2;
  parameter Real DauerSpaetschicht = 8.2;
  parameter Real DauerNachtschicht = 10;
  parameter Real KrankDauer[:] =1:31;
  parameter Real WkeitKrankDauer[:] = {75/237, 41/237, 24/237, 19/237, 22/237, 10/237, 13/237, 4/237, 2/237, 3/237, 2/237, 1/237, 3/237, 1/237, 1/237, 1/237, 1/237, 1/237, 1/237, 1/237, 1/237, 1/237, 1/237, 1/237, 1/237, 1/237, 1/237, 1/237, 1/237, 1/237, 1/237};
  Real WK = if time <= 744 then 0.0117 else if time <= 1464 then 0.008 else if time <= 2208 then 0.0196 else if time <= 2928 then 0.0325 else if time <= 3672 then 0.0276 else if time <= 4416 then 0.031 else if time <= 5088 then 0.0344 else if time <= 5832 then 0.0458 else if time <= 6552 then 0.0084 else if time <= 7296 then 0.0118 else if time <= 8016 then 0.0315 else 0.0188;

  PNlib.PN.Examples.Models.FiliP.Station station(APFD = 1, APND = 1, APSD = 1,BeginFruehschicht = BeginFruehschicht, BeginNachtschicht = BeginNachtschicht, BeginSpaetschicht = BeginSpaetschicht, nP = 7) annotation(
    Placement(visible = true, transformation(extent = {{-18, 290}, {22, 330}}, rotation = 0)));
  PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft1(BeginFruehschicht = BeginFruehschicht, BeginNachtschicht = BeginNachtschicht, BeginSpaetschicht = BeginSpaetschicht, DauerFruehschicht = DauerFruehschicht, DauerNachtschicht = DauerFruehschicht, DauerSpaetschicht = DauerSpaetschicht,Dienstbereit(maxTokens = 1), UrlaubEndTermine = {25, 53, 81}, UrlaubStartTermine = {11, 39, 67}, WEF = 2,WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WK) annotation(
    Placement(visible = true, transformation(extent = {{-30, 198}, {30, 258}}, rotation = 0)));
  PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft2(BeginFruehschicht = BeginFruehschicht, BeginNachtschicht = BeginNachtschicht, BeginSpaetschicht = BeginSpaetschicht, DauerFruehschicht = DauerFruehschicht, DauerNachtschicht = DauerFruehschicht, DauerSpaetschicht = DauerSpaetschicht,UrlaubEndTermine = {109, 137, 165}, UrlaubStartTermine = {95, 123, 151}, WEF = 2,WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WK) annotation(
    Placement(visible = true, transformation(extent = {{-32, 116}, {28, 176}}, rotation = 0)));
  PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft3(BeginFruehschicht = BeginFruehschicht, BeginNachtschicht = BeginNachtschicht, BeginSpaetschicht = BeginSpaetschicht, DauerFruehschicht = DauerFruehschicht, DauerNachtschicht = DauerFruehschicht, DauerSpaetschicht = DauerSpaetschicht,UrlaubEndTermine = {193, 221, 249}, UrlaubStartTermine = {179, 207, 235}, WEF = 2,WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WK) annotation(
    Placement(visible = true, transformation(extent = {{-34, 26}, {26, 86}}, rotation = 0)));
  PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft4(BeginFruehschicht = BeginFruehschicht, BeginNachtschicht = BeginNachtschicht, BeginSpaetschicht = BeginSpaetschicht, DauerFruehschicht = DauerFruehschicht, DauerNachtschicht = DauerFruehschicht, DauerSpaetschicht = DauerSpaetschicht,UrlaubEndTermine = {263, 277, 291, 305, 319, 333}, UrlaubStartTermine = {256, 270, 284, 298, 312, 326}, WEF = 3,WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WK) annotation(
    Placement(visible = true, transformation(extent = {{-32, -56}, {28, 4}}, rotation = 0)));
  PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft5(BeginFruehschicht = BeginFruehschicht, BeginNachtschicht = BeginNachtschicht, BeginSpaetschicht = BeginSpaetschicht, DauerFruehschicht = DauerFruehschicht, DauerNachtschicht = DauerFruehschicht, DauerSpaetschicht = DauerSpaetschicht,UrlaubEndTermine = {19, 47, 75}, UrlaubStartTermine = {5, 33, 61},WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WK)  annotation(
    Placement(visible = true, transformation(extent = {{-36, -150}, {24, -90}}, rotation = 0)));
  PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft6(BeginFruehschicht = BeginFruehschicht, BeginNachtschicht = BeginNachtschicht, BeginSpaetschicht = BeginSpaetschicht, DauerFruehschicht = DauerFruehschicht, DauerNachtschicht = DauerFruehschicht, DauerSpaetschicht = DauerSpaetschicht,UrlaubEndTermine = {103, 131, 159}, UrlaubStartTermine = {89, 117, 145},WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WK)  annotation(
    Placement(visible = true, transformation(extent = {{-38, -242}, {22, -182}}, rotation = 0)));
  PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft7(BeginFruehschicht = BeginFruehschicht, BeginNachtschicht = BeginNachtschicht, BeginSpaetschicht = BeginSpaetschicht, DauerFruehschicht = DauerFruehschicht, DauerNachtschicht = DauerFruehschicht, DauerSpaetschicht = DauerSpaetschicht,UrlaubEndTermine = {187, 215, 243}, UrlaubStartTermine = {173, 201, 229},WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WK)  annotation(
    Placement(visible = true, transformation(extent = {{-38, -330}, {22, -270}}, rotation = 0)));
  inner PNlib.PN.Components.Settings settings annotation(
    Placement(visible = true, transformation(origin = {140, 340}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(station.placeOutDis[10], pflegekraft4.transitionInDis[1]) annotation(
    Line);
  connect(station.placeOutDis[11], pflegekraft4.transitionInDis[2]) annotation(
    Line);
  connect(station.placeOutDis[12], pflegekraft4.transitionInDis[3]) annotation(
    Line);
  connect(station.placeInDis[10], pflegekraft4.transitionOutDis[1]) annotation(
    Line);
  connect(station.placeInDis[11], pflegekraft4.transitionOutDis[2]) annotation(
    Line);
  connect(station.placeInDis[12], pflegekraft4.transitionOutDis[3]) annotation(
    Line);
  connect(station.placeInDis[21], pflegekraft7.transitionOutDis[3]);
  connect(station.placeInDis[20], pflegekraft7.transitionOutDis[2]);
  connect(station.placeInDis[19], pflegekraft7.transitionOutDis[1]);
  connect(station.placeInDis[18], pflegekraft6.transitionOutDis[3]);
  connect(station.placeInDis[17], pflegekraft6.transitionOutDis[2]);
  connect(station.placeInDis[16], pflegekraft6.transitionOutDis[1]);
  connect(station.placeInDis[15], pflegekraft5.transitionOutDis[3]);
  connect(station.placeInDis[14], pflegekraft5.transitionOutDis[2]);
  connect(station.placeInDis[13], pflegekraft5.transitionOutDis[1]);
  connect(station.placeInDis[9], pflegekraft3.transitionOutDis[3]);
  connect(station.placeInDis[8], pflegekraft3.transitionOutDis[2]);
  connect(station.placeInDis[7], pflegekraft3.transitionOutDis[1]);
  connect(station.placeInDis[6], pflegekraft2.transitionOutDis[3]);
  connect(station.placeInDis[5], pflegekraft2.transitionOutDis[2]);
  connect(station.placeInDis[4], pflegekraft2.transitionOutDis[1]);
  connect(station.placeOutDis[1], pflegekraft1.transitionInDis[1]);
  connect(station.placeOutDis[2], pflegekraft1.transitionInDis[2]);
  connect(station.placeOutDis[3], pflegekraft1.transitionInDis[3]);

  connect(station.placeOutDis[21], pflegekraft7.transitionInDis[3]);
  connect(station.placeOutDis[20], pflegekraft7.transitionInDis[2]);
  connect(station.placeOutDis[19], pflegekraft7.transitionInDis[1]);
  connect(station.placeOutDis[18], pflegekraft6.transitionInDis[3]);
  connect(station.placeOutDis[17], pflegekraft6.transitionInDis[2]);
  connect(station.placeOutDis[16], pflegekraft6.transitionInDis[1]);
  connect(station.placeOutDis[15], pflegekraft5.transitionInDis[3]);
  connect(station.placeOutDis[14], pflegekraft5.transitionInDis[2]);
  connect(station.placeOutDis[13], pflegekraft5.transitionInDis[1]);
  connect(station.placeOutDis[9], pflegekraft3.transitionInDis[3]);
  connect(station.placeOutDis[8], pflegekraft3.transitionInDis[2]);
  connect(station.placeOutDis[7], pflegekraft3.transitionInDis[1]);
  connect(station.placeOutDis[6], pflegekraft2.transitionInDis[3]);
  connect(station.placeOutDis[5], pflegekraft2.transitionInDis[2]);
  connect(station.placeOutDis[4], pflegekraft2.transitionInDis[1]);
  connect(station.placeInDis[1], pflegekraft1.transitionOutDis[1]);
  connect(station.placeInDis[2], pflegekraft1.transitionOutDis[2]);
  connect(station.placeInDis[3], pflegekraft1.transitionOutDis[3]);

  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-150, -350}, {150, 350}}), graphics),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}))/*,
    experiment(StartTime = 0, StopTime = 365, Tolerance = 1e-06)*/);
end Station7;
