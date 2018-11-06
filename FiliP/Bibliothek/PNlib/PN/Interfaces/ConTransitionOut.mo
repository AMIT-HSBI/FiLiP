within PNlib.PN.Interfaces;
connector ConTransitionOut "part of transition model to connect transitions to output places"
  input Real t "Markings of output places" annotation(HideResult=true);
  input Real maxTokens "Maximum capacities of output places" annotation(HideResult=true);
  input Real decreasingFactor "Factor of continuous output places for decreasing the speed" annotation(HideResult=true);
  input Boolean emptied "Are the continuous output places emptied?" annotation(HideResult=true);
  input Real speedSum "Output speeds of continuous output places" annotation(HideResult=true);
  output Boolean active "Is the transition active?" annotation(HideResult=true);
  output Boolean fire "Does the transition fire?" annotation(HideResult=true);
  output Real arcWeight "Output arc weights of the transition" annotation(HideResult=true);
  output Real instSpeed "Instantaneous speed of a continuous transition" annotation(HideResult=true);
  output Real prelimSpeed "Preliminary speed of a continuous transition" annotation(HideResult=true);
  output Real maxSpeed "Maximum speed of a continuous transition" annotation(HideResult=true);
  annotation(Icon(graphics = {Polygon(fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {98, 0}, {-100, -100}, {-100, 100}})}, coordinateSystem(initialScale = 0.1)));
end ConTransitionOut;
