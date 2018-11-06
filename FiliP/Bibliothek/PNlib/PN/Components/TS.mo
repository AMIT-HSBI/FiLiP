within PNlib.PN.Components;

model TS "Discrete Transition with delay "
  parameter Integer nInDis = 0 "number of input places" annotation(
    Dialog(enable = true, group = "Connector sizing"));
  parameter Integer nOutDis = 0 "number of output places" annotation(
    Dialog(enable = true, group = "Connector sizing"));
  parameter Integer nInCon = 0 "number of input places" annotation(
    Dialog(enable = true, group = "Connector sizing"));
  parameter Integer nOutCon = 0 "number of output places" annotation(
    Dialog(enable = true, group = "Connector sizing"));
  parameter Integer nInExt = 0 "number of input places" annotation(
    Dialog(enable = true, group = "Connector sizing"));
  //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
  parameter PNlib.Types.StoTimeType timeType=PNlib.Types.StoTimeType.Delay;
  parameter PNlib.Types.DistributionType distributionType=PNlib.Types.DistributionType.Exponential
    "distribution type of delay" annotation(Dialog(enable = true, group = "Distribution"));
  parameter  Real h=1
    "probability density" annotation(Dialog(enable = if distributionType==PNlib.Types.DistributionType.Exponential then true else false, group = "Exponential distribution"));
  parameter  Real a=0
    "Lower Limit" annotation(Dialog(enable = if distributionType==PNlib.Types.DistributionType.Triangular or distributionType==PNlib.Types.DistributionType.Uniform or distributionType==PNlib.Types.DistributionType.TruncatedNormal then true else false, group = "Triangular, Uniform or Truncated normal distribution"));
  parameter Real b=1
    "Upper Limit" annotation(Dialog(enable = if distributionType==PNlib.Types.DistributionType.Triangular or distributionType==PNlib.Types.DistributionType.Uniform or distributionType==PNlib.Types.DistributionType.TruncatedNormal then true else false, group = "Triangular, Uniform or Truncated normal distribution"));
  parameter Real c=0.5
    "Most likely value" annotation(Dialog(enable = if distributionType==PNlib.Types.DistributionType.Triangular then true else false, group = "Triangular distribution"));
  parameter Real mu=0.5
    "Expected value" annotation(Dialog(enable = if distributionType==PNlib.Types.DistributionType.TruncatedNormal then true else false, group = "Truncated normal distribution"));
  parameter Real sigma=1/6
    "Standard deviation" annotation(Dialog(enable = if distributionType==PNlib.Types.DistributionType.TruncatedNormal then true else false, group = "Truncated normal distribution"));
  parameter Real E[:]={1, 2, 3, 4, 5, 6} "Events of Discrete Distribution"
    annotation(Dialog(enable = if distributionType==PNlib.Types.DistributionType.Discrete  then true else false, group = "Discrete Probability Distribution"));
  parameter Real P[:]={1/6, 1/6, 1/6, 1/6, 1/6, 1/6} "Probability of Discrete Distribution"
    annotation(Dialog(enable = if distributionType==PNlib.Types.DistributionType.Discrete  then true else false, group = "Discrete Probability Distribution"));
  Integer arcWeightInDis[nInDis] = fill(1, nInDis) "arc weights of input places" annotation(
    Dialog(enable = true, group = "Arc Weights"));
  Integer arcWeightOutDis[nOutDis] = fill(1, nOutDis) "arc weights of output places" annotation(
    Dialog(enable = true, group = "Arc Weights"));
  Real arcWeightInCon[nInCon] = fill(1, nInCon) "arc weights of input places" annotation(
      Dialog(enable = true, group = "Arc Weights"));
  Real arcWeightOutCon[nOutCon] = fill(1, nOutCon) "arc weights of output places" annotation(
      Dialog(enable = true, group = "Arc Weights"));
  Boolean firingCon = true "additional firing condition" annotation(
    Dialog(enable = true, group = "Firing Condition"));
  Boolean active;
  Integer nFire;
  parameter Integer localSeed = PNlib.Functions.Random.counter() "Local seed to initialize random number generator" annotation(Dialog(enable = true, group = "Random Number Generator"));
  //****MODIFIABLE PARAMETERS AND VARIABLES END****//
  discrete Real putFireTime "putative firing time at event";
  discrete Real putTime "putative Dealy or Duration";
  Boolean TimeOver;
  //****MODIFIABLE PARAMETERS AND VARIABLES END****//
  //Boolean active "Is the transition active?";
  //Boolean fire "Does the transition fire?";
  PNlib.PN.Interfaces.DisTransitionIn inPlacesDis[nInDis](
  each active = timePassedIn.value,
  arcWeightint = arcWeightInDis,
  each fire = fireIn.value,
  tint = tInDis,
  minTokensint = minTokensDis,
  enable = enableInDis) if nInDis > 0 "connector for input places" annotation(
    Placement(transformation(extent = {{-56, -10}, {-40, 10}}, rotation = 0)));
  PNlib.PN.Interfaces.DisTransitionOut outPlacesDis[nOutDis](
  each active = timePassedOut.value,
  arcWeightint = arcWeightOutDis,
  each fire = fireOut.value,
  each enabledByInPlaces = if ((nInDis > 0 or nInCon > 0) and not timeType == PNlib.Types.TimeType.FireDuration) then enabledIn.value else true,
  tint = tOutDis,
  maxTokensint = maxTokensDis,
  enable = enableOutDis) if nOutDis > 0 "connector for output places" annotation(
    Placement(transformation(extent = {{40, -10}, {56, 10}}, rotation = 0)));
  PNlib.PN.Interfaces.HybTransitionIn inPlacesCon[nInCon](
  each active = timePassedIn.value,
  arcWeight = arcWeightInCon,
  each fire = fireIn.value,
  t = tInCon,
  minTokens = minTokensCon,
  enable = enableInCon) if nInCon > 0 "connector for input places" annotation(
    Placement(visible = true, transformation(extent = {{-56, -98}, {-40, -78}}, rotation = 0), iconTransformation(extent = {{-56, -98}, {-40, -78}}, rotation = 0)));
  PNlib.PN.Interfaces.HybTransitionOut outPlacesCon[nOutCon](
  each active = timePassedOut.value,
  arcWeight = arcWeightOutCon,
  each fire = fireOut.value,
  each enabledByInPlaces = if ((nInDis > 0 or nInCon > 0) and not timeType == PNlib.Types.TimeType.FireDuration) then enabledIn.value else true,
  t = tOutCon,
  maxTokens = maxTokensCon,
  enable = enableOutCon) if nOutCon > 0 "connector for output places" annotation(
    Placement(visible = true, transformation(extent = {{40, -98}, {56, -78}}, rotation = 0), iconTransformation(extent = {{40, -98}, {56, -78}}, rotation = 0)));
  PNlib.PN.Interfaces.TransitionInExt extIn[nInExt](condition = extendedCondition) if nInExt > 0 "connector for output extended Arcs" annotation(
    Placement(transformation(extent = {{-56, 80}, {-40, 100}}, rotation = 0)));
  // Activ In
  PNlib.PN.Interfaces.BooleanConIn activeIn1(value = activationInDis.active and activationInCon.active) if nInDis > 0 and nInCon > 0;
  PNlib.PN.Interfaces.BooleanConIn activeIn2(value = activationInDis.active) if nInDis > 0 and nInCon == 0;
  PNlib.PN.Interfaces.BooleanConIn activeIn3(value = activationInCon.active) if nInDis == 0 and nInCon > 0;
  PNlib.PN.Interfaces.BooleanConIn activeIn4(value = true) if nInDis == 0 and nInCon == 0;
  PNlib.PN.Interfaces.BooleanConOut activeIn;
  // Activ Out
  PNlib.PN.Interfaces.BooleanConIn activeOut1(value = activationOutDis.active and activationOutCon.active) if nOutDis > 0 and nOutCon > 0;
  PNlib.PN.Interfaces.BooleanConIn activeOut2(value = activationOutDis.active) if nOutDis > 0 and nOutCon == 0;
  PNlib.PN.Interfaces.BooleanConIn activeOut3(value = activationOutCon.active) if nOutDis == 0 and nOutCon > 0;
  PNlib.PN.Interfaces.BooleanConIn activeOut4(value = true) if nOutDis == 0 and nOutCon == 0;
  PNlib.PN.Interfaces.BooleanConOut activeOut;
  // Enable
  PNlib.PN.Interfaces.BooleanConIn enabledIn1(value = PNlib.Functions.OddsAndEnds.allTrue(enableInDis) and PNlib.Functions.OddsAndEnds.allTrue(enableInCon)) if nInDis > 0 and nInCon > 0;
  PNlib.PN.Interfaces.BooleanConIn enabledIn2(value = PNlib.Functions.OddsAndEnds.allTrue(enableInDis)) if nInDis > 0 and nInCon == 0;
  PNlib.PN.Interfaces.BooleanConIn enabledIn3(value = PNlib.Functions.OddsAndEnds.allTrue(enableInCon)) if nInDis == 0 and nInCon > 0;
  PNlib.PN.Interfaces.BooleanConIn enabledIn4(value = false) if nInDis == 0 and nInCon == 0;
  PNlib.PN.Interfaces.BooleanConOut enabledIn;
  PNlib.PN.Interfaces.BooleanConIn enabledOut1(value = PNlib.Functions.OddsAndEnds.allTrue(enableOutDis) and PNlib.Functions.OddsAndEnds.allTrue(enableOutCon)) if nOutDis > 0 and nOutCon > 0 ;
  PNlib.PN.Interfaces.BooleanConIn enabledOut2(value = PNlib.Functions.OddsAndEnds.allTrue(enableOutDis)) if nOutDis > 0 and nOutCon == 0 ;
  PNlib.PN.Interfaces.BooleanConIn enabledOut3(value = PNlib.Functions.OddsAndEnds.allTrue(enableOutCon)) if nOutDis == 0 and nOutCon > 0 ;
  PNlib.PN.Interfaces.BooleanConIn enabledOut4(value = false) if nOutDis == 0 and nOutCon == 0;
  PNlib.PN.Interfaces.BooleanConOut enabledOut;
  // Delay
  PNlib.PN.Interfaces.BooleanConIn fireInDelay(value = fireDelay.fire) if timeType == PNlib.Types.TimeType.Delay;
  PNlib.PN.Interfaces.BooleanConIn fireOutDelay(value = fireDelay.fire) if timeType == PNlib.Types.TimeType.Delay;
  PNlib.PN.Interfaces.BooleanConIn timePassedInDelay(value = fireDelay.delayPassed) if timeType == PNlib.Types.TimeType.Delay;
  PNlib.PN.Interfaces.BooleanConIn timePassedOutDelay(value = fireDelay.delayPassed) if timeType == PNlib.Types.TimeType.Delay;
  // Duration
  PNlib.PN.Interfaces.BooleanConIn fireInDuration(value = fireDuration.fireIn) if timeType == PNlib.Types.TimeType.FireDuration;
  PNlib.PN.Interfaces.BooleanConIn fireOutDuration(value = fireDuration.fireOut) if timeType == PNlib.Types.TimeType.FireDuration;
  PNlib.PN.Interfaces.BooleanConIn timePassedInDuration(value = fireDuration.durationPassedIn) if timeType == PNlib.Types.TimeType.FireDuration;
  PNlib.PN.Interfaces.BooleanConIn timePassedOutDuration(value = fireDuration.durationPassedOut) if timeType == PNlib.Types.TimeType.FireDuration;
  PNlib.PN.Interfaces.BooleanConIn TransitionDurationFire(value = fireDuration.fire) if timeType == PNlib.Types.TimeType.FireDuration;
  // Event
  PNlib.PN.Interfaces.BooleanConIn fireInEvent(value = fireEvent.fire) if timeType == PNlib.Types.TimeType.Event;
  PNlib.PN.Interfaces.BooleanConIn fireOutEvent(value = fireEvent.fire) if timeType == PNlib.Types.TimeType.Event;
  PNlib.PN.Interfaces.BooleanConIn timePassedInEvent(value = fireEvent.eventPassed) if timeType == PNlib.Types.TimeType.Event;
  PNlib.PN.Interfaces.BooleanConIn timePassedOutEvent(value = fireEvent.eventPassed) if timeType == PNlib.Types.TimeType.Event;
  // Event
  PNlib.PN.Interfaces.BooleanConIn fireInTact(value = fireTact.fire) if timeType == PNlib.Types.TimeType.Tact;
  PNlib.PN.Interfaces.BooleanConIn fireOutTact(value = fireTact.fire) if timeType == PNlib.Types.TimeType.Tact;
  PNlib.PN.Interfaces.BooleanConIn timePassedInTact(value = fireTact.tactPassed) if timeType == PNlib.Types.TimeType.Tact;
  PNlib.PN.Interfaces.BooleanConIn timePassedOutTact(value = fireTact.tactPassed) if timeType == PNlib.Types.TimeType.Tact;
  // Immediate
  PNlib.PN.Interfaces.BooleanConIn fireInImmediate(value = fireImmediate.fire) if timeType == PNlib.Types.TimeType.Immediate;
  PNlib.PN.Interfaces.BooleanConIn fireOutImmediate(value = fireImmediate.fire) if timeType == PNlib.Types.TimeType.Immediate;
  PNlib.PN.Interfaces.BooleanConIn timePassedInImmediate(value = fireImmediate.Passed) if timeType == PNlib.Types.TimeType.Immediate;
  PNlib.PN.Interfaces.BooleanConIn timePassedOutImmediate(value = fireImmediate.Passed) if timeType == PNlib.Types.TimeType.Immediate;
  // Dummy Time
  PNlib.PN.Interfaces.BooleanConOut fireIn;
  PNlib.PN.Interfaces.BooleanConOut fireOut;
  PNlib.PN.Interfaces.BooleanConOut timePassedIn;
  PNlib.PN.Interfaces.BooleanConOut timePassedOut;
