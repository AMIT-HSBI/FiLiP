within PNlib.PN.Examples.Models.FiliP;
model Pflegekraft
  parameter Real Stelle = 1 "Was fuer eine Stelle" annotation(
    Dialog(enable = true, group = "Personaldaten"));
  //parameter Integer UrlaubsTage = 36 "Anzahl der Urlaubstage" annotation(Dialog(enable = true, group = "Personal Daten"));
  parameter Integer WEF = 1 "Welches Wochenende frei" annotation(
    Dialog(enable = true, group = "Personaldaten"),
    choices(choice = 1 "1. Wochenende", choice = 2 "2. Wochenende", choice = 3 "jedes Wochenende", __Dymola_radioButtons = true));
  parameter Real UrlaubStartTermine[:] = {10,20,30} "number of input places"annotation(Dialog(enable = true, group = "Personal Daten"));
  parameter Real UrlaubEndTermine[:] = {15,25,35} "number of input places"annotation(Dialog(enable = true, group = "Personal Daten"));
  parameter Real KrankDauer[:] = 1:31;
  parameter Real WkeitKrankDauer[:] = {75 / 237, 41 / 237, 24 / 237, 19 / 237, 22 / 237, 10 / 237, 13 / 237, 4 / 237, 2 / 237, 3 / 237, 2 / 237, 1 / 237, 3 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237};
  Real WkeitKrank =1  annotation(Dialog(enable = true, group = "Personal Daten"));
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

  Real HatFruehDienst=IstImFruehDienst.t;
  Real HatSpaetDienst=IstImSpaetDienst.t;
  Real HatNachtDienst=IstImNachtDienst.t;
  Boolean IstKrank=krankurlaub.Krank.TransitionDurationFire.value;
  Real HatUrlaubt=krankurlaub.ImUrlaub.t;
  Real HatWochenende=ImWochenEnde.t;
  Real HatRuhezeit=Ruhe.t;
  Real Dienstfaehig=Dienstbereit.t;
  Real ArbeitszeitKontingentPlanungsPeriode=ArbeitszeitKontingent.t;
  Real GeleisteteArbeistzeitGesammt=GeleisteteArbeistzeit.t;
  protected
  PNlib.PN.Components.PD IstImFruehDienst(nInDis = 1, nOutDis = 1) annotation(
    Placement(transformation(extent = {{-10, 240}, {10, 260}})));
  PNlib.PN.Components.PD IstImSpaetDienst(nInDis = 1, nOutDis = 1) annotation(
    Placement(transformation(extent = {{-10, 150}, {10, 170}})));
  PNlib.PN.Components.PD IstImNachtDienst(nInDis = 1, nOutDis = 1) annotation(
    Placement(transformation(extent = {{-10, 62}, {10, 82}})));
  PNlib.PN.Components.TD FSB( arcWeightInCon = {DauerFruehschicht - 0.5}, nInCon = 1, nInDis = 1,nOutDis = 2, timeType = PNlib.Types.TimeType.Tact, timeValue={BeginFruehschicht/24, 1}) annotation(
    Placement(transformation(extent = {{-94, 240}, {-74, 260}})));
  PNlib.PN.Components.TD SSB( arcWeightInCon = {DauerSpaetschicht - 0.5}, nInCon = 1, nInDis = 1,nOutDis = 2, timeType = PNlib.Types.TimeType.Tact, timeValue={BeginSpaetschicht/24, 1}) annotation(
    Placement(transformation(extent = {{-92, 150}, {-72, 170}})));
  PNlib.PN.Components.TD NSB( arcWeightInCon = {DauerNachtschicht - 0.75}, nInCon = 1, nInDis = 1,nOutDis = 2, timeType = PNlib.Types.TimeType.Tact, timeValue={BeginNachtschicht/24, 1}) annotation(
    Placement(transformation(extent = {{-94, 62}, {-74, 82}})));
  PNlib.PN.Components.TD FSE( arcWeightOutCon = {DauerFruehschicht - 0.5},nInDis = 2, nOutCon = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.Tact, timeValue = {(BeginFruehschicht + DauerFruehschicht) / 24, 1}) annotation(
    Placement(transformation(extent = {{74, 240}, {94, 260}})));
  PNlib.PN.Components.TD SSE( arcWeightOutCon = {DauerSpaetschicht - 0.5},nInDis = 2, nOutCon = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.Tact, timeValue = {(BeginSpaetschicht + DauerSpaetschicht) / 24, 1}) annotation(
    Placement(transformation(extent = {{74, 150}, {94, 170}})));
  PNlib.PN.Components.TD NSE( arcWeightOutCon = {DauerNachtschicht - 0.75},nInDis = 2, nOutCon = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.Tact, timeValue = {(BeginNachtschicht + DauerNachtschicht) / 24, 1}) annotation(
    Placement(transformation(extent = {{74, 62}, {94, 82}})));
  PNlib.PN.Components.PC GeleisteteArbeistzeit(nInDis = 3) annotation(
    Placement(visible = true, transformation(extent = {{202, 122}, {222, 142}}, rotation = 0)));
  PNlib.PN.Components.PD Ruhe(nOutDis = 2, nInDis = 3) annotation(
    Placement(transformation(extent = {{90, -90}, {70, -70}})));
  PNlib.PN.Components.PD Dienstbereit(nInDis = 1, nOutDis = 5, startTokens = 1) annotation(
    Placement(transformation(extent = {{-130, -88}, {-150, -68}})));
  PNlib.PN.Components.TD RuheZeitEnde(nInDis = 1, nOutDis = 1, timeValue = {11 / 24}) annotation(
    Placement(transformation(extent = {{62, -90}, {42, -70}})));
  PNlib.PN.Components.PC ArbeitszeitKontingent( nInDis = 1,nOutDis = 4, startTokens = if WEF == 2 then 57.75 * Stelle else 11 * Stelle) annotation(
    Placement(visible = true, transformation(extent = {{-266, 128}, {-246, 148}}, rotation = 0)));
  PNlib.PN.Interfaces.DisTransitionOut transitionOutDis[3] annotation(
    Placement(transformation(extent = {{-300, 154}, {-360, 252}})));
  PNlib.PN.Interfaces.DisTransitionIn transitionInDis[3] annotation(
    Placement(transformation(extent = {{360, 152}, {300, 250}})));
  PNlib.PN.Components.TD ArbeitszeitGeber( arcWeightInCon = {ArbeitszeitKontingent.t}, arcWeightOutCon = {2 * 38.5 * Stelle}, nInCon = 1,nOutCon = 1, timeType = PNlib.Types.TimeType.Tact, timeValue = {if WEF == 2 then 9 else 2, 14}) annotation(
    Placement(visible = true, transformation(origin = {-256, 88}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD WochenEndSignal(nOutDis = 1, timeType = PNlib.Types.TimeType.Tact,  timeValue={if WEF == 2 then 9 else 2,if WEF == 3 then 7 else 14}) annotation(
    Placement(transformation(extent = {{198, -278}, {178, -258}})));
  PNlib.PN.Components.TD WochenEndGeber2(nInDis = 2, nOutDis = 1, timeType = PNlib.Types.TimeType.Immediate, timeValue = {0}) annotation(
    Placement(transformation(extent = {{44, -192}, {24, -172}})));
  PNlib.PN.Components.TD WochenEndGeber1(nInDis = 2, nOutDis = 1, timeType = PNlib.Types.TimeType.Immediate, timeValue = {0}) annotation(
    Placement(transformation(extent = {{-130, -190}, {-110, -170}})));
  PNlib.PN.Components.PD SollInsWochenEnde(nOutDis = 3, nInDis = 1, maxTokens = 1) annotation(
    Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = -90, origin = {-8, -228})));
  PNlib.PN.Components.PD ImWochenEnde(nOutDis = 1, nInDis = 2) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-78, -158})));
  PNlib.PN.Components.TD WochenEndEnde(nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.Tact, timeValue={if WEF == 2 then 11 else 4, if WEF == 3 then 7 else 14}) annotation(
    Placement(transformation(extent = {{-34, -168}, {-14, -148}})));
  PNlib.PN.Components.TD EinTagWiederholer( nInDis = 1,nOutDis = 1, timeValue = {1}) annotation(
    Placement(transformation(extent = {{-58, -128}, {-38, -108}})));
  PNlib.PN.Components.TD WEenderbeiKrank(nInDis = 1, timeType = PNlib.Types.TimeType.Delay, timeValue = {2 - 0.1}) annotation(
    Placement(transformation(extent = {{102, -228}, {122, -208}})));
  PNlib.PN.Examples.Models.FiliP.KrankUrlaub krankurlaub (UrlaubEndTermine = UrlaubEndTermine, UrlaubStartTermine = UrlaubStartTermine, WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank)  annotation(
    Placement(visible = true, transformation(origin = {-80, -78}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  outer PNlib.PN.Components.Settings settings "global settings for animation and display";
equation
  connect(GeleisteteArbeistzeit.inTransitionDis[3], FSE.outPlacesCon[1]) annotation(
    Line(points = {{204, 124}, {156, 124}, {156, 242}, {88, 242}, {88, 242}}, thickness = 0.5));
  connect(GeleisteteArbeistzeit.inTransitionDis[2], SSE.outPlacesCon[1]) annotation(
    Line(points = {{204, 124}, {156, 124}, {156, 150}, {88, 150}, {88, 152}}, thickness = 0.5));
  connect(GeleisteteArbeistzeit.inTransitionDis[1], NSE.outPlacesCon[1]) annotation(
    Line(points = {{204, 124}, {156, 124}, {156, 64}, {88, 64}, {88, 64}}, thickness = 0.5));
  connect(ArbeitszeitGeber.outPlacesCon[1], ArbeitszeitKontingent.inTransitionDis[1]) annotation(
    Line(points = {{-260.8, 81.2}, {-276.8, 81.2}, {-276.8, 131.2}, {-264.8, 131.2}, {-264.8, 131.2}}, thickness = 0.5));
  connect(ArbeitszeitKontingent.outTransitionDis[1], ArbeitszeitGeber.inPlacesCon[1]) annotation(
    Line(points = {{-248.4, 130.8}, {-238.4, 130.8}, {-238.4, 78.8}, {-252.4, 78.8}, {-252.4, 80.8}}, thickness = 0.5));
  connect(ArbeitszeitKontingent.outTransitionDis[4], FSB.inPlacesCon[1]) annotation(
    Line(points = {{-248, 133}, {-202, 133}, {-202, 242}, {-88, 242}}, thickness = 0.5));
  connect(ArbeitszeitKontingent.outTransitionDis[3], SSB.inPlacesCon[1]) annotation(
    Line(points = {{-248, 133}, {-202, 133}, {-202, 150}, {-86, 150}, {-86, 152}}, thickness = 0.5));
  connect(ArbeitszeitKontingent.outTransitionDis[2], NSB.inPlacesCon[1]) annotation(
    Line(points = {{-248, 133}, {-202, 133}, {-202, 64}, {-88, 64}}, thickness = 0.5));
  connect(WochenEndEnde.outPlacesDis[1], krankurlaub.placeInDis[3]) annotation(
    Line(points = {{-20, -158}, {0, -158}, {0, -80}, {-52, -80}, {-52, -78}, {-56, -78}}, thickness = 0.5));
  connect(EinTagWiederholer.outPlacesDis[1], krankurlaub.placeInDis[2]) annotation(
    Line(points = {{-44, -118}, {-20, -118}, {-20, -80}, {-56, -80}, {-56, -78}}, thickness = 0.5));
  connect(RuheZeitEnde.outPlacesDis[1], krankurlaub.placeInDis[1]) annotation(
    Line(points = {{48, -80}, {-54, -80}, {-54, -78}, {-56, -78}}, thickness = 0.5));
  connect(krankurlaub.transitionOutDis, Dienstbereit.inTransitionDis[1]) annotation(
    Line(points = {{-104, -80}, {-118, -80}, {-118, -78}, {-130, -78}}));
  connect(FSB.outPlacesDis[1], IstImFruehDienst.inTransitionDis[1]) annotation(
    Line(points = {{-79.2, 250}, {-10.8, 250}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(IstImFruehDienst.outTransitionDis[1], FSE.inPlacesDis[1]) annotation(
    Line(points = {{10.8, 250}, {79.2, 250}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(SSB.outPlacesDis[1], IstImSpaetDienst.inTransitionDis[1]) annotation(
    Line(points = {{-77.2, 160}, {-10.8, 160}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(SSE.inPlacesDis[1], IstImSpaetDienst.outTransitionDis[1]) annotation(
    Line(points = {{79.2, 160}, {46, 160}, {46, 160}, {10.8, 160}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(NSB.outPlacesDis[1], IstImNachtDienst.inTransitionDis[1]) annotation(
    Line(points = {{-79.2, 72}, {-10.8, 72}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(IstImNachtDienst.outTransitionDis[1], NSE.inPlacesDis[1]) annotation(
    Line(points = {{10.8, 72}, {79.2, 72}}, color = {0, 0, 0}, smooth = Smooth.None));

    connect(FSB.outPlacesDis[2], transitionOutDis[1]) annotation(
      Line(points = {{-79.2, 250}, {-56, 250}, {-56, 294}, {-262, 294}, {-262, 203}, {-330, 203}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(SSB.outPlacesDis[2], transitionOutDis[2]) annotation(
      Line(points = {{-77.2, 160}, {-42, 160}, {-42, 298}, {-280, 298}, {-280, 203}, {-330, 203}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(NSB.outPlacesDis[2], transitionOutDis[3]) annotation(
      Line(points = {{-79.2, 72}, {-79.2, 54}, {-66, 54}, {-66, 276}, {-248, 276}, {-248, 203}, {-330, 203}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(FSE.inPlacesDis[2], transitionInDis[1]) annotation(
      Line(points = {{79.2, 250}, {44, 250}, {44, 278}, {282, 278}, {282, 201}, {330, 201}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(SSE.inPlacesDis[2], transitionInDis[2]) annotation(
      Line(points = {{79.2, 160}, {48, 160}, {48, 190}, {172, 190}, {172, 201}, {330, 201}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(NSE.inPlacesDis[2], transitionInDis[3]) annotation(
      Line(points = {{79.2, 72}, {54, 72}, {54, 201}, {330, 201}}, color = {0, 0, 0}, smooth = Smooth.None));

  connect(Ruhe.outTransitionDis[1], RuheZeitEnde.inPlacesDis[1]) annotation(
    Line(points = {{69.2, -80.5}, {56.8, -80}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(Ruhe.inTransitionDis[1], NSE.outPlacesDis[1]) annotation(
    Line(points = {{90.8, -80.6667}, {114.8, -80.6667}, {114.8, 71.5}, {88.8, 71.5}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(SSE.outPlacesDis[1], Ruhe.inTransitionDis[2]) annotation(
    Line(points = {{88.8, 159.5}, {122, 159.5}, {122, -80}, {90.8, -80}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(FSE.outPlacesDis[1], Ruhe.inTransitionDis[3]) annotation(
    Line(points = {{88.8, 249.5}, {130, 249.5}, {130, -79.3333}, {90.8, -79.3333}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(Dienstbereit.outTransitionDis[1], NSB.inPlacesDis[1]) annotation(
    Line(points = {{-150.8, -78.8}, {-164, -78.8}, {-164, 71.5}, {-88.8, 71.5}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(SSB.inPlacesDis[1], Dienstbereit.outTransitionDis[2]) annotation(
    Line(points = {{-86.8, 159.5}, {-172, 159.5}, {-172, -78.4}, {-150.8, -78.4}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(FSB.inPlacesDis[1], Dienstbereit.outTransitionDis[3]) annotation(
    Line(points = {{-88.8, 249.5}, {-186, 249.5}, {-186, -78}, {-150.8, -78}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(WochenEndEnde.inPlacesDis[1], ImWochenEnde.outTransitionDis[1]) annotation(
    Line(points = {{-28.8, -158}, {-67.2, -158}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(WochenEndGeber1.inPlacesDis[1], Dienstbereit.outTransitionDis[4]) annotation(
    Line(points = {{-124.8, -180.5}, {-170, -180.5}, {-170, -77.6}, {-150.8, -77.6}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(WochenEndGeber2.inPlacesDis[1], Ruhe.outTransitionDis[2]) annotation(
    Line(points = {{38.8, -182.5}, {64, -182.5}, {64, -79.5}, {69.2, -79.5}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(SollInsWochenEnde.outTransitionDis[1], WochenEndGeber1.inPlacesDis[2]) annotation(
    Line(points = {{-8.66667, -217.2}, {-144, -217.2}, {-144, -179.5}, {-124.8, -179.5}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(SollInsWochenEnde.outTransitionDis[2], WochenEndGeber2.inPlacesDis[2]) annotation(
    Line(points = {{-8, -217.2}, {83, -217.2}, {83, -181.5}, {38.8, -181.5}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(WochenEndGeber1.outPlacesDis[1], ImWochenEnde.inTransitionDis[1]) annotation(
    Line(points = {{-115.2, -180}, {-104.6, -180}, {-104.6, -158.5}, {-88.8, -158.5}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(WochenEndGeber2.outPlacesDis[1], ImWochenEnde.inTransitionDis[2]) annotation(
    Line(points = {{29.2, -182}, {-98, -182}, {-98, -157.5}, {-88.8, -157.5}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(WochenEndSignal.outPlacesDis[1], SollInsWochenEnde.inTransitionDis[1]) annotation(
    Line(points = {{183.2, -268}, {88, -268}, {88, -238.8}, {-8, -238.8}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(EinTagWiederholer.inPlacesDis[1], Dienstbereit.outTransitionDis[5]) annotation(
    Line(points = {{-52.8, -118}, {-156, -118}, {-156, -77.2}, {-150.8, -77.2}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(WEenderbeiKrank.inPlacesDis[1], SollInsWochenEnde.outTransitionDis[3]) annotation(
    Line(points = {{107.2, -218}, {50, -218}, {50, -217.2}, {-7.33333, -217.2}}, color = {0, 0, 0}, smooth = Smooth.None));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-300, -300}, {300, 300}}, initialScale = 0.1), graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-300, 300}, {300, -302}}), Line(points = {{-160, -100}, {158, -100}, {78, 0}, {-78, 0}, {-158, -100}}), Rectangle(extent = {{-76, 0}, {80, 138}}), Rectangle(extent = {{-20, 138}, {20, 160}}), Ellipse(extent = {{-72, 286}, {74, 160}}, endAngle = 360), Ellipse(extent = {{116, 134}, {80, 4}}, endAngle = 360), Ellipse(fillPattern = FillPattern.Solid, extent = {{-40, 260}, {-16, 236}}, endAngle = 360), Rectangle(fillColor = {255, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-8, -20}, {8, -80}}), Ellipse(extent = {{-62, -100}, {-10, -282}}, endAngle = 360), Ellipse(extent = {{12, -100}, {64, -282}}, endAngle = 360), Ellipse(fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-44, 196}, {46, 184}}, endAngle = 360), Ellipse(fillPattern = FillPattern.Solid, extent = {{18, 260}, {42, 236}}, endAngle = 360), Rectangle(extent = {{-8, 228}, {12, 214}}), Ellipse(extent = {{-76, 134}, {-112, 4}}, endAngle = 360), Rectangle(origin = {0, -50}, rotation = 90, fillColor = {255, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-8, 30}, {8, -30}}), Text(extent = {{-314, 470}, {290, 304}}, textString = "%name")}),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-300, -300}, {300, 300}}, initialScale = 0.1), graphics));
end Pflegekraft;
