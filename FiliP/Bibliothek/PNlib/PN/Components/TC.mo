within PNlib.PN.Components;
model TC "Continuous Transition"
  parameter Integer nInCon(min=0)= 0 "number of input places" annotation(Dialog(enable=true,group="Connector sizing"));
  parameter Integer nOutCon(min=0)= 0 "number of output places" annotation(Dialog(enable=true,group="Connector sizing"));
  parameter Integer nDis(min=0)= 0 "number of output places" annotation(Dialog(enable=true,group="Connector sizing"));
  parameter Integer nInExt(min=0)= 0 "number of input places" annotation(Dialog(enable=true,group="Connector sizing"));
  //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
  Real maximumSpeed=1 "maximum speed" annotation(Dialog(enable = true, group = "Maximum Speed"));
  Real arcWeightInCon[nInCon]=fill(1, nInCon) "arc weights of input places" annotation(Dialog(enable = true, group = "Arc Weights"));
  Real arcWeightOutCon[nOutCon]=fill(1, nOutCon) "arc weights of output places" annotation(Dialog(enable = true, group = "Arc Weights"));
  Integer arcWeightDis[nDis]=fill(1, nDis) "arc weights of output places" annotation(Dialog(enable = true, group = "Arc Weights"));
  Boolean firingCon=true "Optinalonal firing condition" annotation(Dialog(enable = true, group = "Firing Condition"));
  //****MODIFIABLE PARAMETERS AND VARIABLES END****//
  Boolean fire "Does the transition fire?";
  Real instantaneousSpeed "instantaneous speed";
  Real prelimSpeed "preliminary speed";
  Real actualSpeed = if fire then instantaneousSpeed else 0.0;
  Boolean active;
  PNlib.PN.Interfaces.ConTransitionIn[nInCon] inPlacesCon(
    each active=active,
    each fire=fire,
    arcWeight=arcWeightInCon,
    each instSpeed = instantaneousSpeed,
    each prelimSpeed = prelimSpeed,
    each maxSpeed =  maximumSpeed,
    t=tInCon,
    minTokens=minTokensCon,
    fed=fed,
    speedSum=speedSumIn,
    decreasingFactor=decreasingFactorIn) if nInCon > 0 "connector for input places" annotation(Placement(transformation(extent={{ -56, -10}, {-40, 10}}, rotation=0)));
  PNlib.PN.Interfaces.ConTransitionOut[nOutCon] outPlacesCon(
    each active=active,
    each fire=fire,
    arcWeight=arcWeightOutCon,
    each instSpeed = instantaneousSpeed,
    each prelimSpeed = prelimSpeed,
    each maxSpeed =  maximumSpeed,
    t=tOutCon,
    maxTokens=maxTokensCon,
    emptied=emptied,
    speedSum=speedSumOut,
    decreasingFactor=decreasingFactorOut) if nOutCon > 0  "connector for output places" annotation(Placement(transformation(extent={{40, -10}, {56, 10}}, rotation=0)));
    PNlib.PN.Interfaces.HybTransitionOutIn inOutPlacesDis[nDis](
    each active = active,
    arcWeight = arcWeightDis,
    enable = enabledByDisPlaces,
    t = tDis,
    minTokens = minTokensDis,
    maxTokens = maxTokensDis) if nDis > 0 "connector for output places" annotation(
      Placement(visible = true, transformation(extent = {{-56, -98}, {-40, -78}}, rotation = 0), iconTransformation(extent = {{-56, -98}, {-40, -78}}, rotation = 0)));
    PNlib.PN.Interfaces.TransitionInExt extIn[nInExt](
          condition=extendedCondition) if nInExt > 0 "connector for output extended Arcs" annotation(Placement(transformation(extent={{-56, 80}, {-40, 100}}, rotation =0)));
