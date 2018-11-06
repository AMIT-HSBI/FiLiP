within FiliP;

model Station
  // Start Ausgabe Groeßen
  PNlib.PN.Interfaces.IntegerConIn BesetzungSchicht1(value = PersonalInSchicht1.t);
  PNlib.PN.Interfaces.IntegerConIn BesetzungSchicht2(value = PersonalInSchicht2.t) if AnzahlSchichten > 1;
  PNlib.PN.Interfaces.IntegerConIn BesetzungSchicht3(value = PersonalInSchicht3.t) if AnzahlSchichten > 2;
  PNlib.PN.Interfaces.IntegerConIn BesetzungSchicht4(value = PersonalInSchicht4.t) if AnzahlSchichten > 3;
  PNlib.PN.Interfaces.IntegerConIn BesetzungSchicht5(value = PersonalInSchicht5.t) if AnzahlSchichten > 4;
  PNlib.PN.Interfaces.IntegerConIn BesetzungSchicht6(value = PersonalInSchicht6.t) if AnzahlSchichten > 5;
  PNlib.PN.Interfaces.IntegerConIn BesetzungsDefizitSchicht1(value = defizitMesser1.Defizit);
  PNlib.PN.Interfaces.IntegerConIn BesetzungsDefizitSchicht2(value = defizitMesser2.Defizit) if AnzahlSchichten > 1;
  PNlib.PN.Interfaces.IntegerConIn BesetzungsDefizitSchicht3(value = defizitMesser3.Defizit) if AnzahlSchichten > 2;
  PNlib.PN.Interfaces.IntegerConIn BesetzungsDefizitSchicht4(value = defizitMesser4.Defizit) if AnzahlSchichten > 3;
  PNlib.PN.Interfaces.IntegerConIn BesetzungsDefizitSchicht5(value = defizitMesser5.Defizit) if AnzahlSchichten > 4;
  PNlib.PN.Interfaces.IntegerConIn BesetzungsDefizitSchicht6(value = defizitMesser6.Defizit) if AnzahlSchichten > 5;
  PNlib.PN.Interfaces.IntegerConIn BelastungSchicht1[5](value = defizitMesser1.Ueberbelastet);
  PNlib.PN.Interfaces.IntegerConIn BelastungSchicht2[5](value = defizitMesser2.Ueberbelastet) if AnzahlSchichten > 1;
  PNlib.PN.Interfaces.IntegerConIn BelastungSchicht3[5](value = defizitMesser3.Ueberbelastet) if AnzahlSchichten > 2;
  PNlib.PN.Interfaces.IntegerConIn BelastungSchicht4[5](value = defizitMesser4.Ueberbelastet) if AnzahlSchichten > 3;
  PNlib.PN.Interfaces.IntegerConIn BelastungSchicht5[5](value = defizitMesser5.Ueberbelastet) if AnzahlSchichten > 4;
  PNlib.PN.Interfaces.IntegerConIn BelastungSchicht6[5](value = defizitMesser6.Ueberbelastet) if AnzahlSchichten > 5;
  Real IstBelastung = fallGewichtung1.IstBelastung;
  // Ende Ausgabe Groeßen
