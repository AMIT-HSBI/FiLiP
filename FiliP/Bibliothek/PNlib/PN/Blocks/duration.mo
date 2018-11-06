within PNlib.PN.Blocks;
block duration "Activation of a discrete transition"
  parameter input Integer nIn "number of input places";
  parameter input Integer nOut "number of output places";
  input Real duration "duration of timed transition";
  input Boolean activeIn "input activation of transition";
  input Boolean activeOut "output activation of transition";
  input Boolean enabledIn;
  input Boolean enabledOut;
  output Boolean fireIn;
  output Boolean fireOut;
  output Boolean durationPassedIn;
  output Boolean durationPassedOut;
  output Boolean fire;
protected
  Boolean prefire( start=false, fixed=true) "Was the Transition fire?";
  Boolean fire_( start=false, fixed=true) "Is the Transition fire?";
  Real duration_ = if duration < PNlib.Constants.almost_eps then PNlib.Constants.almost_eps else duration "due to event problems if delay==0";
  Real firingTimeIn "next putative firing time";
  Real firingTimeOut "next putative firing time";
  Boolean activeIn_;
  Boolean activeOut_;
equation
  activeIn_ = activeIn  and not pre(durationPassedIn) and not prefire;
  activeOut_ = activeOut and not pre(durationPassedOut) and prefire;
  //save next putative firing time
  when activeIn_ then
     firingTimeIn = time+PNlib.Constants.almost_eps;
  end when;
  when activeOut_ then
     firingTimeOut = if time>=firingTimeIn+duration_-PNlib.Constants.almost_eps  then time+PNlib.Constants.almost_eps else firingTimeIn+duration_-PNlib.Constants.almost_eps;
  end when;
  //is the Transition fire?
  prefire=pre(fire_);
  fireIn=enabledIn;
  fireOut=enabledOut;
  durationPassedIn= activeIn_ and time>=firingTimeIn;
  durationPassedOut= activeOut_ and time>=firingTimeOut;
  when {fireIn, fireOut} then
   if durationPassedOut then
     fire_=false;
   else
     fire_=true;
   end if;
  end when;
  fire=fire_;
end duration;
