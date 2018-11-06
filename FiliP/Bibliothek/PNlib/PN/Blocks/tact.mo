within PNlib.PN.Blocks;
block tact "Activation of a discrete transition"
  parameter input Integer nIn "number of input places";
  parameter input Integer nOut "number of output places";
  parameter input Real tactTime [:] "events of timed transition";
  input Boolean active "activation of transition";
  input Boolean enabledIn;
  input Boolean enabledOut;
  output Boolean fire;
  output Boolean tactPassed (start=false, fixed=true);
protected
  Real firingTime "next putative firing time";
  Boolean active_;
equation
  active_ = active;
  //save next putative firing time
  when active_ and sample(max(tactTime[1],10 ^ (-8)), max(tactTime[2],10 ^ (-6))) then
     firingTime = time;
  end when;
  //event passed?
  tactPassed= active_ and abs(time - firingTime) <= PNlib.Constants.almost_eps;
  //firing process
 // fire=if nOut==0 then enabledByInPlaces else enabledByOutPlaces;
   fire=if nOut==0 and nIn==0 then false elseif nOut==0 then enabledIn else enabledOut;
  //****MAIN END****//
end tact;
