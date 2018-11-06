within PNlib.PN.Blocks;
block activationDisIn "Activation of a discrete transition"
  parameter input Integer nIn "number of input places";
  input Integer tIntIn[:] "tokens of input places";
  input Integer arcWeightIntIn[:] "arc weights of input places";
  input Integer minTokensInt[:] "minimum capacities of input places";
  output Boolean active "activation of transition";
algorithm
  active:=true;
  //check input places
  for i in 1:nIn loop
      if not (tIntIn[i]-arcWeightIntIn[i]  >= minTokensInt[i]) then
        active:=false;
      end if;
  end for;
end activationDisIn;
