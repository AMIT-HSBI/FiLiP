within PNlib.PN.Components;
model PD "Discrete Place"
  discrete Integer t(start = startTokens, fixed=true) "marking";
  parameter Integer nInDis(min=0)=0 "number of input transitions" annotation(Dialog(enable=true,group="Connector sizing"));
  parameter Integer nOutDis(min=0)=0 "number of output transitions" annotation(Dialog(enable=true,group="Connector sizing"));
  parameter Integer nCon(min=0)=0 "number of continus transitions" annotation(Dialog(enable=true,group="Connector sizing"));
  parameter Integer nOutExt(min=0)=0 "number of output transitions" annotation(Dialog(enable=true,group="Connector sizing"));
  //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
  parameter Integer startTokens = 0 "start tokens" annotation(Dialog(enable = true, group = "Tokens"));
  parameter Integer minTokens = 0 "minimum capacity" annotation(Dialog(enable = true, group = "Tokens"));
  parameter Integer maxTokens=PNlib.Constants.Integer_inf "maximum capacity" annotation(Dialog(enable = true, group = "Tokens"));

  parameter PNlib.Types.EnablingType enablingType=PNlib.Types.EnablingType.Priority
    "resolution type of actual conflict (type-1-conflict)" annotation(Dialog(enable = true, group = "Enabling"));
  parameter PNlib.Types.BenefitType benefitType=PNlib.Types.BenefitType.Greedy
          "enabling strategy for benefit" annotation(Dialog(enable = if enablingType==PNlib.Types.EnablingType.Benefit then true else false, group = "Enabling"));
  parameter Integer enablingPrioIn[nInDis]=1:nInDis
    "enabling priorities of input transitions" annotation(Dialog(enable = if enablingType==PNlib.Types.EnablingType.Priority then true else false, group = "Enabling Dis"));
  parameter Integer enablingPrioOut[nOutDis]=1:nOutDis
    "enabling priorities of output transitions" annotation(Dialog(enable = if enablingType==PNlib.Types.EnablingType.Priority then true else false, group = "Enabling Dis"));
  parameter Real enablingProbIn[nInDis]=fill(1/nInDis, nInDis)
    "enabling probabilities of input transitions" annotation(Dialog(enable = if enablingType==PNlib.Types.EnablingType.Probability then true else false, group = "Enabling Dis"));
  parameter Real enablingProbOut[nOutDis]=fill(1/nOutDis, nOutDis)
    "enabling probabilities of output transitions" annotation(Dialog(enable = if enablingType==PNlib.Types.EnablingType.Probability then true else false, group = "Enabling Dis"));
  parameter Real enablingBeneIn[nInDis]=1:nInDis
      "enabling benefit of input transitions" annotation(Dialog(enable = if enablingType==PNlib.Types.EnablingType.Benefit then true else false, group = "Enabling Dis"));
  parameter Real enablingBeneOut[nOutDis]=1:nOutDis
      "enabling benefit of output transitions" annotation(Dialog(enable = if enablingType==PNlib.Types.EnablingType.Benefit then true else false, group = "Enabling Dis"));
  parameter Integer enablingPrioCon[nCon]=1:nCon
        "enabling priorities of continus transitions" annotation(Dialog(enable = if enablingType==PNlib.Types.EnablingType.Priority then true else false, group = "Enabling Con"));

  parameter Integer localSeedIn = PNlib.Functions.Random.counter() "Local seed to initialize random number generator for input conflicts" annotation(Dialog(enable = true, group = "Random Number Generator"));
  parameter Integer localSeedOut = PNlib.Functions.Random.counter() "Local seed to initialize random number generator for output conflicts" annotation(Dialog(enable = true, group = "Random Number Generator"));

  //****MODIFIABLE PARAMETERS AND VARIABLES END****//
