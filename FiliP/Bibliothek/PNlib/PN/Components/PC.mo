within PNlib.PN.Components;
model PC "Continuous Place"
  Real t "marking";
  parameter Integer nInCon(min=0)= 0 "number of input transitions" annotation(Dialog(enable=true,group="Connector sizing"));
  parameter Integer nOutCon(min=0)= 0 "number of output transitions" annotation(Dialog(enable=true,group="Connector sizing"));
  parameter Integer nInDis(min=0)= 0 "number of discrete input transitions" annotation(Dialog(enable=true,group="Connector sizing"));
  parameter Integer nOutDis(min=0)= 0 "number of discrete hybrid output transitions" annotation(Dialog(enable=true,group="Connector sizing"));
  parameter Integer nOutExt(min=0)=0 "number of output transitions" annotation(Dialog(enable=true,group="Connector sizing"));
  //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
  parameter Real startTokens = 0 "start marks" annotation(Dialog(enable = true, group = "Marks"));
  parameter Real minTokens = 0 "minimum capacity" annotation(Dialog(enable = true, group = "Marks"));
  parameter Real maxTokens=PNlib.Constants.inf "maximum capacity" annotation(Dialog(enable = true, group = "Marks"));
  parameter Boolean showTokenFlow=false;
  parameter PNlib.Types.EnablingType enablingType=PNlib.Types.EnablingType.Priority
    "resolution type of actual conflict (type-1-conflict)" annotation(Dialog(enable = true, group = "Enabling"));
  parameter Integer enablingPrioIn[nInDis]=1:nInDis
    "enabling priorities of input transitions" annotation(Dialog(enable = if enablingType==PNlib.Types.EnablingType.Priority then true else false, group = "Enabling"));
  parameter Integer enablingPrioOut[nOutDis]=1:nOutDis
    "enabling priorities of output transitions" annotation(Dialog(enable = if enablingType==PNlib.Types.EnablingType.Priority then true else false, group = "Enabling"));
  parameter Real enablingProbIn[nInDis]=fill(1/nInDis, nInDis)
    "enabling probabilities of input transitions" annotation(Dialog(enable = if enablingType==PNlib.Types.EnablingType.Probability then true else false, group = "Enabling"));
  parameter Real enablingProbOut[nOutDis]=fill(1/nOutDis, nOutDis)
    "enabling probabilities of output transitions" annotation(Dialog(enable = if enablingType==PNlib.Types.EnablingType.Probability then true else false, group = "Enabling"));
  parameter Real enablingBeneIn[nInDis]=1:nInDis
      "enabling benefit of input transitions" annotation(Dialog(enable = if enablingType==PNlib.Types.EnablingType.Benefit then true else false, group = "Enabling"));
  parameter Real enablingBeneOut[nOutDis]=1:nOutDis
      "enabling benefit of output transitions" annotation(Dialog(enable = if enablingType==PNlib.Types.EnablingType.Benefit then true else false, group = "Enabling"));
  parameter PNlib.Types.BenefitType benefitType=PNlib.Types.BenefitType.Greedy
        "enabling strategy for benefit" annotation(Dialog(enable = if enablingType==PNlib.Types.EnablingType.Benefit then true else false, group = "Enabling"));
  Real decFactorIn[nInCon] "decreasing factors for input transitions";
  Real decFactorOut[nOutCon] "decreasing factors for output transitions";
  //****MODIFIABLE PARAMETERS AND VARIABLES END****//
  parameter Integer localSeedIn = PNlib.Functions.Random.counter() "Local seed to initialize random number generator for input conflicts" annotation(Dialog(enable = true, group = "Random Number Generator"));
  parameter Integer localSeedOut = PNlib.Functions.Random.counter() "Local seed to initialize random number generator for output conflicts" annotation(Dialog(enable = true, group = "Random Number Generator"));
  PNlib.PN.Interfaces.ConPlaceIn inTransitionCon[nInCon](
  each t=t_,
  each maxTokens=maxTokens,
  each emptied = emptying.anytrue,
  decreasingFactor = decFactorIn,
  each speedSum= firingSumOutCon.conFiringSum,
  fire=fireInCon,
  active=activeInCon,
  arcWeight=arcWeightInCon,
  instSpeed=instSpeedIn,
  maxSpeed=maxSpeedIn,
  prelimSpeed=prelimSpeedIn) if nInCon > 0 "connector for input transitions" annotation(Placement(
        transformation(extent={{-114, -10}, {-98, 10}}, rotation=0),
    iconTransformation(extent={{-116, -10}, {-100, 10}})));
  PNlib.PN.Interfaces.ConPlaceOut outTransitionCon[nOutCon](
  each t = t_,
  each minTokens=minTokens,
  each fed=feeding.anytrue,
  decreasingFactor=decFactorOut,
  each speedSum=firingSumInCon.conFiringSum,
  fire=fireOutCon,
  active=activeOutCon,
  arcWeight=arcWeightOutCon,
  instSpeed=instSpeedOut,
  maxSpeed=maxSpeedOut,
  prelimSpeed=prelimSpeedOut) if nOutCon > 0 "connector for output transitions" annotation(Placement(
        transformation(extent={{100, -10}, {116, 10}}, rotation=0)));
  PNlib.PN.Interfaces.HybPlaceIn inTransitionDis[nInDis](
  each t=t_,
  each maxTokens=maxTokens,
  enable=enableIn.value,
  fire=fireInDis,
  arcWeight=arcWeightInDis,
  active=activeInDis,
  enabledByInPlaces=enabledByInPlaces) if nInDis > 0 "connector for input transitions" annotation(Placement(visible = true,transformation(extent={{-114, -52}, {-98, -32}}, rotation=0), iconTransformation(extent = {{-86, -82}, {-70, -62}}, rotation = 45)));
  PNlib.PN.Interfaces.HybPlaceOut outTransitionDis[nOutDis](
  each t=t_,
  each minTokens=minTokens,
  enable=enableOut.value,
  each tokenInOut=pre(disMarksInOut.value),
  fire=fireOutDis,
  arcWeight=arcWeightOutDis,
  active=activeOutDis) if nOutDis > 0 "connector for output transitions" annotation(Placement(visible = true, transformation(extent = {{100, -44}, {116, -24}}, rotation = 0), iconTransformation(extent = {{68, -82}, {84, -62}}, rotation = -45)));
  PNlib.PN.Interfaces.PlaceOutExt extOut[nOutExt](each t=t) if nOutExt > 0 "connector for output extended Arcs" annotation(Placement(transformation(extent={{70, 62}, {86, 82}}, rotation =45)));
  // decreasing
  /*PNlib.PN.Interfaces.RealConIn decFactorIn1 [nInCon] (value=decFactorIn) if (nInCon>0 and nOutCon>0);
  PNlib.PN.Interfaces.RealConIn decFactorIn2 [nInCon](each value=1.0) if not (nInCon>0 and nOutCon>0);
  PNlib.PN.Interfaces.RealConOut decFactorIn [nInCon];
  PNlib.PN.Interfaces.RealConIn decFactorOut1 [nOutCon] (value=decFactorOut) if (nInCon>0 and nOutCon>0);
  PNlib.PN.Interfaces.RealConIn decFactorOut2 [nOutCon] (each value=1.0) if not (nInCon>0 and nOutCon>0);
  PNlib.PN.Interfaces.RealConOut decFactorOut [nOutCon];*/
  // Discrete
  PNlib.PN.Interfaces.BooleanConIn disMarksInOut1(value=(pre(disMarksIn.anytrue) or pre(disMarksOut.anytrue))) if (nInDis>0 and nOutDis>0);
  PNlib.PN.Interfaces.BooleanConIn disMarksInOut2(value=pre(disMarksIn.anytrue)) if (nInDis>0 and nOutDis==0);
  PNlib.PN.Interfaces.BooleanConIn disMarksInOut3(value=pre(disMarksOut.anytrue)) if (nInDis==0 and nOutDis>0);
  PNlib.PN.Interfaces.BooleanConIn disMarksInOut4(value=false) if (nInDis==0 and nOutDis==0);
  PNlib.PN.Interfaces.BooleanConOut disMarksInOut;
 //Enable
  PNlib.PN.Interfaces.BooleanConIn PrioIn [nInDis](value=enableInPrio.TEin_) if (nInDis>0 and enablingType==PNlib.Types.EnablingType.Priority);
  PNlib.PN.Interfaces.BooleanConIn PrioOut[nOutDis](value=enableOutPrio.TEout_) if (nOutDis>0 and enablingType==PNlib.Types.EnablingType.Priority);
  PNlib.PN.Interfaces.BooleanConIn ProbIn[nInDis](value=enableInProb.TEin_) if (nInDis>0 and enablingType==PNlib.Types.EnablingType.Probability);
  PNlib.PN.Interfaces.BooleanConIn ProbOut[nOutDis](value=enableOutProb.TEout_) if (nOutDis>0 and enablingType==PNlib.Types.EnablingType.Probability);
  PNlib.PN.Interfaces.BooleanConIn enableInDummy[nInDis](value=false) if (nInDis==0);
  PNlib.PN.Interfaces.BooleanConIn enableOutDummy[nOutDis](value=false) if (nOutDis==0);
  PNlib.PN.Interfaces.BooleanConOut enableIn[nInDis];
  PNlib.PN.Interfaces.BooleanConOut enableOut[nOutDis];
 //Firesum Dis
  PNlib.PN.Interfaces.RealConIn firingSum1Dis(value=firingSumInDis.firingSum) if nInDis>0;
  PNlib.PN.Interfaces.RealConIn firingSum2Dis(value=firingSumOutDis.firingSum) if nOutDis>0;
  PNlib.PN.Interfaces.RealConIn firingSum3Dis(value=0) if nInDis==0;
  PNlib.PN.Interfaces.RealConIn firingSum4Dis(value=0) if nOutDis==0;
  PNlib.PN.Interfaces.RealConOut firingSumInputDis;
  PNlib.PN.Interfaces.RealConOut firingSumOutputDis;
