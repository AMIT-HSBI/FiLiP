within PNlib.PN.Interfaces;
connector ExtIn "part of place model to connect places to output transitions"
  import PNlib.Types.ArcType;
  input Real t "marking of the place" annotation(HideResult=true);
  annotation(Icon(graphics = {Polygon(fillColor = {0, 170, 0}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {98, 0}, {-100, -100}, {-100, 100}})}, coordinateSystem(initialScale = 0.1)));
end ExtIn;