protected
  outer PNlib.PN.Components.Settings settings "global settings for animation and display";
  discrete Integer pret "pre marking";
  //Boolean tokeninout(start=false, fixed=true) "change of tokens?";
  Integer arcWeightInDis[nInDis] "Integer weights of input arcs";
  Boolean fireInDis[nInDis] "Do input transtions fire?";
  Boolean activeInDis[nInDis] "Are times passed of input transitions?";
  Boolean enabledByInPlaces[nInDis]
    "Are input transitions are enabled by all their input places?";
  Integer arcWeightOutDis[nOutDis] "Integer weights of output arcs";
  Boolean fireOutDis[nOutDis] "Do output transitions fire?";
  Boolean activeOutDis[nOutDis](each start=false, each fixed=true) "Are time passed of output transitions?";
  Integer arcWeightCon[nCon] "Integer weights of input arcs";
  Boolean activeCon[nCon] "Are times passed of input transitions?";
  //****BLOCKS BEGIN****// since no events are generated within functions!!!
  //Does any time passed of a connected transition?
  PNlib.Blocks.anyTrue timePassedOut(vec=activeOutDis) if nOutDis>0;
  PNlib.Blocks.anyTrue timePassedIn(vec=activeInDis) if nInDis>0;
  //firing sum calculation
  PNlib.PN.Blocks.firingSumDis firingSumIn(fire=fireInDis, arcWeight=arcWeightInDis) if nInDis>0;
  PNlib.PN.Blocks.firingSumDis firingSumOut(fire=fireOutDis, arcWeight=arcWeightOutDis) if nOutDis>0;
  //Enabling process Prio
  PNlib.PN.Blocks.enablingOutDisPrio enableOutPrio(timePassed=timePassedOut.anytrue, nOut=nOutDis, arcWeight=arcWeightOutDis, t=pret, minTokens=minTokens, TAout=activeOutDis, enablingPrio=enablingPrioOut) if (nOutDis>0 and enablingType==PNlib.Types.EnablingType.Priority);
  PNlib.PN.Blocks.enablingInDisPrio enableInPrio(timePassed=timePassedIn.anytrue, active=activeInDis, nIn=nInDis, arcWeight=arcWeightInDis, t=pret, maxTokens=maxTokens, TAein= enabledByInPlaces and activeInDis, enablingPrio=enablingPrioIn) if (nInDis>0 and enablingType==PNlib.Types.EnablingType.Priority);

  PNlib.PN.Blocks.enablingConPrio enableConPrio(nCon=nCon, arcWeight=arcWeightCon, t=pret, minTokens=minTokens, maxTokens=maxTokens, TA=activeCon, enablingPrio=enablingPrioCon) if (nCon>0 and enablingType==PNlib.Types.EnablingType.Priority);
  //Enabling process Prob
  PNlib.PN.Blocks.enablingOutDisProb enableOutProb(timePassed=timePassedOut.anytrue, nOut=nOutDis, arcWeight=arcWeightOutDis, t=pret, minTokens=minTokens, TAout=activeOutDis,  enablingProb=enablingProbOut, localSeed=localSeedOut, globalSeed=settings.globalSeed) if (nOutDis>0 and enablingType==PNlib.Types.EnablingType.Probability);
  PNlib.PN.Blocks.enablingInDisProb enableInProb(timePassed=timePassedIn.anytrue, active=activeInDis, nIn=nInDis, arcWeight=arcWeightInDis, t=pret, maxTokens=maxTokens, TAein=enabledByInPlaces and activeInDis, enablingProb=enablingProbIn, localSeed=localSeedIn, globalSeed=settings.globalSeed) if (nInDis>0 and enablingType==PNlib.Types.EnablingType.Probability);
  //Enabling process Benefit Greedy
  PNlib.PN.Blocks.enablingOutDisBeneGreedy enableOutBeneGreedy (timePassed=timePassedOut.anytrue, nOut=nOutDis, arcWeight=arcWeightOutDis, t=pret, minTokens=minTokens, TAout=activeOutDis,  enablingBene=enablingBeneOut) if (nOutDis>0 and enablingType==PNlib.Types.EnablingType.Benefit and benefitType==PNlib.Types.BenefitType.Greedy);
  PNlib.PN.Blocks.enablingInDisBeneGreedy enableInBeneGreedy (timePassed=timePassedIn.anytrue, active=activeInDis, nIn=nInDis, arcWeight=arcWeightInDis, t=pret, maxTokens=maxTokens, TAein=enabledByInPlaces and activeInDis, enablingBene=enablingBeneIn) if (nInDis>0 and enablingType==PNlib.Types.EnablingType.Benefit and benefitType==PNlib.Types.BenefitType.Greedy);
  //Enabling process Benefit Quotient
  PNlib.PN.Blocks.enablingOutDisBeneQuotient enableOutBeneQuotient (timePassed=timePassedOut.anytrue, nOut=nOutDis, arcWeight=arcWeightOutDis, t=pret, minTokens=minTokens, TAout=activeOutDis,  enablingBene=enablingBeneOut) if (nOutDis>0 and enablingType==PNlib.Types.EnablingType.Benefit and benefitType==PNlib.Types.BenefitType.BenefitQuotient);
  PNlib.PN.Blocks.enablingInDisBeneQuotient enableInBeneQuotient (timePassed=timePassedIn.anytrue, active=activeInDis, nIn=nInDis, arcWeight=arcWeightInDis, t=pret, maxTokens=maxTokens, TAein=enabledByInPlaces and activeInDis, enablingBene=enablingBeneIn) if (nInDis>0 and enablingType==PNlib.Types.EnablingType.Benefit and benefitType==PNlib.Types.BenefitType.BenefitQuotient);
  //Enabling process Benefit Branch and Bound
  PNlib.PN.Blocks.enablingOutDisBeneBaB enableOutBeneBaB (timePassed=timePassedOut.anytrue, nOut=nOutDis, arcWeight=arcWeightOutDis, t=pret, minTokens=minTokens, TAout=activeOutDis,  enablingBene=enablingBeneOut) if (nOutDis>0 and enablingType==PNlib.Types.EnablingType.Benefit and benefitType==PNlib.Types.BenefitType.BranchAndBound);
  PNlib.PN.Blocks.enablingInDisBeneBaB enableInBeneBaB (timePassed=timePassedIn.anytrue, active=activeInDis, nIn=nInDis, arcWeight=arcWeightInDis, t=pret, maxTokens=maxTokens, TAein=enabledByInPlaces and activeInDis, enablingBene=enablingBeneIn) if (nInDis>0 and enablingType==PNlib.Types.EnablingType.Benefit and benefitType==PNlib.Types.BenefitType.BranchAndBound);
  //****BLOCKS END****//