protected
  outer PNlib.PN.Components.Settings settings "global settings for animation and display";
  Real conMarkChange "continuous mark change";
  Real arcWeightInCon[nInCon] "weights of input arcs";
  Real arcWeightOutCon[nOutCon] "weights of output arcs";
  Real instSpeedIn[nInCon] "instantaneous speed of input transitions";
  Real instSpeedOut[nOutCon] "instantaneous speed of output transitions";
  Real maxSpeedIn[nInCon] "maximum speed of input transitions";
  Real maxSpeedOut[nOutCon] "maximum speed of output transitions";
  Real prelimSpeedIn[nInCon] "preliminary speed of input transitions";
  Real prelimSpeedOut[nOutCon] "preliminary speed of output transitions";
  Real t_(start=startTokens, fixed=true) "marking";
  Boolean preFireIn[nInCon] "pre-value of fireIn";
  Boolean preFireOut[nOutCon] "pre-value of fireOut";
  Boolean fireInCon[nInCon](each start=false, each fixed=true) "Does any input transition fire?";
  Boolean fireOutCon[nOutCon](each start=false, each fixed=true) "Does any output transition fire?";
  Boolean activeInCon[nInCon] "Are the input transitions active?";
  Boolean activeOutCon[nOutCon] "Are the output transitions active?";
  // Discrete
  Real disMarkChange "discrete mark change";
  Real arcWeightInDis[nInDis] "Integer weights of input arcs";
  Real arcWeightOutDis[nOutDis] "Integer weights of output arcs";
  Boolean fireInDis[nInDis] "Do input transtions fire?";
  Boolean activeInDis[nInDis] "Are times passed of input transitions?";
  Boolean enabledByInPlaces[nInDis] "Are input transitions are enabled by all their input places?";
  Boolean fireOutDis[nOutDis] "Do output transitions fire?";
  Boolean activeOutDis[nOutDis](each start=false, each fixed=true) "Are time passed of output transitions?";
  //****BLOCKS BEGIN****// since no events are generated within functions!!!
  PNlib.PN.Blocks.tokenFlowCon tokenFlow(nIn=nInCon, nOut=nOutCon, conFiringSumIn=firingSumInCon.conFiringSum, conFiringSumOut=firingSumOutCon.conFiringSum, fireIn=fireIn, fireOut=fireOut, arcWeightIn=arcWeightIn, arcWeightOut=arcWeightOut, instSpeedIn=instSpeedIn, instSpeedOut=instSpeedOut) if showTokenFlow;
  //Is the place fed by input transitions?
  PNlib.PN.Blocks.anyTrue feeding(vec=preFireIn);
  //Is the place emptied by output transitions?"
  PNlib.PN.Blocks.anyTrue emptying(vec=preFireOut);
  //firing sum calculation for Continuous
  PNlib.PN.Blocks.firingSumCon firingSumInCon(fire=preFireIn, arcWeight=arcWeightInCon, instSpeed=instSpeedIn);
  PNlib.PN.Blocks.firingSumCon firingSumOutCon(fire=preFireOut, arcWeight=arcWeightOutCon, instSpeed=instSpeedOut);
  //PNlib.PN.Blocks.decreasingFactor decreasingFactorCon (nIn=nInCon, nOut=nOutCon, t=t_, minTokens=minTokens, maxTokens=maxTokens, speedIn= firingSumInCon.conFiringSum, speedOut= firingSumOutCon.conFiringSum, maxSpeedIn=maxSpeedIn, maxSpeedOut=maxSpeedOut, prelimSpeedIn=prelimSpeedIn, prelimSpeedOut=prelimSpeedOut, arcWeightIn=arcWeightInCon, arcWeightOut=arcWeightOutCon, firingIn=fireInCon, firingOut=fireOutCon) if nInCon>0 and nOutCon>0 ;
  //Does any time passed of a connected transition?
  PNlib.Blocks.anyTrue timePassedOut(vec=activeOutDis) if nOutDis>0;
  PNlib.Blocks.anyTrue timePassedIn(vec=activeInDis) if nInDis>0;
  //firing sum calculation for Discrete
  PN.Blocks.firingSumDisHyb firingSumInDis(fire=fireInDis, arcWeight=arcWeightInDis) if nInDis>0;
  PN.Blocks.firingSumDisHyb firingSumOutDis(fire=fireOutDis, arcWeight=arcWeightOutDis) if nOutDis>0;
  //Enabling process Prio
  PNlib.PN.Blocks.enablingOutConPrio enableOutPrio(timePassed=timePassedOut.anytrue, nOut=nOutDis, arcWeight=arcWeightOutDis, t=t_, minTokens=minTokens, TAout=activeOutDis, enablingPrio=enablingPrioOut) if (nOutDis>0 and enablingType==PNlib.Types.EnablingType.Priority);
  PNlib.PN.Blocks.enablingInConPrio enableInPrio(timePassed=timePassedIn.anytrue, active=activeInDis, nIn=nInDis, arcWeight=arcWeightInDis, t=t_, maxTokens=maxTokens, TAein=enabledByInPlaces and activeInDis, enablingPrio=enablingPrioIn) if (nInDis>0 and enablingType==PNlib.Types.EnablingType.Priority);
  //Enabling process Prob
  PNlib.PN.Blocks.enablingOutConProb enableOutProb(timePassed=timePassedOut.anytrue, nOut=nOutDis, arcWeight=arcWeightOutDis, t=t_, minTokens=minTokens, TAout=activeOutDis,  enablingProb=enablingProbOut, localSeed=localSeedOut, globalSeed=settings.globalSeed) if (nOutDis>0 and enablingType==PNlib.Types.EnablingType.Probability);
  PNlib.PN.Blocks.enablingInConProb enableInProb(timePassed=timePassedIn.anytrue, active=activeInDis, nIn=nInDis, arcWeight=arcWeightInDis, t=t_, maxTokens=maxTokens, TAein=enabledByInPlaces and activeInDis, enablingProb=enablingProbIn, localSeed=localSeedIn, globalSeed=settings.globalSeed) if (nInDis>0 and enablingType==PNlib.Types.EnablingType.Probability);
  //Does any discrete transition fire?
  PNlib.PN.Blocks.anyTrue disMarksOut(vec=fireOutDis);
  PNlib.PN.Blocks.anyTrue disMarksIn(vec=fireInDis);