protected
  discrete Integer state128[4] "state of random number generator";
  Real r128 "random number";
  outer PNlib.PN.Components.Settings settings "global settings for animation and display";
  // Discrete
  Integer tInDis[nInDis] "integer tokens of input places (for generating events!)";
  Integer tOutDis[nOutDis] "integer tokens of output places (for generating events!)";
  Integer minTokensDis[nInDis] "Integer minimum tokens of input places (for generating events!)";
  Integer maxTokensDis[nOutDis] "Integer maximum tokens of output places (for generating events!)";
  Boolean enableInDis[nInDis] "Is the transition enabled by input places?";
  Boolean enableOutDis[nOutDis] "Is the transition enabled by output places?";
  // Continuous
  Real tInCon[nInCon] "integer tokens of input places (for generating events!)";
  Real tOutCon[nOutCon] "integer tokens of output places (for generating events!)";
  Real minTokensCon[nInCon] "Integer minimum tokens of input places (for generating events!)";
  Real maxTokensCon[nOutCon] "Integer maximum tokens of output places (for generating events!)";
  Boolean enableInCon[nInCon] "Is the transition enabled by input places?";
  Boolean enableOutCon[nOutCon] "Is the transition enabled by output places?";
  // extended
  Boolean extendedCondition[nInExt] "Is the extended Arc Condition true?";
  Boolean allExtendedCondition = PNlib.Functions.OddsAndEnds.allTrue(extendedCondition) "Are all the extended Arc Condition true?";
  //Boolean delayPassed(start=false, fixed=true) "Is the delay passed?";
  //****BLOCKS BEGIN****// since no events are generated within functions!!!
  //activation process
  PN.Blocks.activationDisIn activationInDis(nIn = nInDis, tIntIn = tInDis, arcWeightIntIn = arcWeightInDis, minTokensInt = minTokensDis) if nInDis > 0;
  PN.Blocks.activationDisOut activationOutDis(nOut = nOutDis, tIntOut = tOutDis, arcWeightIntOut = arcWeightOutDis, maxTokensInt = maxTokensDis) if nOutDis > 0;
  PN.Blocks.activationConIn activationInCon(nIn = nInCon, tIn = tInCon, arcWeightIn = arcWeightInCon, minTokens = minTokensCon) if nInCon > 0;
  PN.Blocks.activationConOut activationOutCon(nOut = nOutCon, tOut = tOutCon, arcWeightOut = arcWeightOutCon, maxTokens = maxTokensCon) if nOutCon > 0;
  // Time
  PN.Blocks.delay fireDelay (nIn=nInDis+nInCon, nOut=nOutDis+nOutCon, delay=putTime, active=active and allExtendedCondition, enabledIn=enabledIn.value, enabledOut=enabledOut.value) if  timeType==PNlib.Types.StoTimeType.Delay;
  PN.Blocks.duration fireDuration (nIn=nInDis+nInCon, nOut=nOutDis+nOutCon, duration=putTime, activeIn=activeIn.value and allExtendedCondition and firingCon, activeOut=activeOut.value and firingCon, enabledIn=enabledIn.value, enabledOut=enabledOut.value) if  timeType==PNlib.Types.StoTimeType.FireDuration;
  PN.Blocks.eventSto fireEvent (nIn=nInDis+nInCon, nOut=nOutDis+nOutCon, event=putFireTime, active=active, enabledIn=enabledIn.value, enabledOut=enabledOut.value) if  timeType==PNlib.Types.StoTimeType.Event;
  //Is the transition enabled by all input places?
  //Boolean enabledByInPlaces = PNlib.Functions.OddsAndEnds.allTrue(enableIn) if nIn>0;
  //Is the transition enabled by all output places?
  //Boolean enabledByOutPlaces = PNlib.Functions.OddsAndEnds.allTrue(enableOut) if nOut>0;
  //****BLOCKS END****//