public

  PNlib.PN.Interfaces.DisPlaceIn inTransitionDis[nInDis](
    each tint=pret,
    each maxTokensint=maxTokens,
    enable=enableIn.value,
    fire=fireInDis,
    arcWeightint=arcWeightInDis,
    active=activeInDis,
    enabledByInPlaces=enabledByInPlaces) if nInDis > 0 "connector for input transitions" annotation(Placement(transformation(extent={{-114, -10}, {-98, 10}}, rotation=0), iconTransformation(extent={{-116, -10}, {-100, 10}})));
  PNlib.PN.Interfaces.DisPlaceOut outTransitionDis[nOutDis](
    each tint=pret,
    each minTokensint=minTokens,
    enable=enableOut.value,
    each tokenInOut=pre(tokeninout.value),
    fire=fireOutDis,
    arcWeightint=arcWeightOutDis,
    active=activeOutDis) if nOutDis > 0 "connector for output transitions" annotation(Placement(transformation(extent={{100, -10}, {116, 10}}, rotation=0)));
  PNlib.PN.Interfaces.HybPlaceOutIn inOutTransitionCon[nCon](
      each t=pret,
      each minTokens=minTokens,
      each maxTokens=maxTokens,
      enable=enableCon.value,
      arcWeight=arcWeightCon,
      active=activeCon) if nCon > 0 "connector for output transitions" annotation(Placement(transformation(extent = {{68, -82}, {84, -62}}, rotation = -45)));
  PNlib.PN.Interfaces.PlaceOutExt extOut[nOutExt](
      each t=pret) if nOutExt > 0 "connector for output extended Arcs" annotation(Placement(transformation(extent={{70, 62}, {86, 82}}, rotation =45)));

    PNlib.PN.Interfaces.BooleanConIn tokeninout1(value=(pre(firingSumIn.firingSum) > 0 or pre(firingSumOut.firingSum) > 0)) if (nInDis>0 and nOutDis>0);
    PNlib.PN.Interfaces.BooleanConIn tokeninout2(value=pre(firingSumIn.firingSum) > 0) if (nInDis>0 and nOutDis==0);
    PNlib.PN.Interfaces.BooleanConIn tokeninout3(value=pre(firingSumOut.firingSum) > 0) if (nInDis==0 and nOutDis>0);
    PNlib.PN.Interfaces.BooleanConIn tokeninout4(value=false) if (nInDis==0 and nOutDis==0);
    PNlib.PN.Interfaces.BooleanConOut tokeninout;

    PNlib.PN.Interfaces.BooleanConIn PrioIn [nInDis](value=enableInPrio.TEin_) if (nInDis>0 and enablingType==PNlib.Types.EnablingType.Priority);
    PNlib.PN.Interfaces.BooleanConIn PrioOut[nOutDis](value=enableOutPrio.TEout_) if (nOutDis>0 and enablingType==PNlib.Types.EnablingType.Priority);
    PNlib.PN.Interfaces.BooleanConIn ProbIn[nInDis](value=enableInProb.TEin_) if (nInDis>0 and enablingType==PNlib.Types.EnablingType.Probability);
    PNlib.PN.Interfaces.BooleanConIn ProbOut[nOutDis](value=enableOutProb.TEout_) if (nOutDis>0 and enablingType==PNlib.Types.EnablingType.Probability);
    PNlib.PN.Interfaces.BooleanConIn BeneInGreedy[nInDis](value=enableInBeneGreedy.TEin_) if (nInDis>0 and enablingType==PNlib.Types.EnablingType.Benefit and benefitType==PNlib.Types.BenefitType.Greedy);
    PNlib.PN.Interfaces.BooleanConIn BeneOutGreedy[nOutDis](value=enableOutBeneGreedy.TEout_) if (nOutDis>0 and enablingType==PNlib.Types.EnablingType.Benefit and benefitType==PNlib.Types.BenefitType.Greedy);
    PNlib.PN.Interfaces.BooleanConIn BeneInQuotient[nInDis](value=enableInBeneQuotient.TEin_) if (nInDis>0 and enablingType==PNlib.Types.EnablingType.Benefit and benefitType==PNlib.Types.BenefitType.BenefitQuotient);
    PNlib.PN.Interfaces.BooleanConIn BeneOutQuotient[nOutDis](value=enableOutBeneQuotient.TEout_) if (nOutDis>0 and enablingType==PNlib.Types.EnablingType.Benefit and benefitType==PNlib.Types.BenefitType.BenefitQuotient);
    PNlib.PN.Interfaces.BooleanConIn BeneInBaB[nInDis](value=enableInBeneBaB.TEin_) if (nInDis>0 and enablingType==PNlib.Types.EnablingType.Benefit and benefitType==PNlib.Types.BenefitType.BranchAndBound);
    PNlib.PN.Interfaces.BooleanConIn BeneOutBaB[nOutDis](value=enableOutBeneBaB.TEout_) if (nOutDis>0 and enablingType==PNlib.Types.EnablingType.Benefit and benefitType==PNlib.Types.BenefitType.BranchAndBound);
    PNlib.PN.Interfaces.BooleanConIn enableInDummy[nInDis](value=false) if (nInDis==0);
    PNlib.PN.Interfaces.BooleanConIn enableOutDummy[nOutDis](value=false) if (nOutDis==0);
    PNlib.PN.Interfaces.BooleanConOut enableIn[nInDis];
    PNlib.PN.Interfaces.BooleanConOut enableOut[nOutDis];
    //continus
    PNlib.PN.Interfaces.BooleanConIn PrioCon[nCon](value=enableConPrio.TE) if (nCon>0 and enablingType==PNlib.Types.EnablingType.Priority);
    PNlib.PN.Interfaces.BooleanConIn enableConDummy[nCon](value=false) if (nCon==0);
    PNlib.PN.Interfaces.BooleanConOut enableCon[nCon];

    PNlib.PN.Interfaces.IntegerConIn firingSum1(value=firingSumIn.firingSum) if nInDis>0;
    PNlib.PN.Interfaces.IntegerConIn firingSum2(value=firingSumOut.firingSum) if nOutDis>0;
    PNlib.PN.Interfaces.IntegerConIn firingSum3(value=0) if nInDis==0;
    PNlib.PN.Interfaces.IntegerConIn firingSum4(value=0) if nOutDis==0;
    PNlib.PN.Interfaces.IntegerConOut firingSumInput;
    PNlib.PN.Interfaces.IntegerConOut firingSumOutput;


