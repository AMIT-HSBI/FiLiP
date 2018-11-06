within PNlib.PN.Interfaces;
connector DisTransitionIn "part of transition model to connect transitions to input places"
  import PNlib.Types.ArcType;
  input Integer tint "Integer Markings of input places" annotation(HideResult=true);
  input Integer minTokensint "Integer minimum capacites of input places" annotation(HideResult=true);
  input Boolean enable "Is the transition enabled by input places?" annotation(HideResult=true);
  input Boolean tokenInOut "Do the input places have a discrete token change?" annotation(HideResult=true);
  output Boolean active "Is the transition active?" annotation(HideResult=true);
  output Boolean fire "Does the transition fire?" annotation(HideResult=true);
  output Integer arcWeightint "Integer input arc weights of the transition" annotation(HideResult=true);
  annotation(Icon(graphics={Polygon(points={{-100, 100}, {98, 0}, {-100, -100}, {-100, 100}}, lineColor={0, 0, 0}, fillColor={255, 0, 0}, fillPattern=FillPattern.Solid)}));
end DisTransitionIn;
