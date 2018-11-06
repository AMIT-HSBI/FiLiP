within PNlib.PN.Blocks;
block tactSyncro "Activation of a discrete transition"
  parameter input Integer nIn "number of input places";
  parameter input Integer nOut "number of output places";
  parameter input Real tactTime [:] "events of timed transition";
  input Boolean active "activation of transition";
  input Boolean enabledIn;
  input Boolean enabledOut;
  output Boolean fire;
  output Boolean tactPassed (start=false, fixed=true);
protected
  Boolean active_;
   Real tactTime_ [2]={if tactTime[1] < PNlib.Constants.almost_eps then PNlib.Constants.almost_eps else tactTime[1],if tactTime[2] < PNlib.Constants.almost_eps then PNlib.Constants.almost_eps else tactTime[2]};
  Real TactTime (start=if tactTime[1] < PNlib.Constants.almost_eps then PNlib.Constants.almost_eps else tactTime[1], fixed=true);
algorithm
  when time>=TactTime then
      TactTime:=TactTime+tactTime_[2];
  end when;
equation
  active_ = active;
  //save next putative firing time
  //event passed?
  //tactPassed= active_ and time>=firingTime;
  tactPassed= active_ and time>= pre(TactTime);
  //tactPassed= active_ and sample(max(tactTime[1],10 ^ (-8)), max(tactTime[2],10 ^ (-6)));
  //firing process
 // fire=if nOut==0 then enabledByInPlaces else enabledByOutPlaces;
   fire=if nOut==0 and nIn==0 then false elseif nOut==0 then enabledIn else enabledOut;
  //****MAIN END****//
end tactSyncro;
