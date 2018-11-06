within PNlib.PN.Blocks;
block eventSto "Activation of a discrete transition"
  parameter input Integer nIn "number of input places";
  parameter input Integer nOut "number of output places";
  input Real event "events of timed transition";
  input Boolean active "activation of transition";
  input Boolean enabledIn;
  input Boolean enabledOut;
  output Boolean fire;
  output Boolean eventPassed (start=false, fixed=true);
protected
  Boolean active_;
equation
  active_ = active and not pre(eventPassed);
  //save next putative firing time
  //event passed?
  eventPassed = active_ and time >= event;
  //firing process
 // fire=if nOut==0 then enabledByInPlaces else enabledByOutPlaces;
  fire=if nOut==0 and nIn==0 then false elseif nOut==0 then enabledIn else enabledOut;
  //****MAIN END****//
end eventSto;
