within PNlib.PN.Interfaces;
connector TransitionInExt "part of transition model to connect transitions to input places"
  import PNlib.Types.ArcType;
  input Boolean condition "Is the condition true?" annotation(HideResult=true);
  annotation(Icon(graphics = {Polygon(fillColor = {0, 170, 0}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {98, 0}, {-100, -100}, {-100, 100}})}, coordinateSystem(initialScale = 0.1)));
end TransitionInExt;