equation
//Active
  connect(activeIn, activeIn1);
  connect(activeIn, activeIn2);
  connect(activeIn, activeIn3);
  connect(activeIn, activeIn4);
  connect(activeOut, activeOut1);
  connect(activeOut, activeOut2);
  connect(activeOut, activeOut3);
  connect(activeOut, activeOut4);
  active = activeIn.value and activeOut.value and allExtendedCondition and firingCon;
// Enable
  connect(enabledIn, enabledIn1);
  connect(enabledIn, enabledIn2);
  connect(enabledIn, enabledIn3);
  connect(enabledIn, enabledIn4);
  connect(enabledOut, enabledOut1);
  connect(enabledOut, enabledOut2);
  connect(enabledOut, enabledOut3);
  connect(enabledOut, enabledOut4);
// Delay
  connect(fireIn, fireInDelay);
  connect(fireOut, fireOutDelay);
  connect(timePassedIn, timePassedInDelay);
  connect(timePassedOut, timePassedOutDelay);
// Duration
  connect(fireIn, fireInDuration);
  connect(fireOut, fireOutDuration);
  connect(timePassedIn, timePassedInDuration);
  connect(timePassedOut, timePassedOutDuration);
// Event
  connect(fireIn, fireInEvent);
  connect(fireOut, fireOutEvent);
  connect(timePassedIn, timePassedInEvent);
  connect(timePassedOut, timePassedOutEvent);