protected
  // Start Eingabe Groeßen
  // Strucktur veraendernde Variablen
  parameter Integer AnzahlSchichten = 3;
  parameter Integer SchichtHatPOOL[:] = {1, 1, 1, 1, 1, 1} annotation(Dialog(enable = true, group = "POOL"));
  parameter Integer nP = 1 "Anzahl der Pflegekraefte" annotation(Dialog(enable = true, group = "Personal Daten"));
  // Nicht Strucktur veraendernde Variablen
  // Pool?, EinSpringen?, Defizit
  parameter Real MessZeit[3] = {0.1, 0.2, 0.3};
  parameter Real MessSchwellen[5]={0.5, 0.4, 0.3, 0.2, 0.1};
  // Schicht Start, Schicht Dauer
  parameter Real Schichtzeiten[:, 2] = {{6, 8.2}, {12.3, 8.2}, {20.25, 10}} annotation(  Dialog(enable = true, group = "Zeiten"));
      parameter Integer SollBesetzung [:,7] = {{3,3,3,3,3,2,2},
                                             {2,2,2,2,2,1,1},
                                             {1,1,1,1,1,1,1},
                                             {1,1,1,1,1,1,1},
                                             {1,1,1,1,1,1,1},
                                             {1,1,1,1,1,1,1}}annotation(  Dialog(enable = true, group = "Personal"));
  parameter Real PoolWkeit[:] = {0.5, 0.5, 0.5, 0.5, 0.5, 0.5} annotation(  Dialog(enable = true, group = "POOL"));
  parameter Real SollBelastung[7]={110,110,110,105,100,85,90} annotation(Dialog(enable = true, group = "Belastung"));
  parameter Real PlanKorrektur=0.45 annotation(Dialog(enable = true, group = "Belastung"));
  parameter Real a[7]={-20,-20,-30,-30,-40,-40,-20} annotation(Dialog(enable = true, group = "Belastung"));
  parameter Real b[7]={40,40,30,20,20,20,30} annotation(Dialog(enable = true, group = "Belastung"));
  parameter Real c[7]={20,0,0,-5,-5,-15,5} annotation(Dialog(enable = true, group = "Belastung"));
  parameter Integer StartTag annotation(Dialog(enable = true, group = "Belastung"));
  // Ende Eingabe Groeßen
  // Messer
  DefizitMesser defizitMesser1(SollBesetzung = SollBesetzung[1, fallGewichtung1.WocheTag], IstBesetzung = PersonalInSchicht1.t, SollBelastung=SollBelastung[fallGewichtung1.WocheTag], IstBelastung=fallGewichtung1.IstBelastung, MessSchwellen=MessSchwellen, Schichtzeit = Schichtzeiten[1, 1], MessZeit = MessZeit[3]);
  DefizitMesser defizitMesser2(SollBesetzung = SollBesetzung[2, fallGewichtung1.WocheTag], IstBesetzung = PersonalInSchicht2.t, SollBelastung=SollBelastung[fallGewichtung1.WocheTag], IstBelastung=fallGewichtung1.IstBelastung, MessSchwellen=MessSchwellen, Schichtzeit = Schichtzeiten[2, 1], MessZeit = MessZeit[3]) if AnzahlSchichten > 1;
  DefizitMesser defizitMesser3(SollBesetzung = SollBesetzung[3, fallGewichtung1.WocheTag], IstBesetzung = PersonalInSchicht3.t, SollBelastung=SollBelastung[fallGewichtung1.WocheTag], IstBelastung=fallGewichtung1.IstBelastung, MessSchwellen=MessSchwellen, Schichtzeit = Schichtzeiten[3, 1], MessZeit = MessZeit[3]) if AnzahlSchichten > 2;
  DefizitMesser defizitMesser4(SollBesetzung = SollBesetzung[4, fallGewichtung1.WocheTag], IstBesetzung = PersonalInSchicht4.t, SollBelastung=SollBelastung[fallGewichtung1.WocheTag], IstBelastung=fallGewichtung1.IstBelastung, MessSchwellen=MessSchwellen, Schichtzeit = Schichtzeiten[4, 1], MessZeit = MessZeit[3]) if AnzahlSchichten > 3;
  DefizitMesser defizitMesser5(SollBesetzung = SollBesetzung[5, fallGewichtung1.WocheTag], IstBesetzung = PersonalInSchicht5.t, SollBelastung=SollBelastung[fallGewichtung1.WocheTag], IstBelastung=fallGewichtung1.IstBelastung, MessSchwellen=MessSchwellen, Schichtzeit = Schichtzeiten[5, 1], MessZeit = MessZeit[3]) if AnzahlSchichten > 4;
  DefizitMesser defizitMesser6(SollBesetzung = SollBesetzung[6, fallGewichtung1.WocheTag], IstBesetzung = PersonalInSchicht6.t, SollBelastung=SollBelastung[fallGewichtung1.WocheTag], IstBelastung=fallGewichtung1.IstBelastung, MessSchwellen=MessSchwellen, Schichtzeit = Schichtzeiten[6, 1], MessZeit = MessZeit[3]) if AnzahlSchichten > 5;
  FiliP.FallGewichtung fallGewichtung1 (SollBelastung=SollBelastung, PlanKorrektur=PlanKorrektur,a=a,b=b,c=c,StartTag=StartTag)annotation(
    Placement(visible = true, transformation(origin = {-8, 140}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Petri Netz
  PNlib.PN.Interfaces.DisPlaceOut PersonalOut[2 * AnzahlSchichten * nP] annotation(
    Placement(transformation(extent = {{200, -52}, {304, 52}})));
  PNlib.PN.Interfaces.DisPlaceIn PersonalIn[2 * AnzahlSchichten * nP] annotation(
    Placement(visible = true, transformation(extent = {{-298, -50}, {-196, 48}}, rotation = 0), iconTransformation(extent = {{-298, -50}, {-196, 48}}, rotation = 0)));
  FiliP.PNerweiterungen.PDmaxVariable PersonalInSchicht1(enablingType = PNlib.Types.EnablingType.Probability, maxTokens = SollBesetzung[1, fallGewichtung1.WocheTag], nInDis = 2 * nP + SchichtHatPOOL[1], nOutDis = 2 * nP + SchichtHatPOOL[1], nOutExt = SchichtHatPOOL[1]) annotation(
    Placement(visible = true, transformation(extent = {{-112, 90}, {-92, 110}}, rotation = 0)));
  FiliP.PNerweiterungen.PDmaxVariable PersonalInSchicht2(enablingType = PNlib.Types.EnablingType.Probability, maxTokens = SollBesetzung[2, fallGewichtung1.WocheTag], nInDis = 2 * nP + SchichtHatPOOL[2], nOutDis = 2 * nP + SchichtHatPOOL[2], nOutExt = SchichtHatPOOL[2]) if AnzahlSchichten > 1 annotation(
    Placement(visible = true, transformation(extent = {{60, 90}, {80, 110}}, rotation = 0)));
  FiliP.PNerweiterungen.PDmaxVariable PersonalInSchicht3(enablingType = PNlib.Types.EnablingType.Probability, maxTokens = SollBesetzung[3, fallGewichtung1.WocheTag], nInDis = 2 * nP + SchichtHatPOOL[3], nOutDis = 2 * nP + SchichtHatPOOL[3], nOutExt = SchichtHatPOOL[3]) if AnzahlSchichten > 2 annotation(
    Placement(visible = true, transformation(extent = {{-108, -12}, {-88, 8}}, rotation = 0)));
  FiliP.PNerweiterungen.PDmaxVariable PersonalInSchicht4(enablingType = PNlib.Types.EnablingType.Probability, maxTokens = SollBesetzung[4, fallGewichtung1.WocheTag], nInDis = 2 * nP + SchichtHatPOOL[4], nOutDis = 2 * nP + SchichtHatPOOL[4], nOutExt = SchichtHatPOOL[4]) if AnzahlSchichten > 3 annotation(
    Placement(visible = true, transformation(extent = {{68, -18}, {88, 2}}, rotation = 0)));
  FiliP.PNerweiterungen.PDmaxVariable PersonalInSchicht5(enablingType = PNlib.Types.EnablingType.Probability, maxTokens = SollBesetzung[5, fallGewichtung1.WocheTag], nInDis = 2 * nP + SchichtHatPOOL[5], nOutDis = 2 * nP + SchichtHatPOOL[5], nOutExt = SchichtHatPOOL[5]) if AnzahlSchichten > 4 annotation(
    Placement(visible = true, transformation(extent = {{-108, -130}, {-88, -110}}, rotation = 0)));
  FiliP.PNerweiterungen.PDmaxVariable PersonalInSchicht6(enablingType = PNlib.Types.EnablingType.Probability, maxTokens = SollBesetzung[6, fallGewichtung1.WocheTag], nInDis = 2 * nP + SchichtHatPOOL[6], nOutDis = 2 * nP + SchichtHatPOOL[6], nOutExt = SchichtHatPOOL[6]) if AnzahlSchichten > 5 annotation(
    Placement(visible = true, transformation(extent = {{64, -128}, {84, -108}}, rotation = 0)));
  FiliP.POOL pool1(MessZeit = MessZeit[1], PoolWkeit = PoolWkeit[1], Schichtzeiten = Schichtzeiten[1, :], SollBesetzung = SollBesetzung[1, fallGewichtung1.WocheTag]) if SchichtHatPOOL[1] == 1 annotation(
    Placement(visible = true, transformation(origin = {-104, 150}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  FiliP.POOL pool2(MessZeit = MessZeit[1], PoolWkeit = PoolWkeit[2], Schichtzeiten = Schichtzeiten[2, :], SollBesetzung = SollBesetzung[2, fallGewichtung1.WocheTag]) if AnzahlSchichten > 1 and SchichtHatPOOL[2] == 1 annotation(
    Placement(visible = true, transformation(origin = {70, 152}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  FiliP.POOL pool3(MessZeit = MessZeit[1], PoolWkeit = PoolWkeit[3], Schichtzeiten = Schichtzeiten[3, :], SollBesetzung = SollBesetzung[3, fallGewichtung1.WocheTag]) if AnzahlSchichten > 2 and SchichtHatPOOL[3] == 1 annotation(
    Placement(visible = true, transformation(origin = {-102, 42}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  FiliP.POOL pool4(MessZeit = MessZeit[1], PoolWkeit = PoolWkeit[4], Schichtzeiten = Schichtzeiten[4, :], SollBesetzung = SollBesetzung[4, fallGewichtung1.WocheTag]) if AnzahlSchichten > 3 and SchichtHatPOOL[4] == 1 annotation(
    Placement(visible = true, transformation(origin = {74, 42}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  FiliP.POOL pool5(MessZeit = MessZeit[1], PoolWkeit = PoolWkeit[5], Schichtzeiten = Schichtzeiten[5, :], SollBesetzung = SollBesetzung[5, fallGewichtung1.WocheTag]) if AnzahlSchichten > 4 and SchichtHatPOOL[5] == 1 annotation(
    Placement(visible = true, transformation(origin = {-102, -72}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  FiliP.POOL pool6(MessZeit = MessZeit[1], PoolWkeit = PoolWkeit[6], Schichtzeiten = Schichtzeiten[6, :], SollBesetzung = SollBesetzung[6, fallGewichtung1.WocheTag]) if AnzahlSchichten > 5 and SchichtHatPOOL[6] == 1 annotation(
    Placement(visible = true, transformation(origin = {76, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  outer PNlib.PN.Components.Settings settings "global settings for animation and display";
equation
  connect(pool6.StartPool, PersonalInSchicht6.inTransitionDis[2 * nP + 1]) annotation(
    Line(points = {{54, -54}, {42, -54}, {42, -118}, {64, -118}, {64, -118}}));
  connect(pool6.EndePool, PersonalInSchicht6.outTransitionDis[2 * nP + 1]) annotation(
    Line(points = {{98, -72}, {110, -72}, {110, -118}, {84, -118}, {84, -118}}));
  connect(pool6.KleinerSoll, PersonalInSchicht6.extOut[1]) annotation(
    Line(points = {{98, -88}, {104, -88}, {104, -110}, {82, -110}, {82, -110}}));
  connect(pool5.StartPool, PersonalInSchicht5.inTransitionDis[2 * nP + 1]) annotation(
    Line(points = {{-124, -56}, {-134, -56}, {-134, -120}, {-108, -120}, {-108, -120}}));
  connect(pool5.EndePool, PersonalInSchicht5.outTransitionDis[2 * nP + 1]) annotation(
    Line(points = {{-80, -74}, {-60, -74}, {-60, -120}, {-88, -120}, {-88, -120}}));
  connect(pool5.KleinerSoll, PersonalInSchicht5.extOut[1]) annotation(
    Line(points = {{-90, -112}, {-72, -112}, {-72, -90}, {-80, -90}, {-80, -90}}, thickness = 0.5));
  connect(pool4.StartPool, PersonalInSchicht4.inTransitionDis[2 * nP + 1]) annotation(
    Line(points = {{52, 58}, {42, 58}, {42, -8}, {68, -8}, {68, -8}}));
  connect(pool4.EndePool, PersonalInSchicht4.outTransitionDis[2 * nP + 1]) annotation(
    Line(points = {{96, 40}, {114, 40}, {114, -8}, {88, -8}, {88, -8}}));
  connect(pool4.KleinerSoll, PersonalInSchicht4.extOut[1]) annotation(
    Line(points = {{96, 24}, {102, 24}, {102, 0}, {86, 0}, {86, 0}}));
  connect(pool3.StartPool, PersonalInSchicht3.inTransitionDis[2 * nP + 1]) annotation(
    Line(points = {{-124, 58}, {-138, 58}, {-138, -2}, {-108, -2}, {-108, -2}}));
  connect(pool3.EndePool, PersonalInSchicht3.outTransitionDis[2 * nP + 1]) annotation(
    Line(points = {{-80, 40}, {-64, 40}, {-64, -2}, {-88, -2}, {-88, -2}}));
  connect(pool3.KleinerSoll, PersonalInSchicht3.extOut[1]) annotation(
    Line(points = {{-80, 24}, {-72, 24}, {-72, 6}, {-90, 6}, {-90, 6}}));
  connect(pool2.StartPool, PersonalInSchicht2.inTransitionDis[2 * nP + 1]) annotation(
    Line(points = {{48, 168}, {36, 168}, {36, 100}, {60, 100}, {60, 100}}));
  connect(pool2.EndePool, PersonalInSchicht2.outTransitionDis[2 * nP + 1]) annotation(
    Line(points = {{92, 150}, {114, 150}, {114, 100}, {80, 100}, {80, 100}}));
  connect(pool2.KleinerSoll, PersonalInSchicht2.extOut[1]) annotation(
    Line(points = {{92, 134}, {102, 134}, {102, 106}, {78, 106}, {78, 108}}));
  connect(pool1.EndePool, PersonalInSchicht1.outTransitionDis[2 * nP + 1]) annotation(
    Line(points = {{-82, 148}, {-68, 148}, {-68, 100}, {-91, 100}}));
  connect(pool1.StartPool, PersonalInSchicht1.inTransitionDis[2 * nP + 1]) annotation(
    Line(points = {{-126, 166}, {-138, 166}, {-138, 100}, {-113, 100}}));
  connect(pool1.KleinerSoll, PersonalInSchicht1.extOut[1]) annotation(
    Line(points = {{-94, 107}, {-76, 107}, {-76, 132}, {-82, 132}}, thickness = 0.5));
  for i in 1:nP loop
    connect(PersonalInSchicht1.inTransitionDis[1 + 2 * (i - 1)], PersonalIn[1 + 2 * AnzahlSchichten * (i - 1)]);
    connect(PersonalInSchicht1.inTransitionDis[2 + 2 * (i - 1)], PersonalIn[2 + 2 * AnzahlSchichten * (i - 1)]);
    connect(PersonalInSchicht2.inTransitionDis[1 + 2 * (i - 1)], PersonalIn[3 + 2 * AnzahlSchichten * (i - 1)]);
    connect(PersonalInSchicht2.inTransitionDis[2 + 2 * (i - 1)], PersonalIn[4 + 2 * AnzahlSchichten * (i - 1)]);
    connect(PersonalInSchicht3.inTransitionDis[1 + 2 * (i - 1)], PersonalIn[5 + 2 * AnzahlSchichten * (i - 1)]);
    connect(PersonalInSchicht3.inTransitionDis[2 + 2 * (i - 1)], PersonalIn[6 + 2 * AnzahlSchichten * (i - 1)]);
    connect(PersonalInSchicht4.inTransitionDis[1 + 2 * (i - 1)], PersonalIn[7 + 2 * AnzahlSchichten * (i - 1)]);
    connect(PersonalInSchicht4.inTransitionDis[2 + 2 * (i - 1)], PersonalIn[8 + 2 * AnzahlSchichten * (i - 1)]);
    connect(PersonalInSchicht5.inTransitionDis[1 + 2 * (i - 1)], PersonalIn[9 + 2 * AnzahlSchichten * (i - 1)]);
    connect(PersonalInSchicht5.inTransitionDis[2 + 2 * (i - 1)], PersonalIn[10 + 2 * AnzahlSchichten * (i - 1)]);
    connect(PersonalInSchicht6.inTransitionDis[1 + 2 * (i - 1)], PersonalIn[11 + 2 * AnzahlSchichten * (i - 1)]);
    connect(PersonalInSchicht6.inTransitionDis[2 + 2 * (i - 1)], PersonalIn[12 + 2 * AnzahlSchichten * (i - 1)]);
    connect(PersonalInSchicht1.outTransitionDis[1 + 2 * (i - 1)], PersonalOut[1 + 2 * AnzahlSchichten * (i - 1)]);
    connect(PersonalInSchicht1.outTransitionDis[2 + 2 * (i - 1)], PersonalOut[2 + 2 * AnzahlSchichten * (i - 1)]);
    connect(PersonalInSchicht2.outTransitionDis[1 + 2 * (i - 1)], PersonalOut[3 + 2 * AnzahlSchichten * (i - 1)]);
    connect(PersonalInSchicht2.outTransitionDis[2 + 2 * (i - 1)], PersonalOut[4 + 2 * AnzahlSchichten * (i - 1)]);
    connect(PersonalInSchicht3.outTransitionDis[1 + 2 * (i - 1)], PersonalOut[5 + 2 * AnzahlSchichten * (i - 1)]);
    connect(PersonalInSchicht3.outTransitionDis[2 + 2 * (i - 1)], PersonalOut[6 + 2 * AnzahlSchichten * (i - 1)]);
    connect(PersonalInSchicht4.outTransitionDis[1 + 2 * (i - 1)], PersonalOut[7 + 2 * AnzahlSchichten * (i - 1)]);
    connect(PersonalInSchicht4.outTransitionDis[2 + 2 * (i - 1)], PersonalOut[8 + 2 * AnzahlSchichten * (i - 1)]);
    connect(PersonalInSchicht5.outTransitionDis[1 + 2 * (i - 1)], PersonalOut[9 + 2 * AnzahlSchichten * (i - 1)]);
    connect(PersonalInSchicht5.outTransitionDis[2 + 2 * (i - 1)], PersonalOut[10 + 2 * AnzahlSchichten * (i - 1)]);
    connect(PersonalInSchicht6.outTransitionDis[1 + 2 * (i - 1)], PersonalOut[11 + 2 * AnzahlSchichten * (i - 1)]);
    connect(PersonalInSchicht6.outTransitionDis[2 + 2 * (i - 1)], PersonalOut[12 + 2 * AnzahlSchichten * (i - 1)]);
  end for;
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -200}, {200, 200}}), graphics),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -200}, {200, 200}}, initialScale = 0.1), graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-200, 200}, {198, -200}}), Rectangle(fillColor = {255, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-20, 60}, {20, -60}}), Rectangle(fillColor = {255, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-60, 20}, {60, -20}})}));
end Station;
