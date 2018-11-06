within PNlib.PN.Interfaces;
connector HybPlaceOutIn "part of place model to connect places to output transitions"
  import PNlib.Types.ArcType;
  input Boolean active "Are the output transitions active?" annotation(HideResult=true);
  input Integer arcWeight "Integer arc weights of output transitions" annotation(HideResult=true);
  output Integer t "Integer marking of the place" annotation(HideResult=true);
  output Integer minTokens "Integer minimum capacity of the place" annotation(HideResult=true);
  output Integer maxTokens "Integer maximum capacity of the place" annotation(HideResult=true);
  output Boolean enable "Which of the output transitions are enabled by the place?" annotation(HideResult=true);
  annotation(Icon(graphics = {Polygon(origin = {2, 2}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, points = {{-2, 98}, {98, 0}, {-2, -102}, {-2, 98}}), Polygon(origin = {-2, 0}, rotation = 180, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, points = {{-2, 98}, {98, 0}, {-2, -102}, {-2, 98}})}, coordinateSystem(initialScale = 0.1)));
end HybPlaceOutIn;