//****BLOCKS END****//
equation
  if nInCon>0 and nOutCon>0 then
    (decFactorIn, decFactorOut)= PNlib.PN.Functions.decreasingFactor(nIn=nInCon, nOut=nOutCon, t=t_, minTokens=minTokens, maxTokens=maxTokens, speedIn= firingSumInCon.conFiringSum, speedOut= firingSumOutCon.conFiringSum, maxSpeedIn=maxSpeedIn, maxSpeedOut=maxSpeedOut, prelimSpeedIn=prelimSpeedIn, prelimSpeedOut=prelimSpeedOut, arcWeightIn=arcWeightInCon, arcWeightOut=arcWeightOutCon, firingIn=fireInCon, firingOut=fireOutCon);
  else
   decFactorIn=fill(1, nInCon);
   decFactorOut=fill(1, nOutCon);
  end if;
//decreasing factor calculation
  /*for i in 1:nInCon loop
    connect(decFactorIn[i], decFactorIn1[i]);
    connect(decFactorIn[i], decFactorIn2[i]);
  end for;
  for i in 1:nOutCon loop
    connect(decFactorOut[i],decFactorOut1[i]);
    connect(decFactorOut[i],decFactorOut2[i]);
  end for;*/
//Discrete
  connect(disMarksInOut,disMarksInOut1);
  connect(disMarksInOut,disMarksInOut2);
  connect(disMarksInOut,disMarksInOut3);
  connect(disMarksInOut,disMarksInOut4);
