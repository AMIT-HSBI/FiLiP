within FiliP;

model PflegekraftUrlaubRandom
  // Ausgabe Groeßen
  PNlib.PN.Interfaces.IntegerConIn HatSchicht1(value = schicht1.Schicht.t);
  PNlib.PN.Interfaces.IntegerConIn HatSchicht2(value = schicht2.Schicht.t) if AnzahlSchichten > 1;
  PNlib.PN.Interfaces.IntegerConIn HatSchicht3(value = schicht3.Schicht.t) if AnzahlSchichten > 2;
  PNlib.PN.Interfaces.IntegerConIn HatSchicht4(value = schicht4.Schicht.t) if AnzahlSchichten > 3;
  PNlib.PN.Interfaces.IntegerConIn HatSchicht5(value = schicht5.Schicht.t) if AnzahlSchichten > 4;
  PNlib.PN.Interfaces.IntegerConIn HatSchicht6(value = schicht6.Schicht.t) if AnzahlSchichten > 5;
  PNlib.PN.Interfaces.IntegerConIn EinspringenSchicht1(value = schicht1.Einspringen.nFire);
  PNlib.PN.Interfaces.IntegerConIn EinspringenSchicht2(value = schicht2.Einspringen.nFire) if AnzahlSchichten > 1;
  PNlib.PN.Interfaces.IntegerConIn EinspringenSchicht3(value = schicht3.Einspringen.nFire) if AnzahlSchichten > 2;
  PNlib.PN.Interfaces.IntegerConIn EinspringenSchicht4(value = schicht4.Einspringen.nFire) if AnzahlSchichten > 3;
  PNlib.PN.Interfaces.IntegerConIn EinspringenSchicht5(value = schicht5.Einspringen.nFire) if AnzahlSchichten > 4;
  PNlib.PN.Interfaces.IntegerConIn EinspringenSchicht6(value = schicht6.Einspringen.nFire) if AnzahlSchichten > 5;
  FiliP.PNerweiterungen.KrankConOut Krank;
  Real HatUrlaubt = urlaub.ImUrlaub.t;
  Real HatWochenende = wochenEnde.ImWochenEnde.t;
  Real HatRuhezeit = Ruhe.t;
  Real Dienstfaehig = Dienstbereit.t;
  Real ArbeitszeitKontingentPlanungsPeriode = ArbeitszeitKontingent.t;
  Real GeleisteteArbeistzeitGesammt = GeleisteteArbeistzeit.t;
  PNlib.PN.Interfaces.DisTransitionOut UrlaubKopfOut annotation(
    Placement(visible = true, transformation(origin = {321, -237}, extent = {{-21, -21}, {21, 21}}, rotation = 0), iconTransformation(origin = {318, -240}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  PNlib.PN.Interfaces.DisTransitionIn UrlaubKopfIn annotation(
    Placement(visible = true, transformation(origin = {319, -39}, extent = {{19, -19}, {-19, 19}}, rotation = 0), iconTransformation(origin = {318, -42}, extent = {{18, -18}, {-18, 18}}, rotation = 0)));
  PNlib.PN.Interfaces.HybTransitionIn UrlaubStelleIn annotation(
    Placement(visible = true, transformation(origin = {320, 18}, extent = {{20, -20}, {-20, 20}}, rotation = 0), iconTransformation(origin = {319, 19}, extent = {{19, -19}, {-19, 19}}, rotation = 0)));
  PNlib.PN.Interfaces.HybTransitionOut UrlaubStelleOut annotation(
    Placement(visible = true, transformation(origin = {319, -179}, extent = {{-21, -21}, {21, 21}}, rotation = 0), iconTransformation(origin = {320, -178}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
protected
  // Strucktur veraendernde Variablen
  parameter Integer AnzahlSchichten = 3;
  // Nicht Strucktur veraendernde Variablen
  // Pool?, EinSpringen?, Defizit
  parameter Real MessZeit =0.2;
  // Schicht Start, Schicht Dauer, Pausen Dauer
  parameter Real Schichtzeiten[:, 3] = {{6, 8.2, 0.5}, {12.3, 8.2, 0.5}, {20.25, 10, 0.75}} annotation(
    Dialog(enable = true, group = "Schichten"));
  parameter Boolean KannInSchichtArbeiten [:]={true,true,true,true,true,true}annotation(
    Dialog(enable = true, group = "Schichten"));
  parameter Boolean SpringtEinInSchicht [:]={true,true,true,true,true,true}annotation(
    Dialog(enable = true, group = "Schichten"));
  parameter Real VKstundenWoche = 38.5 "Was fuer eine Stelle" annotation(
    Dialog(enable = true, group = "Personaldaten"));
  parameter Real Stelle = 1 "Was fuer eine Stelle" annotation(
    Dialog(enable = true, group = "Personaldaten"));
  parameter Real StartWochenEnde = 6 "Start des 1. Wochenendes" annotation(
    Dialog(enable = true, group = "Wochenenddaten"));
  parameter Real DauerWochenEnde = 2 "Dauer eines Wochenendes" annotation(
    Dialog(enable = true, group = "Wochenenddaten"));
  parameter Real IntervallWochenEnde = 14 "Intervall der Wochenenden" annotation(
    Dialog(enable = true, group = "Wochenenddaten"));
  parameter Real AnzahlWochenEnden = 52 "Anzahl Freiher Wochenenden im Jahr" annotation(
    Dialog(enable = true, group = "Wochenenddaten"));
  parameter Boolean NichtWochenEnde = false "fuer nicht 2 wochen Rytmus" annotation(
    Dialog(enable = true, group = "Wochenenddaten"));
  parameter Real StartNichtWochenEnde = 13 "Start des 1. Arbeits Wochenendes" annotation(
    Dialog(enable = true, group = "Wochenenddaten"));
  parameter Real IntervallNichtWochenEnde = 14 "Intervall der Arbeits Wochenenden" annotation(
    Dialog(enable = true, group = "Wochenenddaten"));
  parameter Integer AnzahlUrlaubsWochen=6;
  parameter Real KrankDauer[:] = 1:31 annotation(
    Dialog(enable = true, group = "Krankheits Daten"));
  parameter Real WkeitKrankDauer[:] = {75 / 237, 41 / 237, 24 / 237, 19 / 237, 22 / 237, 10 / 237, 13 / 237, 4 / 237, 2 / 237, 3 / 237, 2 / 237, 1 / 237, 3 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237} annotation(
    Dialog(enable = true, group = "Krankheits Daten"));
  Real WkeitKrank = 0.03 annotation(
    Dialog(enable = true, group = "Krankheits Daten"));
  // Petri Netz
  PNlib.PN.Interfaces.DisTransitionOut transitionOutDis[AnzahlSchichten * 2] annotation(
    Placement(transformation(extent = {{-300, 154}, {-360, 252}})));
  PNlib.PN.Interfaces.DisTransitionIn transitionInDis[AnzahlSchichten * 2] annotation(
    Placement(transformation(extent = {{360, 152}, {300, 250}})));
  PNlib.PN.Components.TD ZeitVernichter(arcWeightInCon = {VKstundenWoche * Stelle / 7}, firingCon = urlaub.ImUrlaub.t > 0 or Krank.value, nInCon = 1) annotation(
    Placement(visible = true, transformation(origin = {-202, 164}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD Dienstbereit(nInDis = 1 + AnzahlSchichten, nOutDis = 2 + AnzahlSchichten * 2, startTokens = 1) annotation(
    Placement(transformation(extent = {{-130, -88}, {-150, -68}})));
  PNlib.PN.Components.PC GeleisteteArbeistzeit(nInDis = AnzahlSchichten) annotation(
    Placement(visible = true, transformation(extent = {{202, 122}, {222, 142}}, rotation = 0)));
  PNlib.PN.Components.PD Ruhe(nOutDis = 2, nInDis = AnzahlSchichten) annotation(
    Placement(transformation(extent = {{90, -90}, {70, -70}})));
  PNlib.PN.Components.PC ArbeitszeitKontingent(nInDis = 1, nOutDis = 2 + AnzahlSchichten * 2, startTokens = 4 * VKstundenWoche * Stelle) annotation(
    Placement(visible = true, transformation(extent = {{-266, 128}, {-246, 148}}, rotation = 0)));
  FiliP.Schicht schicht1(KannInSchichtArbeiten = KannInSchichtArbeiten[1], KrankDauer = KrankDauer, MessZeit = MessZeit,SchichtDauer = Schichtzeiten[1, 2], SchichtPause = Schichtzeiten[1, 3], SchichtStart = Schichtzeiten[1, 1], SpringtEinInSchicht = SpringtEinInSchicht[1], WkeitKrank = WkeitKrank, WkeitKrankDauer = WkeitKrankDauer) annotation(
    Placement(visible = true, transformation(origin = {28, 216}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  FiliP.Schicht schicht2(KannInSchichtArbeiten = KannInSchichtArbeiten[2], KrankDauer = KrankDauer, MessZeit = MessZeit,SchichtDauer = Schichtzeiten[2, 2], SchichtPause = Schichtzeiten[2, 3], SchichtStart = Schichtzeiten[2, 1], SpringtEinInSchicht = SpringtEinInSchicht[2], WkeitKrank = WkeitKrank, WkeitKrankDauer = WkeitKrankDauer) if AnzahlSchichten > 1 annotation(
    Placement(visible = true, transformation(origin = {28, 166}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  FiliP.Schicht schicht3(KannInSchichtArbeiten = KannInSchichtArbeiten[3], KrankDauer = KrankDauer, MessZeit = MessZeit,SchichtDauer = Schichtzeiten[3, 2], SchichtPause = Schichtzeiten[3, 3], SchichtStart = Schichtzeiten[3, 1], SpringtEinInSchicht = SpringtEinInSchicht[3], WkeitKrank = WkeitKrank, WkeitKrankDauer = WkeitKrankDauer) if AnzahlSchichten > 2 annotation(
    Placement(visible = true, transformation(origin = {28, 114}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  FiliP.Schicht schicht4(KannInSchichtArbeiten = KannInSchichtArbeiten[4], KrankDauer = KrankDauer, MessZeit = MessZeit,SchichtDauer = Schichtzeiten[4, 2], SchichtPause = Schichtzeiten[4, 3], SchichtStart = Schichtzeiten[4, 1], SpringtEinInSchicht = SpringtEinInSchicht[4], WkeitKrank = WkeitKrank, WkeitKrankDauer = WkeitKrankDauer) if AnzahlSchichten > 3 annotation(
    Placement(visible = true, transformation(origin = {-26, 64}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  FiliP.Schicht schicht5(KannInSchichtArbeiten = KannInSchichtArbeiten[5], KrankDauer = KrankDauer, MessZeit = MessZeit,SchichtDauer = Schichtzeiten[5, 2], SchichtPause = Schichtzeiten[5, 3], SchichtStart = Schichtzeiten[5, 1], SpringtEinInSchicht = SpringtEinInSchicht[5], WkeitKrank = WkeitKrank, WkeitKrankDauer = WkeitKrankDauer) if AnzahlSchichten > 4 annotation(
    Placement(visible = true, transformation(origin = {28, 64}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  FiliP.Schicht schicht6(KannInSchichtArbeiten = KannInSchichtArbeiten[6], KrankDauer = KrankDauer, MessZeit = MessZeit,SchichtDauer = Schichtzeiten[6, 2], SchichtPause = Schichtzeiten[6, 3], SchichtStart = Schichtzeiten[6, 1], SpringtEinInSchicht = SpringtEinInSchicht[6], WkeitKrank = WkeitKrank, WkeitKrankDauer = WkeitKrankDauer) if AnzahlSchichten > 5 annotation(
    Placement(visible = true, transformation(origin = {84, 64}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PNlib.PN.Components.TD RuheZeitEnde(nInDis = 1, nOutDis = 1, timeValue = {11 / 24}) annotation(
    Placement(transformation(extent = {{62, -90}, {42, -70}})));
  PNlib.PN.Components.TD ArbeitszeitGeber(arcWeightInCon = {ArbeitszeitKontingent.t}, arcWeightOutCon = {4 * VKstundenWoche * Stelle}, nInCon = 1, nOutCon = 1, timeType = PNlib.Types.TimeType.Tact, timeValue = {28, 28}) annotation(
    Placement(visible = true, transformation(origin = {-256, 88}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD EinTagWiederholer(nInDis = 1, nOutDis = 1, timeValue = {1}) annotation(
    Placement(transformation(extent = {{-58, -128}, {-38, -108}})));
  FiliP.UrlaubRandom urlaub(Stelle=Stelle,AnzahlUrlaubsWochen=AnzahlUrlaubsWochen) annotation(
    Placement(visible = true, transformation(origin = {-80, -78}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  FiliP.WochenEnde wochenEnde(DauerWochenEnde = DauerWochenEnde, IntervallNichtWochenEnde = IntervallNichtWochenEnde, IntervallWochenEnde = IntervallWochenEnde, NichtWochenEnde = NichtWochenEnde, StartNichtWochenEnde = StartNichtWochenEnde, StartWochenEnde = StartWochenEnde)  annotation(
    Placement(visible = true, transformation(origin = {-30, -178}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  // Hilf Connectoren
  FiliP.PNerweiterungen.KrankConIn KrankIn1(value = schicht1.Krank.TransitionDurationFire.value) if AnzahlSchichten == 1;
  FiliP.PNerweiterungen.KrankConIn KrankIn2(value = schicht1.Krank.TransitionDurationFire.value or schicht1.Krank.TransitionDurationFire.value) if AnzahlSchichten == 2;
  FiliP.PNerweiterungen.KrankConIn KrankIn3(value = schicht1.Krank.TransitionDurationFire.value or schicht2.Krank.TransitionDurationFire.value or schicht3.Krank.TransitionDurationFire.value) if AnzahlSchichten == 3;
  FiliP.PNerweiterungen.KrankConIn KrankIn4(value = schicht1.Krank.TransitionDurationFire.value or schicht2.Krank.TransitionDurationFire.value or schicht3.Krank.TransitionDurationFire.value or schicht4.Krank.TransitionDurationFire.value) if AnzahlSchichten == 4;
  FiliP.PNerweiterungen.KrankConIn KrankIn5(value = schicht1.Krank.TransitionDurationFire.value or schicht2.Krank.TransitionDurationFire.value or schicht3.Krank.TransitionDurationFire.value or schicht4.Krank.TransitionDurationFire.value or schicht5.Krank.TransitionDurationFire.value) if AnzahlSchichten == 5;
  FiliP.PNerweiterungen.KrankConIn KrankIn6(value = schicht1.Krank.TransitionDurationFire.value or schicht2.Krank.TransitionDurationFire.value or schicht3.Krank.TransitionDurationFire.value or schicht4.Krank.TransitionDurationFire.value or schicht5.Krank.TransitionDurationFire.value or schicht6.Krank.TransitionDurationFire.value) if AnzahlSchichten == 6;
  outer PNlib.PN.Components.Settings settings "global settings for animation and display";
equation
  connect(urlaub.UrlaubStelleIn, UrlaubStelleIn) annotation(
    Line(points = {{-96, -54}, {240, -54}, {240, 20}, {320, 20}, {320, 18}}));
  connect(urlaub.UrlaubKopfIn, UrlaubKopfIn) annotation(
    Line(points = {{-86, -54}, {240, -54}, {240, -38}, {312, -38}, {312, -38}, {320, -38}}));
  connect(urlaub.UrlaubStellenOut, UrlaubStelleOut) annotation(
    Line(points = {{-74, -54}, {160, -54}, {160, -178}, {320, -178}, {320, -178}}));
  connect(urlaub.UrlaubKopfOut, UrlaubKopfOut) annotation(
    Line(points = {{-64, -54}, {160, -54}, {160, -240}, {304, -240}, {304, -236}, {322, -236}}));

  connect(KrankIn1, Krank);
  connect(KrankIn2, Krank);
  connect(KrankIn3, Krank);
  connect(KrankIn4, Krank);
  connect(KrankIn5, Krank);
  connect(KrankIn6, Krank);
//Schicht 1
  connect(schicht1.PersonalIn[2], Dienstbereit.outTransitionDis[4]) annotation(
    Line(points = {{6, 216}, {-150, 216}, {-150, -78}, {-150, -78}}, thickness = 0.5));
  connect(schicht1.PersonalIn[1], Dienstbereit.outTransitionDis[3]) annotation(
    Line(points = {{6, 216}, {-150, 216}, {-150, -78}, {-150, -78}, {-150, -78}}, thickness = 0.5));
  connect(ArbeitszeitKontingent.outTransitionDis[4], schicht1.ArbeitszeitIn[2]) annotation(
    Line(points = {{-248, 130}, {-20, 130}, {-20, 198}, {6, 198}, {6, 198}}, thickness = 0.5));
  connect(ArbeitszeitKontingent.outTransitionDis[3], schicht1.ArbeitszeitIn[1]) annotation(
    Line(points = {{-248, 130}, {-20, 130}, {-20, 198}, {6, 198}, {6, 198}}, thickness = 0.5));
  connect(schicht1.PersonalOut, Ruhe.inTransitionDis[1]) annotation(
    Line(points = {{50, 216}, {114, 216}, {114, -80}, {90, -80}, {90, -80}}));
  connect(schicht1.ArbeistzeitOut, GeleisteteArbeistzeit.inTransitionDis[1]) annotation(
    Line(points = {{50, 198}, {186, 198}, {186, 126}, {204, 126}, {204, 124}}));
  connect(schicht1.StationIn[1], transitionInDis[1]) annotation(
    Line(points = {{46, 238}, {318, 238}, {318, 202}, {330, 202}}));
  connect(schicht1.StationIn[2], transitionInDis[2]);
  connect(schicht1.StationOut[2], transitionOutDis[2]) annotation(
    Line(points = {{10, 238}, {-306, 238}, {-306, 204}, {-330, 204}}, thickness = 0.5));
  connect(schicht1.StationOut[1], transitionOutDis[1]) annotation(
    Line(points = {{10, 238}, {-302, 238}, {-302, 204}, {-330, 204}}, thickness = 0.5));
  connect(schicht1.Warkrank, Dienstbereit.inTransitionDis[2]) annotation(
    Line(points = {{28, 238}, {26, 238}, {26, 282}, {-94, 282}, {-94, -36}, {-130, -36}, {-130, -78}, {-130, -78}}));
//Schicht 2
  connect(schicht2.PersonalIn[2], Dienstbereit.outTransitionDis[6]);
  connect(schicht2.PersonalIn[1], Dienstbereit.outTransitionDis[5]);
  connect(ArbeitszeitKontingent.outTransitionDis[6], schicht2.ArbeitszeitIn[2]);
  connect(ArbeitszeitKontingent.outTransitionDis[5], schicht2.ArbeitszeitIn[1]);
  connect(schicht2.PersonalOut, Ruhe.inTransitionDis[2]);
  connect(schicht2.ArbeistzeitOut, GeleisteteArbeistzeit.inTransitionDis[2]);
  connect(schicht2.StationIn[1], transitionInDis[3]);
  connect(schicht2.StationIn[2], transitionInDis[4]);
  connect(schicht2.StationOut[2], transitionOutDis[4]);
  connect(schicht2.StationOut[1], transitionOutDis[3]);
  connect(schicht2.Warkrank, Dienstbereit.inTransitionDis[3]);
//Schicht 3
  connect(schicht3.PersonalIn[2], Dienstbereit.outTransitionDis[8]);
  connect(schicht3.PersonalIn[1], Dienstbereit.outTransitionDis[7]);
  connect(ArbeitszeitKontingent.outTransitionDis[8], schicht3.ArbeitszeitIn[2]);
  connect(ArbeitszeitKontingent.outTransitionDis[7], schicht3.ArbeitszeitIn[1]);
  connect(schicht3.PersonalOut, Ruhe.inTransitionDis[3]);
  connect(schicht3.ArbeistzeitOut, GeleisteteArbeistzeit.inTransitionDis[3]);
  connect(schicht3.StationIn[1], transitionInDis[5]);
  connect(schicht3.StationIn[2], transitionInDis[6]);
  connect(schicht3.StationOut[2], transitionOutDis[6]);
  connect(schicht3.StationOut[1], transitionOutDis[5]);
  connect(schicht3.Warkrank, Dienstbereit.inTransitionDis[4]);
//Schicht 4
  connect(schicht4.PersonalIn[2], Dienstbereit.outTransitionDis[10]);
  connect(schicht4.PersonalIn[1], Dienstbereit.outTransitionDis[9]);
  connect(ArbeitszeitKontingent.outTransitionDis[10], schicht4.ArbeitszeitIn[2]);
  connect(ArbeitszeitKontingent.outTransitionDis[9], schicht4.ArbeitszeitIn[1]);
  connect(schicht4.PersonalOut, Ruhe.inTransitionDis[4]);
  connect(schicht4.ArbeistzeitOut, GeleisteteArbeistzeit.inTransitionDis[4]);
  connect(schicht4.StationIn[1], transitionInDis[7]);
  connect(schicht4.StationIn[2], transitionInDis[8]);
  connect(schicht4.StationOut[2], transitionOutDis[8]);
  connect(schicht4.StationOut[1], transitionOutDis[7]);
  connect(schicht4.Warkrank, Dienstbereit.inTransitionDis[5]);
//Schicht 5
  connect(schicht5.PersonalIn[2], Dienstbereit.outTransitionDis[12]);
  connect(schicht5.PersonalIn[1], Dienstbereit.outTransitionDis[11]);
  connect(ArbeitszeitKontingent.outTransitionDis[12], schicht5.ArbeitszeitIn[2]);
  connect(ArbeitszeitKontingent.outTransitionDis[11], schicht5.ArbeitszeitIn[1]);
  connect(schicht5.PersonalOut, Ruhe.inTransitionDis[5]);
  connect(schicht5.ArbeistzeitOut, GeleisteteArbeistzeit.inTransitionDis[5]);
  connect(schicht5.StationIn[1], transitionInDis[9]);
  connect(schicht5.StationIn[2], transitionInDis[10]);
  connect(schicht5.StationOut[2], transitionOutDis[10]);
  connect(schicht5.StationOut[1], transitionOutDis[9]);
  connect(schicht5.Warkrank, Dienstbereit.inTransitionDis[6]);
//Schicht 6
  connect(schicht6.PersonalIn[2], Dienstbereit.outTransitionDis[14]);
  connect(schicht6.PersonalIn[1], Dienstbereit.outTransitionDis[13]);
  connect(ArbeitszeitKontingent.outTransitionDis[14], schicht6.ArbeitszeitIn[2]);
  connect(ArbeitszeitKontingent.outTransitionDis[13], schicht6.ArbeitszeitIn[1]);
  connect(schicht6.PersonalOut, Ruhe.inTransitionDis[6]);
  connect(schicht6.ArbeistzeitOut, GeleisteteArbeistzeit.inTransitionDis[6]);
  connect(schicht6.StationIn[1], transitionInDis[11]);
  connect(schicht6.StationIn[2], transitionInDis[12]);
  connect(schicht6.StationOut[2], transitionOutDis[12]);
  connect(schicht6.StationOut[1], transitionOutDis[11]);
  connect(schicht6.Warkrank, Dienstbereit.inTransitionDis[7]);
// Weiter Conectoren
  connect(ZeitVernichter.inPlacesCon[1], ArbeitszeitKontingent.outTransitionDis[2]) annotation(
    Line(points = {{-206, 156}, {-224, 156}, {-224, 130}, {-248, 130}, {-248, 130}}, thickness = 0.5));
  connect(Dienstbereit.outTransitionDis[1], wochenEnde.WESignal1) annotation(
    Line(points = {{-150, -78}, {-174, -78}, {-174, -178}, {-52, -178}, {-52, -178}}, thickness = 0.5));
  connect(wochenEnde.WESignal2, Ruhe.outTransitionDis[2]) annotation(
    Line(points = {{-8, -178}, {64, -178}, {64, -80}, {68, -80}, {68, -80}, {70, -80}}));
  connect(wochenEnde.WEende, urlaub.placeInDis[3]) annotation(
    Line(points = {{-8, -160}, {-2, -160}, {-2, -78}, {-56, -78}, {-56, -78}}));
  connect(transitionInDis[2], schicht1.StationIn[2]) annotation(
    Line(points = {{330, 202}, {318, 202}, {318, 240}, {46, 240}, {46, 238}}, thickness = 0.5));
  connect(ArbeitszeitGeber.outPlacesCon[1], ArbeitszeitKontingent.inTransitionDis[1]) annotation(
    Line(points = {{-260.8, 81.2}, {-276.8, 81.2}, {-276.8, 131.2}, {-264.8, 131.2}, {-264.8, 131.2}}, thickness = 0.5));
  connect(ArbeitszeitKontingent.outTransitionDis[1], ArbeitszeitGeber.inPlacesCon[1]) annotation(
      Line(points = {{-248.4, 130.8}, {-238.4, 130.8}, {-238.4, 78.8}, {-252.4, 78.8}, {-252.4, 80.8}}, thickness = 0.5));
  connect(EinTagWiederholer.outPlacesDis[1], urlaub.placeInDis[2]) annotation(
    Line(points = {{-44, -118}, {-20, -118}, {-20, -80}, {-56, -80}, {-56, -78}}, thickness = 0.5));
  connect(RuheZeitEnde.outPlacesDis[1], urlaub.placeInDis[1]) annotation(
    Line(points = {{48, -80}, {-54, -80}, {-54, -78}, {-56, -78}}, thickness = 0.5));
  connect(urlaub.transitionOutDis, Dienstbereit.inTransitionDis[1]) annotation(
    Line(points = {{-104, -80}, {-118, -80}, {-118, -78}, {-130, -78}}));
  connect(Ruhe.outTransitionDis[1], RuheZeitEnde.inPlacesDis[1]) annotation(
    Line(points = {{69.2, -80.5}, {56.8, -80}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(EinTagWiederholer.inPlacesDis[1], Dienstbereit.outTransitionDis[2]) annotation(
    Line(points = {{-52.8, -118}, {-156, -118}, {-156, -77.2}, {-150.8, -77.2}}, color = {0, 0, 0}, smooth = Smooth.None));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-300, -300}, {300, 300}}, initialScale = 0.1), graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-300, 300}, {300, -302}}), Line(points = {{-160, -100}, {158, -100}, {78, 0}, {-78, 0}, {-158, -100}}), Rectangle(extent = {{-76, 0}, {80, 138}}), Rectangle(extent = {{-20, 138}, {20, 160}}), Ellipse(extent = {{-72, 286}, {74, 160}}, endAngle = 360), Ellipse(extent = {{116, 134}, {80, 4}}, endAngle = 360), Ellipse(fillPattern = FillPattern.Solid, extent = {{-40, 260}, {-16, 236}}, endAngle = 360), Rectangle(fillColor = {255, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-8, -20}, {8, -80}}), Ellipse(extent = {{-62, -100}, {-10, -282}}, endAngle = 360), Ellipse(extent = {{12, -100}, {64, -282}}, endAngle = 360), Ellipse(fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-44, 196}, {46, 184}}, endAngle = 360), Ellipse(fillPattern = FillPattern.Solid, extent = {{18, 260}, {42, 236}}, endAngle = 360), Rectangle(extent = {{-8, 228}, {12, 214}}), Ellipse(extent = {{-76, 134}, {-112, 4}}, endAngle = 360), Rectangle(origin = {0, -50}, rotation = 90, fillColor = {255, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-8, 30}, {8, -30}}), Text(extent = {{-314, 470}, {290, 304}}, textString = "%name")}),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-300, -300}, {300, 300}}, initialScale = 0.1), graphics));
end PflegekraftUrlaubRandom;