// Tact
  connect(fireIn, fireInTact);
  connect(fireOut, fireOutTact);
  connect(timePassedIn, timePassedInTact);
  connect(timePassedOut, timePassedOutTact);
// Immediate
  connect(fireIn, fireInImmediate);
  connect(fireOut, fireOutImmediate);
  connect(timePassedIn, timePassedInImmediate);
  connect(timePassedOut, timePassedOutImmediate);
//****ERROR MESSENGES BEGIN****//
  for i in 1:nInDis loop
    assert(arcWeightInDis[i] >= 0, "Input arc weights must be positive.");
  end for;
  for i in 1:nOutDis loop
    assert(arcWeightOutDis[i] >= 0, "Output arc weights must be positive.");
  end for;
  for i in 1:nInCon loop
    assert(arcWeightInCon[i] >= -PNlib.Constants.almost_eps, "Input arc weights must be positive.");
  end for;
  for i in 1:nOutCon loop
    assert(arcWeightOutCon[i] >= -PNlib.Constants.almost_eps, "Output arc weights must be positive.");
  end for;
  assert(h>0 or distributionType<>PNlib.Types.DistributionType.Exponential, "The probability density must be greater than zero");
  assert((a<b and a<=c and c<=b) or distributionType<>PNlib.Types.DistributionType.Triangular, "The Lower Limit must be less than or equal to the Most likely value and the Most likely value must be less than or equal to the Upper Limit but he Lower Limit must be less than the Upper Limit");
  assert(a<b or distributionType<>PNlib.Types.DistributionType.Uniform, "The Lower Limit must be less than the Upper Limit");
  assert(PNlib.Functions.OddsAndEnds.isEqual(sum(P), 1.0, 1e-6) or distributionType<>PNlib.Types.DistributionType.Discrete, "The Probability sum Probability of Discrete Distribution has to be equal to 1");
  assert(size(E,1)==size(P,1) or distributionType<>PNlib.Types.DistributionType.Discrete, "Discrete probability distribution must have the same number of events and probabilities");