for i in 1:nInDis loop
  connect(enableIn[i],PrioIn[i]);
  connect(enableIn[i],ProbIn[i]);
end for;
for i in 1:nOutDis loop
  connect(enableOut[i],PrioOut[i]);
  connect(enableOut[i],ProbOut[i]);
end for;
  connect(firingSumInputDis,firingSum1Dis);
  connect(firingSumInputDis,firingSum3Dis);
  connect(firingSumOutputDis,firingSum2Dis);
  connect(firingSumOutputDis,firingSum4Dis);
//calculation of continuous mark change
  conMarkChange = firingSumInCon.conFiringSum - firingSumOutCon.conFiringSum;
  der(t_)=conMarkChange;
  for i in 1:nOutCon loop
    preFireOut[i]=pre(fireOutCon[i]);
  end for;
  for i in 1:nInCon loop
    preFireIn[i]= pre(fireInCon[i]);
  end for;
  t = noEvent(if t_ < minTokens then minTokens elseif t_ > maxTokens then maxTokens else t_);
//calculation of Discrete mark change
  disMarkChange = firingSumInputDis.value - firingSumOutputDis.value;
  when disMarksInOut.value then
    reinit(t_, t_ + pre(disMarkChange));
  end when;
//****MAIN END****//
//****ERROR MESSENGES BEGIN****//
  assert(startTokens >= minTokens and startTokens <= maxTokens, "minTokens<=startTokens<=maxTokens");
  assert(PNlib.Functions.OddsAndEnds.prioCheck(enablingPrioIn,nInDis) or nInDis==0, "The priorities of the input priorities may be given only once and must be selected from 1 to nIn");
  assert(PNlib.Functions.OddsAndEnds.prioCheck(enablingPrioOut,nOutDis) or nOutDis==0, "The priorities of the output priorities may be given only once and must be selected from 1 to nOut");
  assert(PNlib.Functions.OddsAndEnds.isEqual(sum(enablingProbIn), 1.0, 1e-6) or nInDis==0 or enablingType==PNlib.Types.EnablingType.Priority, "The sum of input enabling probabilities has to be equal to 1");
  assert(PNlib.Functions.OddsAndEnds.isEqual(sum(enablingProbOut), 1.0, 1e-6) or nOutDis==0 or enablingType==PNlib.Types.EnablingType.Priority, "The sum of output enabling probabilities has to be equal to 1");
