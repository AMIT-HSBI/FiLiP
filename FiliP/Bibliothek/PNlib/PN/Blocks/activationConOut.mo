within PNlib.PN.Blocks;
block activationConOut "Activation of a discrete transition"
  parameter input Integer nOut "number of output places";
  input Real tOut[:] "tokens of output places";
  input Real arcWeightOut[:] "arc weights of output places";
  input Real maxTokens[:] "maximum capacities of output places";
  output Boolean active "activation of transition";
algorithm
  active:=false;
  //check input places
  //check output places
  for i in 1:nOut loop
      if tOut[i]+arcWeightOut[i] -maxTokens[i] <=  PNlib.Constants.almost_eps then
        active:=true;
      end if;
  end for;
end activationConOut;
