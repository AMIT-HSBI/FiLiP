within PNlib.PN.Blocks;
block activationDis "Activation of a discrete transition"
  parameter input Integer nDis "number of output places";
  input Integer tDis[:] "tokens of input places";
  input Integer arcWeightDis[:] "arc weights of input places";
  input Integer minTokensDis[:] "minimum capacities of input places";
  input Integer maxTokensDis[:] "minimum capacities of input places";
  output Boolean active "activation of transition";
algorithm
  active:=true;
  //check input places
  for i in 1:nDis loop
      if not (tDis[i]-arcWeightDis[i]  >= minTokensDis[i]) or not (tDis[i]+arcWeightDis[i] <= maxTokensDis[i]) then
        active:=false;
      end if;
  end for;
end activationDis;
