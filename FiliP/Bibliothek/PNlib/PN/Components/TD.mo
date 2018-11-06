within PNlib.PN.Components;

model TD "Discrete Transition with delay "
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
  parameter PNlib.Types.TimeType timeType = PNlib.Types.TimeType.Delay;
  parameter Real timeValue[:] = {1} "time Value of transition" annotation(
    Dialog(enable = true, group = "Discrete Time Concept"));
  parameter Boolean syncroTact = false "time Value of transition" annotation(
      Dialog(enable = true, group = "Discrete Time Concept"));
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
  // Tact
  PNlib.PN.Interfaces.BooleanConIn fireInTact(value = fireTact.fire) if (not syncroTact and timeType == PNlib.Types.TimeType.Tact);
  PNlib.PN.Interfaces.BooleanConIn fireOutTact(value = fireTact.fire) if (not syncroTact and timeType == PNlib.Types.TimeType.Tact);
  PNlib.PN.Interfaces.BooleanConIn timePassedInTact(value = fireTact.tactPassed) if (not syncroTact and timeType == PNlib.Types.TimeType.Tact);
  PNlib.PN.Interfaces.BooleanConIn timePassedOutTact(value = fireTact.tactPassed) if (not syncroTact and timeType == PNlib.Types.TimeType.Tact);
  // Tact Syncro
  PNlib.PN.Interfaces.BooleanConIn fireInTactSyncro(value = fireTactSyncro.fire) if (syncroTact and timeType == PNlib.Types.TimeType.Tact);
  PNlib.PN.Interfaces.BooleanConIn fireOutTactSyncro(value = fireTactSyncro.fire) if (syncroTact and timeType == PNlib.Types.TimeType.Tact);
  PNlib.PN.Interfaces.BooleanConIn timePassedInTactSyncro(value = fireTactSyncro.tactPassed) if (syncroTact and timeType == PNlib.Types.TimeType.Tact);
  PNlib.PN.Interfaces.BooleanConIn timePassedOutTactSyncro(value = fireTactSyncro.tactPassed) if (syncroTact and timeType == PNlib.Types.TimeType.Tact);
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
  PN.Blocks.delay fireDelay(nIn = nInDis+nInCon, nOut = nOutDis+nOutCon, delay = timeValue[1], active = active, enabledIn = enabledIn.value, enabledOut = enabledOut.value) if timeType == PNlib.Types.TimeType.Delay;
  PN.Blocks.duration fireDuration(nIn = nInDis+nInCon, nOut = nOutDis+nOutCon, duration = timeValue[1], activeIn = activeIn.value and allExtendedCondition and firingCon, activeOut = activeOut.value and firingCon, enabledIn = enabledIn.value, enabledOut = enabledOut.value) if timeType == PNlib.Types.TimeType.FireDuration;
  PN.Blocks.event fireEvent(nIn = nInDis+nInCon, nOut = nOutDis+nOutCon, event = timeValue, active = active, enabledIn = enabledIn.value, enabledOut = enabledOut.value) if timeType == PNlib.Types.TimeType.Event;
  PN.Blocks.tact fireTact(nIn = nInDis+nInCon, nOut = nOutDis+nOutCon, tactTime = timeValue, active = active, enabledIn = enabledIn.value, enabledOut = enabledOut.value) if (not syncroTact and timeType == PNlib.Types.TimeType.Tact);
  PN.Blocks.tactSyncro fireTactSyncro(nIn = nInDis+nInCon, nOut = nOutDis+nOutCon, tactTime = timeValue, active = active, enabledIn = enabledIn.value, enabledOut = enabledOut.value) if (syncroTact and timeType == PNlib.Types.TimeType.Tact);
  PN.Blocks.immediate fireImmediate(nIn = nInDis+nInCon, nOut = nOutDis+nOutCon, active = active, enabledIn = enabledIn.value, enabledOut = enabledOut.value) if timeType == PNlib.Types.TimeType.Immediate;
  //Is the transition enabled by all input places?
  //Boolean enabledByInPlaces = PNlib.Functions.OddsAndEnds.allTrue(enableIn) if nIn>0;
  //Is the transition enabled by all output places?
  //Boolean enabledByOutPlaces = PNlib.Functions.OddsAndEnds.allTrue(enableOut) if nOut>0;
  //****BLOCKS END****//
initial algorithm
nFire:=0;
algorithm
when fireOut.value then
  nFire:=nFire+1;
end when;
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
// Tact Syncro
  connect(fireIn, fireInTactSyncro);
  connect(fireOut, fireOutTactSyncro);
  connect(timePassedIn, timePassedInTactSyncro);
  connect(timePassedOut, timePassedOutTactSyncro);
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
  if timeType == PNlib.Types.TimeType.Delay then
    assert(size(timeValue, 1) == 1, "Only one Value at timeValue for Delay");
  elseif timeType == PNlib.Types.TimeType.FireDuration then
    assert(size(timeValue, 1) == 1, "Only one Value at timeValue for Fire Duration");
  elseif timeType == PNlib.Types.TimeType.Event then
    assert(PNlib.Functions.OddsAndEnds.eventCheck(timeValue), "The event times must be greater than zero and must be specified in a larger order at timeValue");
  elseif timeType == PNlib.Types.TimeType.Tact then
    assert(size(timeValue, 1) == 2, "Exact two Values at timeValue for Tact");
  else
    assert(size(timeValue, 1) == 1 and timeValue[1] == 0, "Only one Value at timeValue for Delay");
  end if;
//****ERROR MESSENGES END****//
  annotation(
    defaultComponentName = "T1",
    Icon(graphics = {Rectangle(extent = {{-40, 100}, {40, -100}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Text(extent = {{-2, -112}, {-2, -140}}, lineColor = {0, 0, 0}, textString = DynamicSelect("%timeType", "%timeType")), Text(extent = {{-2, -152}, {-2, -180}}, lineColor = {0, 0, 0}, textString = DynamicSelect("%timeValue", "%timeValue")), Text(extent = {{-4, 139}, {-4, 114}}, lineColor = {0, 0, 0}, textString = "%name")}),
    Diagram(graphics));
end TD;
