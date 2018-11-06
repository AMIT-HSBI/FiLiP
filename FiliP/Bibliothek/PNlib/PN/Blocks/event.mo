within PNlib.PN.Blocks;
block event "Activation of a discrete transition"
  parameter input Integer nIn "number of input places";
  parameter input Integer nOut "number of output places";
  input Real event [:] "events of timed transition";
  input Boolean active "activation of transition";
  input Boolean enabledIn;
  input Boolean enabledOut;
  output Boolean fire;
  output Boolean eventPassed (start=false, fixed=true);
protected
  Real event_ [:] = PNlib.Functions.OddsAndEnds.addElement(event) "solves last-time problem";
  Boolean active_;
  Integer eventIndex(start=1, fixed=true);
algorithm
  when time>=event_[eventIndex] and time>=PNlib.Constants.almost_eps then
      eventIndex:=eventIndex+1;
  end when;
equation
  active_ = active and not pre(eventPassed);
  //save next putative firing time
  eventPassed= active_ and  time>=event_[pre(eventIndex)] and time>=PNlib.Constants.almost_eps ;
  //firing process
 // fire=if nOut==0 then enabledByInPlaces else enabledByOutPlaces;
   fire=if nOut==0 and nIn==0 then false elseif nOut==0 then enabledIn else enabledOut;
  //****MAIN END****//
end event;
