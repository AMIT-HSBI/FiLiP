within PNlib.PN.Blocks;
block delay "Activation of a discrete transition"
  parameter input Integer nIn "number of input places";
  parameter input Integer nOut "number of output places";
  input Real delay "delay of timed transition";
  input Boolean active "activation of transition";
  input Boolean enabledIn;
  input Boolean enabledOut;
  output Boolean fire;
  output Boolean delayPassed;
protected
  Real delay_ = if delay < PNlib.Constants.almost_eps then PNlib.Constants.almost_eps else delay "due to event problems if delay==0";
  Real firingTime "next putative firing time";
  Boolean active_;
equation
  active_ = active and not pre(delayPassed);
  //save next putative firing time
  when active_ then
     firingTime = time + delay_;
  end when;
  //delay passed?
  delayPassed= active_ and time>=firingTime;
  //firing process
 // fire=if nOut==0 then enabledByInPlaces else enabledByOutPlaces;
   fire=if nOut==0 and nIn==0 then false elseif nOut==0 then enabledIn else enabledOut;

  //****MAIN END****//
  
end delay;
