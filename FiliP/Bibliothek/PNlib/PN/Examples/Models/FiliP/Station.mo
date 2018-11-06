within PNlib.PN.Examples.Models.FiliP;

model Station
  parameter Integer nP = 1 "Anzahl der Pflegekraefte" annotation(
    Dialog(enable = true, group = "Personal Daten"));
  parameter Integer APFD = 3 "Min. Anzahl Personal im Fruehedienst" annotation(
    Dialog(enable = true, group = "Personal"));
  parameter Integer APSD = 2 "Min. Anzahl Personal im Spaetdienst" annotation(
    Dialog(enable = true, group = "Personal"));
  parameter Integer APND = 2 "Min. Anzahl Personal im Nachtdienst" annotation(
    Dialog(enable = true, group = "Personal"));
 parameter Real BeginFruehschicht annotation(
    Dialog(enable = true, group = "Zeiten"));
 parameter Real BeginSpaetschicht annotation(
    Dialog(enable = true, group = "Zeiten"));
 parameter Real BeginNachtschicht annotation(
    Dialog(enable = true, group = "Zeiten"));
    parameter Real DauerFruehschicht annotation(
       Dialog(enable = true, group = "Zeiten"));
    parameter Real DauerSpaetschicht annotation(
       Dialog(enable = true, group = "Zeiten"));
    parameter Real DauerNachtschicht annotation(
       Dialog(enable = true, group = "Zeiten"));
  Real BesetzungFruehDienst = PersonalImFruedienst.t;
  Real BesetzungSpaetDienst = PersonalImSpaetdienst.t;
  Real BesetzungNachtDienst = PersonalImNachtdienst.t;
  Real BesetzungsDefizitFrueh = DefizitFruehschicht.t;
  Real BesetzungsDefizitSpaet = DefizitSpaetSchicht.t;
  Real BesetzungsDefizitNacht = DefizizNachtSchicht.t;
  protected
  PNlib.PN.Components.PD DefizitFruehschicht(nInDis = 1) annotation(
    Placement(visible = true, transformation(origin = {164, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD DefizitSpaetSchicht(nInDis = 1) annotation(
    Placement(visible = true, transformation(origin = {162, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD DefizizNachtSchicht(nInDis = 1) annotation(
    Placement(visible = true, transformation(origin = {162, -146}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  PNlib.PN.Components.PD PersonalImFruedienst(enablingProbIn = fill(1 / nP, nP), enablingProbOut = fill(1 / nP, nP), enablingType = PNlib.Types.EnablingType.Probability, maxTokens = APFD, nInDis = nP, nOutDis = nP) annotation(
    Placement(visible = true, transformation(extent = {{-10, 32}, {10, 52}}, rotation = 0)));
  PNlib.PN.Components.PD PersonalImSpaetdienst(enablingProbIn = fill(1 / nP, nP), enablingProbOut = fill(1 / nP, nP), enablingType = PNlib.Types.EnablingType.Probability, maxTokens = APSD, nInDis = nP, nOutDis = nP) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  PNlib.PN.Components.PD PersonalImNachtdienst(enablingProbIn = fill(1 / nP, nP), enablingProbOut = fill(1 / nP, nP), enablingType = PNlib.Types.EnablingType.Probability, maxTokens = APND, nInDis = nP, nOutDis = nP) annotation(
    Placement(visible = true, transformation(extent = {{-10, -52}, {10, -32}}, rotation = 0)));
  PNlib.PN.Interfaces.DisPlaceOut placeOutDis[3 * nP] annotation(
    Placement(transformation(extent = {{200, -52}, {304, 52}})));
  PNlib.PN.Interfaces.DisPlaceIn placeInDis[3 * nP] annotation(
    Placement(visible = true, transformation(extent = {{-298, -50}, {-196, 48}}, rotation = 0), iconTransformation(extent = {{-298, -50}, {-196, 48}}, rotation = 0)));
  PNlib.PN.Components.TD BeginnFrueh( arcWeightOutDis = {APFD - PersonalImFruedienst.t},nOutDis = 1, timeType = PNlib.Types.TimeType.Tact, timeValue ={(BeginFruehschicht + 1)/24,1}) annotation(
    Placement(visible = true, transformation(extent = {{106, -70}, {126, -50}}, rotation = 0)));
  PNlib.PN.Components.TD BeginnSpaet( arcWeightOutDis = {APSD - PersonalImSpaetdienst.t},nOutDis = 1, timeType = PNlib.Types.TimeType.Tact, timeValue ={(BeginSpaetschicht + 1)/24,1}) annotation(
    Placement(visible = true, transformation(extent = {{106, -114}, {126, -94}}, rotation = 0)));
  PNlib.PN.Components.TD BeginnNacht( arcWeightOutDis = {APND - PersonalImNachtdienst.t},nOutDis = 1, timeType = PNlib.Types.TimeType.Tact, timeValue ={(BeginNachtschicht + 1)/24,1}) annotation(
    Placement(visible = true, transformation(extent = {{106, -156}, {126, -136}}, rotation = 0)));
  outer PNlib.PN.Components.Settings settings "global settings for animation and display";
equation
  connect(BeginnNacht.outPlacesDis[1], DefizizNachtSchicht.inTransitionDis[1]) annotation(
    Line(points = {{121, -146}, {149, -146}}, thickness = 0.5));
  connect(BeginnSpaet.outPlacesDis[1], DefizitSpaetSchicht.inTransitionDis[1]) annotation(
    Line(points = {{121, -102}, {150, -102}, {150, -104}, {152, -104}}, thickness = 0.5));
  connect(BeginnFrueh.outPlacesDis[1], DefizitFruehschicht.inTransitionDis[1]) annotation(
    Line(points = {{120, -60}, {152, -60}, {152, -60}, {154, -60}}, thickness = 0.5));
  for i in 1:nP loop
    connect(PersonalImFruedienst.inTransitionDis[i], placeInDis[1 + 3 * (i - 1)]) annotation(
      Line(points = {{-10.8, 122}, {-148, 122}, {-148, -1}, {-247, -1}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(PersonalImFruedienst.outTransitionDis[i], placeOutDis[1 + 3 * (i - 1)]) annotation(
      Line(points = {{10.8, 122}, {166, 122}, {166, 0}, {252, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(PersonalImSpaetdienst.outTransitionDis[i], placeOutDis[2 + 3 * (i - 1)]) annotation(
      Line(points = {{10.8, 0}, {252, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(PersonalImSpaetdienst.inTransitionDis[i], placeInDis[2 + 3 * (i - 1)]) annotation(
      Line(points = {{-10.8, 0}, {-128, 0}, {-128, -1}, {-247, -1}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(PersonalImNachtdienst.outTransitionDis[i], placeOutDis[3 + 3 * (i - 1)]) annotation(
      Line(points = {{10.8, -60}, {58, -60}, {58, 0}, {252, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(PersonalImNachtdienst.inTransitionDis[i], placeInDis[3 + 3 * (i - 1)]) annotation(
      Line(points = {{-10.8, -60}, {-60, -60}, {-60, -1}, {-247, -1}}, color = {0, 0, 0}, smooth = Smooth.None));
  end for;
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -200}, {200, 200}}), graphics),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -200}, {200, 200}}, initialScale = 0.1), graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-200, 200}, {198, -200}}), Rectangle(fillColor = {255, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-20, 60}, {20, -60}}), Rectangle(fillColor = {255, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-60, 20}, {60, -20}})}));
end Station;