//****ERROR MESSENGES END****//
algorithm
//****MAIN BEGIN****//
  when pre(fireOut.value) then
  nFire:=nFire+1;
  end when;
  TimeOver := timeType == PNlib.Types.StoTimeType.Event and time >= putFireTime;
//generate random putative fire time according to Next-Reaction method of Gibson and Bruck
  when pre(fireOut.value) or pre(TimeOver) then
    (r128, state128) := Modelica.Math.Random.Generators.Xorshift128plus.random(pre(state128));
    if distributionType == PNlib.Types.DistributionType.Exponential then
      putTime := PNlib.Functions.Random.randomexp(h, r128);
    elseif distributionType == PNlib.Types.DistributionType.Triangular then
      putTime := PNlib.Functions.Random.randomtriangular(a, b, c, r128);
    elseif distributionType == PNlib.Types.DistributionType.Uniform then
      putTime := Modelica.Math.Distributions.Uniform.quantile(max(r128, 10 ^ (-10)), a, b);
    elseif distributionType == PNlib.Types.DistributionType.TruncatedNormal then
      putTime := Modelica.Math.Distributions.TruncatedNormal.quantile(max(r128, 10 ^ (-10)), a, b, mu, sigma);
    else
      putTime := max(PNlib.Functions.Random.randomdis(E, P, r128), 1e-6);
    end if;
    putFireTime := time + putTime;
  end when;
