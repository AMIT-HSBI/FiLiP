within FiliP;

model Urlaub
  parameter Real UrlaubStartTermine[:] = {10, 20, 30};
  parameter Real UrlaubEndTermine[:] = {15, 25, 35};
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
  PNlib.PN.Components.TD TUrlaubStart(nOutDis = 1, timeType = PNlib.Types.TimeType.Event, timeValue = UrlaubStartTermine) annotation(
    Placement(visible = true, transformation(origin = {4, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P1(nInDis = 1, nOutDis = 2) annotation(
    Placement(visible = true, transformation(origin = {36, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T1(nInDis = 1, timeType = PNlib.Types.TimeType.Event, timeValue = UrlaubEndTermine) annotation(
    Placement(visible = true, transformation(origin = {84, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD Urlaubpruefer(nInDis = 3, nOutDis = 2) annotation(
    Placement(visible = true, transformation(origin = {80, -2}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD Urlaubgeber(nInDis = 2, nOutDis = 1, timeValue = {0})  annotation(
    Placement(visible = true, transformation(origin = {36, -4}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD ImUrlaub(nInDis = 1, nOutDis = 1)  annotation(
    Placement(visible = true, transformation(origin = {14, -4}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD TUrlaubEnde(nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.Event, timeValue = UrlaubEndTermine)  annotation(
    Placement(visible = true, transformation(origin = {-10, -4}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
protected
  outer PNlib.PN.Components.Settings settings "global settings for animation and display";
equation
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
  connect(P1.outTransitionDis[2], Urlaubgeber.inPlacesDis[2]) annotation(
    Line(points = {{46, 50}, {52, 50}, {52, -4}, {40, -4}, {40, -4}}, thickness = 0.5));
  connect(P1.outTransitionDis[1], T1.inPlacesDis[1]) annotation(
    Line(points = {{46, 50}, {78, 50}, {78, 50}, {80, 50}}, thickness = 0.5));
  connect(Urlaubpruefer.outTransitionDis[1], Urlaubgeber.inPlacesDis[1]) annotation(
    Line(points = {{70, -2}, {40, -2}, {40, -4}, {40, -4}}, thickness = 0.5));
  connect(TUrlaubEnde.outPlacesDis[1], KannArbeiteten.inTransitionDis[2]) annotation(
    Line(points = {{-14, -4}, {-28, -4}, {-28, -4}, {-30, -4}}, thickness = 0.5));
  connect(ImUrlaub.inTransitionDis[1], Urlaubgeber.outPlacesDis[1]) annotation(
    Line(points = {{25, -4}, {33, -4}}, thickness = 0.5));
  connect(TUrlaubStart.outPlacesDis[1], P1.inTransitionDis[1]) annotation(
    Line(points = {{11, 50}, {27, 50}}, thickness = 0.5));
  connect(ImUrlaub.outTransitionDis[1], TUrlaubEnde.inPlacesDis[1]) annotation(
    Line(points = {{5, -4}, {-5, -4}}, thickness = 0.5));
  connect(KannArbeiteten.outTransitionDis[1], T12.inPlacesDis[1]) annotation(
    Line(points = {{-50.8, -4}, {-60.8, -4}}));
  connect(T12.outPlacesDis[1], transitionOutDis) annotation(
    Line(points = {{-69, -6}, {-78, -6}, {-78, -4}, {-116, -4}, {-116, 0}}, thickness = 0.5));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
    Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.2), graphics = {Rectangle(origin = {0, -2}, fillColor = {255, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}));
end Urlaub;