equation
  //****MAIN BEGIN****//
  //recalculation of tokens
  pret=pre(t);

  //tokeninout = (if nIn>0 then pre(firingSumIn.firingSum) > 0 else false) or (if nOut>0 then pre(firingSumOut.firingSum) > 0 else false);
  connect(tokeninout,tokeninout1);
  connect(tokeninout,tokeninout2);
  connect(tokeninout,tokeninout3);
  connect(tokeninout,tokeninout4);

for i in 1:nInDis loop
  connect(enableIn[i],PrioIn[i]);
  connect(enableIn[i],ProbIn[i]);
  connect(enableIn[i],BeneInGreedy[i]);
  connect(enableIn[i],BeneInQuotient[i]);
  connect(enableIn[i],BeneInBaB[i]);
  connect(enableIn[i],enableInDummy[i]);
end for;

for i in 1:nOutDis loop
  connect(enableOut[i],PrioOut[i]);
  connect(enableOut[i],ProbOut[i]);
  connect(enableOut[i],BeneOutGreedy[i]);
  connect(enableOut[i],BeneOutQuotient[i]);
  connect(enableOut[i],BeneOutBaB[i]);
  connect(enableOut[i],enableOutDummy[i]);
end for;

for i in 1:nCon loop
  connect(enableCon[i],PrioCon[i]);
  connect(enableCon[i],enableConDummy[i]);
