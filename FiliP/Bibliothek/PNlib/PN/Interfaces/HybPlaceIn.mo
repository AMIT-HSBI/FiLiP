within PNlib.PN.Interfaces;
connector HybPlaceIn "part of place model to connect places to input transitions"
  input Boolean active "Are the input transitions active?" annotation(HideResult=true);
  input Boolean fire "Do the input transitions fire?" annotation(HideResult=true);
  input Real arcWeight "Real arc weights of input transitions" annotation(HideResult=true);
  input Boolean enabledByInPlaces "Are the input transitions enabled by all theier input places?" annotation(HideResult=true);
  output Real t "Real marking of the place" annotation(HideResult=true);
  output Real maxTokens"Real maximum capacity of the place" annotation(HideResult=true);
  output Boolean enable "Which of the input transitions are enabled by the place?" annotation(HideResult=true);
  annotation(Icon(graphics = {Polygon(fillColor = {170, 0, 255}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {98, 0}, {-100, -100}, {-100, 100}})}, coordinateSystem(initialScale = 0.1)));
end HybPlaceIn;
