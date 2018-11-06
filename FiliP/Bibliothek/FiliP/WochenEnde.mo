within FiliP;

model WochenEnde
parameter Real StartWochenEnde = 6 "Start des 1. Wochenendes" annotation(
    Dialog(enable = true, group = "Wochenenddaten"));
parameter Real DauerWochenEnde = 2 "Dauer eines Wochenendes" annotation(
    Dialog(enable = true, group = "Wochenenddaten"));
parameter Real IntervallWochenEnde = 14 "Intervall der Wochenenden" annotation(
    Dialog(enable = true, group = "Wochenenddaten"));
parameter Boolean NichtWochenEnde = false "fuer nicht 2 wochen Rytmus" annotation(
    Dialog(enable = true, group = "Wochenenddaten"));
parameter Real StartNichtWochenEnde = 2 "Start des 1. Arbeits Wochenendes" annotation(
    Dialog(enable = true, group = "Wochenenddaten"));
parameter Real IntervallNichtWochenEnde = 14 "Intervall der Arbeits Wochenenden" annotation(
    Dialog(enable = true, group = "Wochenenddaten"));

PNlib.PN.Components.TD WochenEndSignal(firingCon = if NichtWochenEnde then not sample(StartNichtWochenEnde, IntervallNichtWochenEnde) else true,nOutDis = 1, timeType = PNlib.Types.TimeType.Tact, timeValue = {StartWochenEnde, IntervallWochenEnde}) annotation(
    Placement(visible = true, transformation(origin = {-30, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD WochenEndGeber2(nInDis = 2, nOutDis = 1, timeType = PNlib.Types.TimeType.Immediate, timeValue = {0}) annotation(
    Placement(visible = true, transformation(extent = {{54, 0}, {34, 20}}, rotation = 0)));
  PNlib.PN.Components.TD WochenEndGeber1(nInDis = 2, nOutDis = 1, timeType = PNlib.Types.TimeType.Immediate, timeValue = {0}) annotation(
    Placement(visible = true, transformation(extent = {{-60, 0}, {-40, 20}}, rotation = 0)));
  PNlib.PN.Components.PD SollInsWochenEnde(nOutDis = 3, nInDis = 1, maxTokens = 1) annotation(
    Placement(visible = true, transformation(origin = {20, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD ImWochenEnde(nOutDis = 1, nInDis = 2) annotation(
    Placement(visible = true, transformation(origin = {-22, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD WochenEndEnde(firingCon = if NichtWochenEnde then not sample(StartNichtWochenEnde, IntervallNichtWochenEnde) else true,nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.Tact, timeValue = {StartWochenEnde + DauerWochenEnde + 0.01, IntervallWochenEnde}) annotation(
    Placement(visible = true, transformation(extent = {{34, 60}, {54, 80}}, rotation = 0)));
  PNlib.PN.Components.TD WEenderbeiKrank(nInDis = 1, timeType = PNlib.Types.TimeType.Delay, timeValue = {DauerWochenEnde - 0.1}) annotation(
    Placement(visible = true, transformation(extent = {{68, -68}, {88, -48}}, rotation = 0)));
  PNlib.PN.Interfaces.DisTransitionIn WESignal1 annotation(
    Placement(visible = true, transformation(origin = {-110, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Interfaces.DisTransitionIn WESignal2 annotation(
    Placement(visible = true, transformation(origin = {110, 10}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {110, 2}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PNlib.PN.Interfaces.DisTransitionOut WEende annotation(
    Placement(visible = true, transformation(origin = {110, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(WochenEndEnde.outPlacesDis[1], WEende) annotation(
    Line(points = {{48, 70}, {78, 70}, {78, 88}, {106, 88}, {106, 90}, {110, 90}}, thickness = 0.5));
  connect(WESignal2, WochenEndGeber2.inPlacesDis[2]) annotation(
    Line(points = {{110, 10}, {50, 10}, {50, 10}, {48, 10}}));
  connect(WESignal1, WochenEndGeber1.inPlacesDis[2]) annotation(
    Line(points = {{-110, 12}, {-82, 12}, {-82, 10}, {-54, 10}}));
  connect(SollInsWochenEnde.outTransitionDis[1], WEenderbeiKrank.inPlacesDis[1]) annotation(
    Line(points = {{30.8, -58}, {72.8, -58}, {72.8, -58}, {74.8, -58}}, thickness = 0.5));
  connect(WochenEndGeber1.inPlacesDis[1], SollInsWochenEnde.outTransitionDis[3]) annotation(
    Line(points = {{-54, 10}, {-72, 10}, {-72, -42}, {58, -42}, {58, -60}, {31, -60}}, thickness = 0.5));
  connect(WochenEndGeber2.inPlacesDis[1], SollInsWochenEnde.outTransitionDis[2]) annotation(
    Line(points = {{48, 10}, {58, 10}, {58, -60}, {31, -60}}, thickness = 0.5));
  connect(WochenEndSignal.outPlacesDis[1], SollInsWochenEnde.inTransitionDis[1]) annotation(
    Line(points = {{-25.2, -58}, {8.8, -58}, {8.8, -58}, {10.8, -58}}, thickness = 0.5));
  connect(WochenEndGeber2.outPlacesDis[1], ImWochenEnde.inTransitionDis[2]) annotation(
    Line(points = {{40, 10}, {-8, 10}, {-8, 44}, {-50, 44}, {-50, 70}, {-32, 70}, {-32, 70}}, thickness = 0.5));
  connect(WochenEndGeber1.outPlacesDis[1], ImWochenEnde.inTransitionDis[1]) annotation(
    Line(points = {{-46, 10}, {-8, 10}, {-8, 44}, {-50, 44}, {-50, 70}, {-32, 70}, {-32, 70}}, thickness = 0.5));
  connect(ImWochenEnde.outTransitionDis[1], WochenEndEnde.inPlacesDis[1]) annotation(
    Line(points = {{-12, 70}, {38, 70}, {38, 70}, {40, 70}}, thickness = 0.5));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
    Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.2), graphics = {Rectangle( fillColor = {0, 255, 127}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}));
end WochenEnde;