//17.06.11 Reihenfolge getauscht!
//****MAIN END****//
initial equation
//to initialize the random generator otherwise the first random number is always the same in every simulation run
  if distributionType==PNlib.Types.DistributionType.Exponential then
      putTime = PNlib.Functions.Random.randomexp(h, r128);
  elseif distributionType==PNlib.Types.DistributionType.Triangular then
      putTime = PNlib.Functions.Random.randomtriangular(a, b, c, r128);
  elseif distributionType==PNlib.Types.DistributionType.Uniform then
      putTime = Modelica.Math.Distributions.Uniform.quantile( max(r128,10 ^ (-10)), a, b);
  elseif distributionType==PNlib.Types.DistributionType.TruncatedNormal then
      putTime = Modelica.Math.Distributions.TruncatedNormal.quantile( max(r128,10 ^ (-10)), a, b, mu, sigma);
  else
      putTime = max(PNlib.Functions.Random.randomdis(E, P, r128),1e-6);
  end if;
  putFireTime=time + putTime;
initial algorithm
  nFire:=0;
// Generate initial state from localSeed and globalSeed
  state128 := Modelica.Math.Random.Generators.Xorshift128plus.initialState(localSeed, settings.globalSeed);
  (r128, state128) := Modelica.Math.Random.Generators.Xorshift128plus.random(
      state128);

  annotation(
    defaultComponentName = "T1",
    Icon(graphics = {Rectangle(fillPattern = FillPattern.Solid, extent = {{-40, 100}, {40, -100}}), Text(extent = {{-2, -112}, {-2, -140}}, textString = "%timeType"), Text(extent = {{-2, -152}, {-2, -180}}, textString = "%timeValue"), Text(extent = {{-4, 139}, {-4, 114}}, textString = "%name"), Text(origin = {-18, 15}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, extent = {{56, 83}, {-20, -113}}, textString = "S")}, coordinateSystem(initialScale = 0.1)),
    Diagram(graphics));
end TS;
