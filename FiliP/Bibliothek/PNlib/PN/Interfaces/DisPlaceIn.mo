within PNlib.PN.Interfaces;
connector DisPlaceIn "part of place model to connect places to input transitions"
  input Boolean active "Are the input transitions active?" annotation(HideResult=true);
  input Boolean fire "Do the input transitions fire?" annotation(HideResult=true);
  input Integer arcWeightint "Integer arc weights of input transitions" annotation(HideResult=true);
  input Boolean enabledByInPlaces "Are the input transitions enabled by all theier input places?" annotation(HideResult=true);
  output Integer tint "Integer marking of the place" annotation(HideResult=true);
  output Integer maxTokensint "Integer maximum capacity of the place" annotation(HideResult=true);
  output Boolean enable "Which of the input transitions are enabled by the place?" annotation(HideResult=true);
  annotation(Icon(graphics={Polygon(points={{-100, 100}, {98, 0}, {-100, -100}, {-100, 100}}, lineColor={0, 0, 0}, fillColor={255, 0, 0}, fillPattern=FillPattern.Solid)}));
end DisPlaceIn;
