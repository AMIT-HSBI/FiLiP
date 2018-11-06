within PNlib.PN.Interfaces;
connector HybTransitionOutIn "part of transition model to connect transitions to input places"
  import PNlib.Types.ArcType;
  input Integer t "Real Markings of input places" annotation(HideResult=true);
  input Integer minTokens "Real minimum capacites of input places" annotation(HideResult=true);
  input Integer maxTokens "Integer maximum capacity of the place" annotation(HideResult=true);
  input Boolean enable "Is the transition enabled by input places?" annotation(HideResult=true);
  output Boolean active "Is the transition active?" annotation(HideResult=true);
  output Integer arcWeight "Real input arc weights of the transition" annotation(HideResult=true);
  annotation(Icon(coordinateSystem(initialScale = 0.1), graphics = {Polygon(fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, points = {{-2, 100}, {98, 0}, {0, -98}, {-2, 100}}), Polygon(origin = {-2, 2}, rotation = 180, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, points = {{-2, 100}, {98, 0}, {0, -98}, {-2, 100}})}));
end HybTransitionOutIn;