end for;

  connect(firingSumInput,firingSum1);
  connect(firingSumInput,firingSum3);
  connect(firingSumOutput,firingSum2);
  connect(firingSumOutput,firingSum4);

  when {if nInDis>0 then pre(firingSumInput.value) > 0 else false, if nOutDis>0 then pre(firingSumOutput.value) > 0 else false} then
    t = pret + (if nInDis>0 then pre(firingSumInput.value)  else 0) - (if nOutDis>0 then pre(firingSumOutput.value) else 0);
  end when;
  //****MAIN END****//
  //****ERROR MESSENGES BEGIN****//
  assert(PNlib.Functions.OddsAndEnds.prioCheck(enablingPrioIn,nInDis) or nInDis==0, "The priorities of the input priorities may be given only once and must be selected from 1 to nInDis");
  assert(PNlib.Functions.OddsAndEnds.prioCheck(enablingPrioOut,nOutDis) or nOutDis==0, "The priorities of the output priorities may be given only once and must be selected from 1 to nOutDis");
  assert(PNlib.Functions.OddsAndEnds.isEqual(sum(enablingProbIn), 1.0, 1e-6) or nInDis==0 or enablingType==PNlib.Types.EnablingType.Priority, "The sum of input enabling probabilities has to be equal to 1");
  assert(PNlib.Functions.OddsAndEnds.isEqual(sum(enablingProbOut), 1.0, 1e-6) or nOutDis==0 or enablingType==PNlib.Types.EnablingType.Priority, "The sum of output enabling probabilities has to be equal to 1");
  assert(startTokens>=minTokens and startTokens<=maxTokens, "minTokens<=startTokens<=maxTokens");
  //****ERROR MESSENGES END****//
  annotation(defaultComponentName = "P1", Icon(graphics={Ellipse(
          extent={{-100, 96}, {100, -100}},
          lineColor={0, 0, 0},
          fillColor={255, 255, 255},
          fillPattern=FillPattern.Solid),
      Text(
        extent={{-1.5, 25.5}, {-1.5, -21.5}},
        lineColor={0, 0, 0},
        textString=DynamicSelect("%startTokens",realString(t, 1, 0))),
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
end PD;
