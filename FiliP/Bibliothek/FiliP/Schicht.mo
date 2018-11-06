within FiliP;

model Schicht

parameter Real SchichtStart;
parameter Real SchichtDauer;
parameter Real SchichtPause;
parameter Boolean KannInSchichtArbeiten;
parameter Boolean SpringtEinInSchicht;
parameter Real MessZeit =0.2;
parameter Real KrankDauer[:] = 1:31 annotation(
  Dialog(enable = true, group = "Krankheits Daten"));
parameter Real WkeitKrankDauer[:] = {75 / 237, 41 / 237, 24 / 237, 19 / 237, 22 / 237, 10 / 237, 13 / 237, 4 / 237, 2 / 237, 3 / 237, 2 / 237, 1 / 237, 3 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237} annotation(
  Dialog(enable = true, group = "Krankheits Daten"));
Real WkeitKrank =0.03  annotation(Dialog(enable = true, group = "Krankheits Daten"));
 
protected
  // Conectoren
  PNlib.PN.Interfaces.DisTransitionOut Warkrank annotation(
    Placement(visible = true, transformation(origin = {4, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {-4, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PNlib.PN.Interfaces.DisTransitionIn PersonalIn [2] annotation(
    Placement(visible = true, transformation(origin = {-110, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Interfaces.DisTransitionIn StationIn[2] annotation(
    Placement(visible = true, transformation(origin = {90, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {90, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PNlib.PN.Interfaces.DisTransitionOut PersonalOut annotation(
    Placement(visible = true, transformation(origin = {110, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Interfaces.HybTransitionIn ArbeitszeitIn [2] annotation(
    Placement(visible = true, transformation(origin = {-110, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Interfaces.HybTransitionOut ArbeistzeitOut annotation(
    Placement(visible = true, transformation(origin = {110, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Interfaces.DisTransitionOut StationOut[2] annotation(
    Placement(visible = true, transformation(origin = {-90, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {-90, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));

  outer PNlib.PN.Components.Settings settings "global settings for animation and display";

// Petri netz
PNlib.PN.Components.TS Krank( E =KrankDauer, P =WkeitKrankDauer, arcWeightOutDis = {1}, distributionType = PNlib.Types.DistributionType.Discrete,nInDis =  2, nOutDis = 1, timeType = PNlib.Types.StoTimeType.FireDuration) annotation(
    Placement(visible = true, transformation(origin = {6, 74}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  PNlib.PN.Components.TD StartSchicht(arcWeightInCon = {SchichtDauer - SchichtPause}, firingCon = KannInSchichtArbeiten, nInCon = 1, nInDis = 1, nOutDis = 2, timeType = PNlib.Types.TimeType.Tact, timeValue = {SchichtStart / 24, 1}) annotation(
    Placement(visible = true, transformation(extent = {{-68, 12}, {-48, 32}}, rotation = 0)));
  PNlib.PN.Components.TD Einspringen(arcWeightInCon = {SchichtDauer - SchichtPause}, firingCon = SpringtEinInSchicht, nInCon = 1, nInDis = 1, nOutDis = 2, timeType = PNlib.Types.TimeType.Tact, timeValue = {(SchichtStart + MessZeit) / 24, 1}) annotation(
    Placement(visible = true, transformation(origin = {-58, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  FiliP.PNerweiterungen.PDwkeit Krankpruefer(enablingProbOut = {1-WkeitKrank, WkeitKrank},enablingType = PNlib.Types.EnablingType.Probability,nInDis = 2, nOutDis = 2)  annotation(
    Placement(visible = true, transformation(origin = {-26, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD Gesund(nInDis = 1, nOutDis = 1, timeValue = {0}) annotation(
    Placement(visible = true, transformation(origin = {4, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD Schicht(nInDis = 1, nOutDis = 1) annotation(
    Placement(visible = true, transformation(extent = {{24, 12}, {44, 32}}, rotation = 0)));
  PNlib.PN.Components.TD EndeSchicht(arcWeightOutCon = {SchichtDauer - SchichtPause}, nInDis = 2, nOutCon = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.Tact, timeValue = {(SchichtStart + SchichtDauer) / 24, 1}) annotation(
    Placement(visible = true, transformation(extent = {{60, 12}, {80, 32}}, rotation = 0)));
equation
  connect(Krank.outPlacesDis[1], Warkrank) annotation(
    Line(points = {{6, 78}, {4, 78}, {4, 110}, {4, 110}}, thickness = 0.5));
  connect(StationIn[2], Krank.inPlacesDis[2]) annotation(
    Line(points = {{90, 110}, {90, 110}, {90, 70}, {30, 70}, {30, 62}, {6, 62}, {6, 70}, {6, 70}}, thickness = 0.5));
  connect(Krank.inPlacesDis[1], Krankpruefer.outTransitionDis[2]) annotation(
    Line(points = {{6, 70}, {6, 70}, {6, 46}, {-14, 46}, {-14, 22}, {-16, 22}, {-16, 22}}, thickness = 0.5));
  connect(Einspringen.outPlacesDis[2], StationOut[2]) annotation(
    Line(points = {{-54, -12}, {-44, -12}, {-44, 84}, {-90, 84}, {-90, 110}, {-90, 110}}, thickness = 0.5));
  connect(StartSchicht.outPlacesDis[2], StationOut[1]) annotation(
    Line(points = {{-54, 22}, {-44, 22}, {-44, 84}, {-90, 84}, {-90, 110}, {-90, 110}}, thickness = 0.5));
  connect(Einspringen.inPlacesCon[1], ArbeitszeitIn[2]) annotation(
    Line(points = {{-62, -20}, {-88, -20}, {-88, -90}, {-110, -90}, {-110, -90}}, thickness = 0.5));
  connect(StartSchicht.inPlacesCon[1], ArbeitszeitIn[1]) annotation(
    Line(points = {{-62, 14}, {-88, 14}, {-88, -90}, {-110, -90}, {-110, -90}}, thickness = 0.5));
  connect(Einspringen.inPlacesDis[1], PersonalIn[2]) annotation(
    Line(points = {{-62, -12}, {-74, -12}, {-74, 22}, {-110, 22}, {-110, 22}}, thickness = 0.5));
  connect(StartSchicht.inPlacesDis[1], PersonalIn[1]) annotation(
    Line(points = {{-62, 22}, {-104, 22}, {-104, 22}, {-110, 22}}, thickness = 0.5));
  connect(EndeSchicht.inPlacesDis[2], StationIn[1]) annotation(
    Line(points = {{66, 22}, {56, 22}, {56, 70}, {90, 70}, {90, 110}, {90, 110}}, thickness = 0.5));
  connect(EndeSchicht.outPlacesCon[1], ArbeistzeitOut) annotation(
    Line(points = {{74, 14}, {92, 14}, {92, -92}, {110, -92}, {110, -90}}, thickness = 0.5));
  connect(EndeSchicht.outPlacesDis[1], PersonalOut) annotation(
    Line(points = {{74, 22}, {104, 22}, {104, 22}, {110, 22}}, thickness = 0.5));
  connect(Schicht.outTransitionDis[1], EndeSchicht.inPlacesDis[1]) annotation(
    Line(points = {{44.8, 22}, {64.8, 22}, {64.8, 22}, {66.8, 22}}, thickness = 0.5));
  connect(Gesund.outPlacesDis[1], Schicht.inTransitionDis[1]) annotation(
    Line(points = {{8.8, 22}, {22.8, 22}, {22.8, 22}, {24.8, 22}}, thickness = 0.5));
  connect(Einspringen.outPlacesDis[1], Krankpruefer.inTransitionDis[2]) annotation(
    Line(points = {{-51.2, -12}, {-36.2, -12}, {-36.2, 22}, {-32.2, 22}}, thickness = 0.5));
  connect(Krankpruefer.outTransitionDis[1], Gesund.inPlacesDis[1]) annotation(
    Line(points = {{-15.2, 22}, {-1.2, 22}, {-1.2, 22}, {0.8, 22}}, thickness = 0.5));
  connect(StartSchicht.outPlacesDis[1], Krankpruefer.inTransitionDis[1]) annotation(
    Line(points = {{-53.2, 22}, {-34.2, 22}}, thickness = 0.5));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
    Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.2), graphics = {Rectangle(origin = {0, -2}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 102}, {100, -98}}), Text(origin = {-28, 4}, extent = {{-70, 38}, {126, -40}}, textString = "%name")}));
end Schicht;
