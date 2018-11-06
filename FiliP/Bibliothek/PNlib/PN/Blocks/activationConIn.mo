within PNlib.PN.Blocks;
block activationConIn "Activation of a discrete transition"
  parameter input Integer nIn "number of input places";
  input Real tIn[:] "tokens of input places";
  input Real arcWeightIn[:] "arc weights of input places";
  input Real minTokens[:] "minimum capacities of input places";
  output Boolean active "activation of transition";
algorithm
  active:=false;
  //check input places
  for i in 1:nIn loop
      if tIn[i]-arcWeightIn[i] -minTokens[i] >= -PNlib.Constants.almost_eps then
        active:=true;
      end if;
  end for;
end activationConIn;
