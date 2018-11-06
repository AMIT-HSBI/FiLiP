within PNlib.PN.Interfaces;
connector ConTransitionIn "part of transition model to connect transitions to input places"
  input Real t "Markings of input places" annotation(HideResult=true);
  input Real minTokens "Minimum capacites of input places" annotation(HideResult=true);
  input Real decreasingFactor "Factor of continuous input places for decreasing the speed" annotation(HideResult=true);
  input Boolean fed "Are the continuous input places fed?" annotation(HideResult=true);
  input Real speedSum "Input speeds of continuous input places" annotation(HideResult=true);
  output Boolean active "Is the transition active?" annotation(HideResult=true);
  output Boolean fire "Does the transition fire?" annotation(HideResult=true);
  output Real arcWeight "Input arc weights of the transition" annotation(HideResult=true);
  output Real instSpeed "Instantaneous speed of a continuous transition" annotation(HideResult=true);
  output Real prelimSpeed "Preliminary speed of a continuous transition" annotation(HideResult=true);
  output Real maxSpeed "Maximum speed of a continuous transition" annotation(HideResult=true);
  annotation(Icon(graphics = {Polygon(fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {98, 0}, {-100, -100}, {-100, 100}})}, coordinateSystem(initialScale = 0.1)));
end ConTransitionIn;