protected
  Real tInCon[nInCon] "tokens of input places";
  Real tOutCon[nOutCon] "tokens of output places";
  Integer tDis[nDis] "tokens of output places";
  Real minTokensCon[nInCon] "minimum tokens of input places";
  Integer minTokensDis[nDis] "minimum tokens of Discrete places";
  Integer maxTokensDis[nDis] "maximum tokens of Discrete places";
  Real maxTokensCon[nOutCon] "maximum tokens of output places";
  Real speedSumIn[nInCon] "Input speeds of continuous input places";
  Real speedSumOut[nOutCon] "Output speeds of continuous output places";
  Real decreasingFactorIn[nInCon] "decreasing factors of input places";
  Real decreasingFactorOut[nOutCon] "decreasing factors of output places";
  Boolean fed[nInCon] "Are the input places fed by their input transitions?";
  Boolean emptied[nOutCon] "Are the output places emptied by their output transitions?";
  Boolean enabledByDisPlaces[nDis] "Is the extended Arc Condition true?";
  Boolean allEnabledByDisPlaces =PNlib.Functions.OddsAndEnds.allTrue(enabledByDisPlaces) "Are all the extended Arc Condition true?" ;
  Boolean extendedCondition[nInExt] "Is the extended Arc Condition true?";
  Boolean allExtendedCondition =PNlib.Functions.OddsAndEnds.allTrue(extendedCondition) "Are all the extended Arc Condition true?" ;
  //****BLOCKS BEGIN****// since no events are generated within functions!!!
  //activation process
  PNlib.PN.Blocks.activationCon conActivation(nIn=nInCon, nOut=nOutCon, tIn=tInCon, tOut=tOutCon, arcWeightIn=arcWeightInCon, arcWeightOut=arcWeightOutCon, minTokens=minTokensCon, maxTokens=maxTokensCon, firingCon=firingCon, fed=fed, emptied=emptied);
  PNlib.PN.Blocks.activationDis disActivation(nDis=nDis, tDis=tDis, arcWeightDis=arcWeightDis, minTokensDis=minTokensDis, maxTokensDis=maxTokensDis);
  //preliminary speed calculation
  //PNlib.PN.Blocks.preliminarySpeed prelimSpeed (nIn=nInCon, nOut=nOutCon, arcWeightIn=arcWeightInCon, arcWeightOut=arcWeightOutCon, speedSumIn=speedSumIn, speedSumOut=speedSumOut, maximumSpeed=maximumSpeed, weaklyInputActiveVec=conActivation.weaklyInputActiveVec, weaklyOutputActiveVec=conActivation.weaklyOutputActiveVec);
  //firing process
  //Boolean fire_ = PNlib.Functions.OddsAndEnds.allTrue(/* hack for Dymola 2017 */ PNlib.Functions.OddsAndEnds.boolOr(enableIn, not disPlaceIn));
  //****BLOCKS END****//
equation
  prelimSpeed = PNlib.PN.Functions.preliminarySpeed(nIn=nInCon, nOut=nOutCon, arcWeightIn=arcWeightInCon, arcWeightOut=arcWeightOutCon, speedSumIn=speedSumIn, speedSumOut=speedSumOut, maximumSpeed=maximumSpeed, weaklyInputActiveVec=conActivation.weaklyInputActiveVec, weaklyOutputActiveVec=conActivation.weaklyOutputActiveVec);
  //****MAIN BEGIN****//
  //preliminary speed calculation
  //prelimSpeed = PNlib.PN.Functions.preliminarySpeed(nIn=nIn, nOut=nOut, arcWeightIn=arcWeightIn, arcWeightOut=arcWeightOut, speedSumIn=speedSumIn, speedSumOut=speedSumOut, maximumSpeed=maximumSpeed, weaklyInputActiveVec=conActivation.weaklyInputActiveVec, weaklyOutputActiveVec=conActivation.weaklyOutputActiveVec);
  //firing process
  active = conActivation.active and disActivation.active and allExtendedCondition and firingCon;
  fire=active and allEnabledByDisPlaces and not maximumSpeed<=0;
  //instantaneous speed calculation
  instantaneousSpeed=min(min(min(decreasingFactorIn), min(decreasingFactorOut))*maximumSpeed, prelimSpeed);
  //****MAIN END****//
  //****ERROR MESSENGES BEGIN****//  hier noch Message gleiches Kantengewicht und auch Kante dis Place!!
  for i in 1:nInCon loop
    assert(arcWeightInCon[i]>=0, "Input arc weights must be positive.");
  end for;
  for i in 1:nOutCon loop
    assert(arcWeightOutCon[i]>=0, "Output arc weights must be positive.");
  end for;
  //****ERROR MESSENGES END****//
  annotation(defaultComponentName = "T1",
   Icon(graphics={Rectangle(extent={{-40, 100}, {40, -100}},
    lineColor={0, 0, 0},
     fillColor=DynamicSelect({255, 255, 255}, color),
      fillPattern=FillPattern.Solid),
       Text(
          extent={{-2, -116}, {-2, -144}},
          lineColor={0, 0, 0},
          textString=DynamicSelect("vmax=%maximumSpeed ", if animateSpeed then "vmax=%maximumSpeed " else " ")),
      Text(
          extent={{-2, -156}, {-2, -184}},
          lineColor={0, 0, 0},
          textString=DynamicSelect(" ", if animateSpeed and fire then if instantaneousSpeed>0 then "vakt="+realString(instantaneousSpeed, 1, 2) else "vakt=0.0" else " ")),
      Text(
          extent={{-4, 139}, {-4, 114}},
          lineColor={0, 0, 0},
          textString="%name")}));
end TC;
