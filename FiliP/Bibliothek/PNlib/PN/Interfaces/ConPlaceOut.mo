within PNlib.PN.Interfaces;
connector ConPlaceOut "part of place model to connect places to output transitions"
  import PNlib.Types.ArcType;
  input Boolean active "Are the output transitions active?" annotation(HideResult=true);
  input Boolean fire "Do the output transitions fire?" annotation(HideResult=true);
  input Real arcWeight "Arc weights of output transitions" annotation(HideResult=true);
  input Real instSpeed "Instantaneous speeds of continuous output transitions" annotation(HideResult=true);
  input Real prelimSpeed "Preliminary speeds of continuous output transitions" annotation(HideResult=true);
  input Real maxSpeed "Maximum speeds of continuous output transitions" annotation(HideResult=true);
  output Real t "Marking of the place" annotation(HideResult=true);
  output Real minTokens "Minimum capacity of the place" annotation(HideResult=true);
  output Real decreasingFactor "Factor for decreasing the speed of continuous input transitions" annotation(HideResult=true);
  output Boolean fed "Is the continuous place fed by input transitions?" annotation(HideResult=true);
  output Real speedSum "Input speed of a continuous place" annotation(HideResult=true);
  annotation(Icon(graphics = {Polygon(fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {98, 0}, {-100, -100}, {-100, 100}})}, coordinateSystem(initialScale = 0.1)));
end ConPlaceOut;
