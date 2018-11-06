within PNlib.PN.Interfaces;
connector HybTransitionIn "part of transition model to connect transitions to input places"
  import PNlib.Types.ArcType;
  input Real t "Real Markings of input places" annotation(HideResult=true);
  input Real minTokens "Real minimum capacites of input places" annotation(HideResult=true);
  input Boolean enable "Is the transition enabled by input places?" annotation(HideResult=true);
  input Boolean tokenInOut "Do the input places have a discrete token change?" annotation(HideResult=true);
  output Boolean active "Is the transition active?" annotation(HideResult=true);
  output Boolean fire "Does the transition fire?" annotation(HideResult=true);
  output Real arcWeight "Real input arc weights of the transition" annotation(HideResult=true);
  annotation(Icon(graphics = {Polygon(fillColor = {170, 0, 255}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {98, 0}, {-100, -100}, {-100, 100}})}, coordinateSystem(initialScale = 0.1)));
end HybTransitionIn;