//****ERROR MESSENGES END****//
   annotation(defaultComponentName = "P1", Icon(graphics={
        Ellipse(
          extent={{-100, 98}, {100, -96}},
          lineColor={0, 0, 0},
          fillColor={255, 255, 255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-88, 86}, {88, -86}},
          lineColor={0, 0, 0},
          fillColor=DynamicSelect({255, 255, 255}, color),
          fillPattern=FillPattern.Solid),
      Text(
        extent={{-1.5, 25.5}, {-1.5, -21.5}},
        lineColor={0, 0, 0},
        origin={0.5, -0.5},
        rotation=0,
        textString=DynamicSelect("%startTokens", if animateMarking then if t>0 then realString(t, 1, 2) else "0.0" else " ")),
        Text(
          extent={{0, -130}, {0, -116}},
          lineColor={0, 0, 0},
          textString=DynamicSelect("Cmax=%maxTokens", "Cmax=%maxTokens")),
                  Text(
          extent={{0, -150}, {0, -136}},
          lineColor={0, 0, 0},
          textString=DynamicSelect("Cmin=%minTokens", "Cmin=%minTokens" )),
                                          Text(
          extent={{-0, 113}, {-0, 138}},
          lineColor={0, 0, 0},
          textString="%name")}),
  Diagram(graphics));
end PC;
