within FiliP;

model UrlaubRandom
 parameter Real Stelle = 1 "Was fuer eine Stelle" annotation(
    Dialog(enable = true, group = "Personaldaten"));
 parameter Integer AnzahlUrlaubsWochen=6;
  PNlib.PN.Components.TD Arbeitet1(nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.Delay, timeValue = {0}) annotation(
    Placement(visible = true, transformation(extent = {{46, -52}, {26, -32}}, rotation = 0)));
  PNlib.PN.Components.TD T12(nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.Immediate, timeValue = {0}) annotation(
    Placement(visible = true, transformation(extent = {{-54, -14}, {-74, 6}}, rotation = 0)));
  PNlib.PN.Components.PD KannArbeiteten(nInDis = 2, nOutDis = 1) annotation(
    Placement(visible = true, transformation(extent = {{-30, -14}, {-50, 6}}, rotation = 0)));
  PNlib.PN.Interfaces.DisTransitionOut transitionOutDis annotation(
    Placement(visible = true, transformation(origin = {-116.06, 0.392857}, extent = {{16.7164, -20}, {-16.7164, 20}}, rotation = 0), iconTransformation(origin = {-117.955, -2.23214}, extent = {{18.6119, -22.2679}, {-18.6119, 22.2679}}, rotation = 0)));
  PNlib.PN.Interfaces.DisPlaceIn placeInDis[3] annotation(
    Placement(visible = true, transformation(origin = {116.236, -2.23404}, extent = {{16.8909, -19.766}, {-16.8909, 19.766}}, rotation = 0), iconTransformation(origin = {120.636, 0.191491}, extent = {{18.6364, -21.8085}, {-18.6364, 21.8085}}, rotation = 0)));
  //Real WU;
  PNlib.PN.Components.TS TUrlaubStart(a = 0, b = 735 /(AnzahlUrlaubsWochen+1), c = 450 /(AnzahlUrlaubsWochen+1), distributionType = PNlib.Types.DistributionType.Uniform, firingCon = TUrlaubStart.nFire < AnzahlUrlaubsWochen,nOutDis = 1, timeType = PNlib.Types.StoTimeType.Delay) annotation(
    Placement(visible = true, transformation(origin = {90, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P1(nInDis = 1, nOutDis = 1) annotation(
    Placement(visible = true, transformation(origin = {68, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD Urlaubpruefer(nInDis = 3, nOutDis = 2) annotation(
    Placement(visible = true, transformation(origin = {80, -2}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD Urlaubgeber(arcWeightOutCon = {Stelle},nInDis = 2, nOutCon = 1, nOutDis = 2, timeValue = {0})  annotation(
    Placement(visible = true, transformation(origin = {36, -4}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD ImUrlaub(nInDis = 1, nOutDis = 1)  annotation(
    Placement(visible = true, transformation(origin = {14, -4}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD TUrlaubEnde(arcWeightInCon = {Stelle}, nInCon = 1, nInDis = 2, nOutDis = 1, timeType = PNlib.Types.TimeType.Delay, timeValue = {7})  annotation(
    Placement(visible = true, transformation(origin = {-10, -4}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PNlib.PN.Interfaces.HybTransitionOut UrlaubStellenOut annotation(
    Placement(visible = true, transformation(origin = {32, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {32, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  PNlib.PN.Interfaces.DisTransitionOut UrlaubKopfOut annotation(
    Placement(visible = true, transformation(origin = {80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
 PNlib.PN.Interfaces.HybTransitionIn UrlaubStelleIn annotation(
    Placement(visible = true, transformation(origin = {-80, 120}, extent = {{20, -20}, {-20, 20}}, rotation = 90), iconTransformation(origin = {-80, 120}, extent = {{20, -20}, {-20, 20}}, rotation = 90)));
 PNlib.PN.Interfaces.DisTransitionIn UrlaubKopfIn annotation(
    Placement(visible = true, transformation(origin = {-32, 120}, extent = {{20, -20}, {-20, 20}}, rotation = 90), iconTransformation(origin = {-30, 120}, extent = {{20, -20}, {-20, 20}}, rotation = 90)));
protected
  outer PNlib.PN.Components.Settings settings "global settings for animation and display";
equation
  connect(TUrlaubEnde.inPlacesCon[1], UrlaubStelleIn) annotation(
    Line(points = {{-6, -12}, {-2, -12}, {-2, 80}, {-80, 80}, {-80, 120}, {-80, 120}}, thickness = 0.5));
  connect(TUrlaubEnde.inPlacesDis[2], UrlaubKopfIn) annotation(
    Line(points = {{-6, -4}, {-2, -4}, {-2, 80}, {-32, 80}, {-32, 120}, {-32, 120}}, thickness = 0.5));
  connect(Urlaubgeber.outPlacesCon[1], UrlaubStellenOut) annotation(
    Line(points = {{32, -12}, {28, -12}, {28, 80}, {32, 80}, {32, 120}, {32, 120}}, thickness = 0.5));
  connect(Urlaubgeber.outPlacesDis[2], UrlaubKopfOut) annotation(
    Line(points = {{32, -4}, {28, -4}, {28, 80}, {80, 80}, {80, 108}, {80, 108}, {80, 120}}, thickness = 0.5));
  connect(TUrlaubStart.outPlacesDis[1], P1.inTransitionDis[1]) annotation(
    Line(points = {{87, 50}, {79, 50}}, thickness = 0.5));
  connect(P1.outTransitionDis[1], Urlaubgeber.inPlacesDis[2]) annotation(
    Line(points = {{59, 50}, {52, 50}, {52, -4}, {40, -4}}, thickness = 0.5));
  connect(Urlaubpruefer.inTransitionDis[3], placeInDis[3]) annotation(
    Line(points = {{91, -2}, {96, -2}, {96, -4}, {116, -4}}, thickness = 0.5));
  connect(Urlaubpruefer.inTransitionDis[2], placeInDis[2]) annotation(
    Line(points = {{91, -2}, {96, -2}, {96, -4}, {116, -4}}, thickness = 0.5));
  connect(Urlaubpruefer.inTransitionDis[1], placeInDis[1]) annotation(
    Line(points = {{91, -2}, {96, -2}, {96, -4}, {116, -4}}, thickness = 0.5));
  connect(Urlaubpruefer.outTransitionDis[2], Arbeitet1.inPlacesDis[1]) annotation(
    Line(points = {{70, -2}, {60, -2}, {60, -42}, {40, -42}, {40, -40}, {40, -40}}, thickness = 0.5));
  connect(Arbeitet1.outPlacesDis[1], KannArbeiteten.inTransitionDis[1]) annotation(
    Line(points = {{32, -40}, {-24, -40}, {-24, -4}, {-30, -4}, {-30, -4}, {-30, -4}}, thickness = 0.5));
  connect(Urlaubpruefer.outTransitionDis[1], Urlaubgeber.inPlacesDis[1]) annotation(
    Line(points = {{70, -2}, {40, -2}, {40, -4}, {40, -4}}, thickness = 0.5));
  connect(TUrlaubEnde.outPlacesDis[1], KannArbeiteten.inTransitionDis[2]) annotation(
    Line(points = {{-14, -4}, {-28, -4}, {-28, -4}, {-30, -4}}, thickness = 0.5));
  connect(ImUrlaub.inTransitionDis[1], Urlaubgeber.outPlacesDis[1]) annotation(
    Line(points = {{25, -4}, {33, -4}}, thickness = 0.5));
  connect(ImUrlaub.outTransitionDis[1], TUrlaubEnde.inPlacesDis[1]) annotation(
    Line(points = {{5, -4}, {-5, -4}}, thickness = 0.5));
  connect(KannArbeiteten.outTransitionDis[1], T12.inPlacesDis[1]) annotation(
    Line(points = {{-50.8, -4}, {-60.8, -4}}));
  connect(T12.outPlacesDis[1], transitionOutDis) annotation(
    Line(points = {{-69, -6}, {-78, -6}, {-78, -4}, {-116, -4}, {-116, 0}}, thickness = 0.5));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
    Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.2), graphics = {Rectangle( fillColor = {255, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}));
end UrlaubRandom;
