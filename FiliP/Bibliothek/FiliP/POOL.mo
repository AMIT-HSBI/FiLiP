within FiliP;

model POOL
  parameter Real Schichtzeiten[2] = {6, 8.2} annotation(Dialog(enable = true, group = "Zeiten"));
  parameter Integer SollBesetzung = 3 annotation(Dialog(enable = true, group = "Personal"));
  parameter Real PoolWkeit =0.5 annotation(Dialog(enable = true, group = "Pool"));
  parameter Real MessZeit =0.1 annotation(Dialog(enable = true, group = "Pool"));
  // Petri netz
  outer PNlib.PN.Components.Settings settings "global settings for animation and display";
  PNlib.PN.Components.TD POOLBedarfPruefer(arcWeightOutDis = {integer(SollBesetzung - WenigerSoll.tIn)},nInExt = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.Tact, timeValue = {(Schichtzeiten[1] + MessZeit) / 24, 1})  annotation(
    Placement(visible = true, transformation(origin = {-52, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD POOLBedarf(enablingProbOut = {PoolWkeit, 1 - PoolWkeit}, enablingType = PNlib.Types.EnablingType.Probability,nInDis = 1, nOutDis = 2)  annotation(
    Placement(visible = true, transformation(origin = {-26, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD KeinPOOL(nInDis = 1,timeType = PNlib.Types.TimeType.Immediate, timeValue = {0})  annotation(
    Placement(visible = true, transformation(origin = {12, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD POOL(nInDis = 1, nOutDis = 2,timeType = PNlib.Types.TimeType.Immediate, timeValue = {0})  annotation(
    Placement(visible = true, transformation(origin = {12, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD POOLinSchicht(nInDis = 1, nOutDis = 1)  annotation(
    Placement(visible = true, transformation(origin = {38, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD POOLEnde(arcWeightInDis = {POOLinSchicht.t, POOLinSchicht.t},nInDis = 2, timeType = PNlib.Types.TimeType.Tact, timeValue = {(Schichtzeiten[1] + Schichtzeiten[2]) / 24, 1})  annotation(
    Placement(visible = true, transformation(origin = {76, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.EA WenigerSoll(Arc = PNlib.Types.ArcType.RealInhibitorArc, testValue = SollBesetzung)  annotation(
    Placement(visible = true, transformation(origin = {-74, 22}, extent = {{-9.8, 0.4}, {2.8, 4.8}}, rotation = 0)));
  PNlib.PN.Interfaces.ExtIn KleinerSoll annotation(
    Placement(visible = true, transformation(origin = {110, -88}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {110, -88}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PNlib.PN.Interfaces.DisTransitionIn EndePool annotation(
    Placement(visible = true, transformation(origin = {110, 10}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {110, -12}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PNlib.PN.Interfaces.DisTransitionOut StartPool annotation(
    Placement(visible = true, transformation(origin = {-110, 78}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {-110, 78}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));      equation
  connect(POOL.outPlacesDis[2], StartPool) annotation(
    Line(points = {{16, -8}, {24, -8}, {24, 76}, {-110, 76}, {-110, 78}}, thickness = 0.5));
  connect(WenigerSoll.inExt, KleinerSoll) annotation(
    Line(points = {{-84, 24}, {-90, 24}, {-90, -88}, {110, -88}, {110, -88}}));
  connect(POOLEnde.inPlacesDis[2], EndePool) annotation(
    Line(points = {{72, -8}, {64, -8}, {64, 10}, {110, 10}, {110, 10}}, thickness = 0.5));
  connect(POOLinSchicht.outTransitionDis[1], POOLEnde.inPlacesDis[1]) annotation(
    Line(points = {{48, -8}, {73, -8}}, thickness = 0.5));
  connect(POOL.outPlacesDis[1], POOLinSchicht.inTransitionDis[1]) annotation(
    Line(points = {{16, -8}, {28, -8}, {28, -8}, {28, -8}}, thickness = 0.5));
  connect(POOLBedarf.outTransitionDis[2], KeinPOOL.inPlacesDis[1]) annotation(
    Line(points = {{-16, 14}, {-2, 14}, {-2, 36}, {8, 36}, {8, 36}}, thickness = 0.5));
  connect(POOLBedarf.outTransitionDis[1], POOL.inPlacesDis[1]) annotation(
    Line(points = {{-16, 14}, {-2, 14}, {-2, -8}, {8, -8}, {8, -8}}, thickness = 0.5));
  connect(POOLBedarfPruefer.outPlacesDis[1], POOLBedarf.inTransitionDis[1]) annotation(
    Line(points = {{-48, 16}, {-38, 16}, {-38, 14}, {-36, 14}}, thickness = 0.5));
  connect(WenigerSoll.outExt, POOLBedarfPruefer.extIn[1]) annotation(
    Line(points = {{-70, 24}, {-58, 24}, {-58, 26}, {-56, 26}}));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
    Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.2), graphics = {Rectangle(origin = {0, -2}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-100, 102}, {100, -98}}), Text(origin = {-28, 4}, extent = {{-70, 38}, {126, -40}}, textString = "%name")}));
end POOL;
