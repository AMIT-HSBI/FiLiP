within PNlib.PN.Interfaces;
connector ConPlaceIn "part of place model to connect places to input transitions"
  input Boolean active "Are the input transitions active?" annotation(HideResult=true);
  input Boolean fire "Do the input transitions fire?" annotation(HideResult=true);
  input Real arcWeight "Arc weights of input transitions" annotation(HideResult=true);
  input Real instSpeed "Instantaneous speeds of continuous input transitions" annotation(HideResult=true);
  input Real prelimSpeed "Preliminary speeds of continuous input transitions" annotation(HideResult=true);
  input Real maxSpeed "Maximum speeds of continuous input transitions" annotation(HideResult=true);
  output Real t "Marking of the place" annotation(HideResult=true);
  output Real maxTokens "Maximum capacity of the place" annotation(HideResult=true);
  output Real decreasingFactor "Factor for decreasing the speed of continuous input transitions" annotation(HideResult=true);
  output Boolean emptied "Is the continuous place emptied by output transitions?" annotation(HideResult=true);
  output Real speedSum "Output speed of a continuous place" annotation(HideResult=true);
  annotation(Icon(graphics = {Polygon(fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {98, 0}, {-100, -100}, {-100, 100}})}, coordinateSystem(initialScale = 0.1)));
end ConPlaceIn;
