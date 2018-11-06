within PNlib.PN.Components;

model EA "extended Arc"
  //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
  parameter Real testValue = 1 "marking that has to be exceeded to enable firing" annotation(
    Dialog(enable = true, group = "Test Arc"));
  parameter PNlib.Types.ArcType Arc = PNlib.Types.ArcType.RealTestArc "real Test arc >, Test arc >=" annotation(
    Dialog(enable = true, group = "Test Arc"));
  Real tIn "Tokens of input Place";
  Boolean extendedCondition "Condition True?";
  PNlib.PN.Interfaces.ExtIn inExt(t = tIn) "connector for place" annotation(
    Placement(visible = true, transformation(extent = {{-110, 12}, {-90, 32}}, rotation = 0), iconTransformation(extent = {{-118, 14}, {-98, 34}}, rotation = 0)));
  PNlib.PN.Interfaces.ExtOut outExt(condition = extendedCondition) "connector for transition" annotation(
    Placement(visible = true, transformation(extent = {{28, 16}, {48, 36}}, rotation = 0), iconTransformation(extent = {{28, 14}, {48, 34}}, rotation = 0)));
algorithm
  if Arc == PNlib.Types.ArcType.RealTestArc then
    if tIn > testValue + PNlib.Constants.almost_eps then
      extendedCondition := true;
    else
      extendedCondition := false;
    end if;
  elseif Arc == PNlib.Types.ArcType.TestArc then
    if tIn >= testValue - PNlib.Constants.almost_eps then
      extendedCondition := true;
    else
      extendedCondition := false;
    end if;
  elseif Arc == PNlib.Types.ArcType.RealInhibitorArc then
    if tIn < testValue - PNlib.Constants.almost_eps then
      extendedCondition := true;
    else
      extendedCondition := false;
    end if;
  else
    if tIn <= testValue + PNlib.Constants.almost_eps then
      extendedCondition := true;
    else
      extendedCondition := false;
    end if;
  end if;
  annotation(
    defaultComponentName = "EA1",
    Icon(coordinateSystem(extent = {{-98, 4}, {28, 48}}, initialScale = 0.1), graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-98, 48}, {28, 4}}), Line(points = {{-94, 24}, {22, 24}}), Ellipse(fillPattern = FillPattern.Solid, extent = {{14, 30}, {26, 18}}, endAngle = 360), Text(lineThickness = 0.5, extent = {{-38, -4}, {-38, -16}}, textString = " "), Text(origin = {-39, -11}, extent = {{-35, 11}, {35, -11}}, textString = "%testValue"), Text(origin = {-65, 62}, extent = {{-25, 8}, {81, -12}}, textString = "%Arc")}),
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-98, 0}, {28, 48}}), graphics));
end EA;
