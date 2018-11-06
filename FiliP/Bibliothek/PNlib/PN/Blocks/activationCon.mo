within PNlib.PN.Blocks;
block activationCon "activation process of continuous transitions"
//no events are generated within while-loops; for-loops are applied
  parameter input Integer nIn "number of input places";
  parameter input Integer nOut "number of output places";
  input Real tIn[:] "marking of input places";
  input Real tOut[:] "marking of output places";
  input Real arcWeightIn[:] "arc weights of input places";
  input Real arcWeightOut[:] "arc weights of output places";
  input Real minTokens[:] "minimum capacities of input places";
  input Real maxTokens[:] "maximum capacities of output places";
  input Boolean firingCon "firing condition";
  input Boolean fed[:] "input places are fed?";
  input Boolean emptied[:] "output places are emptied?";
  output Boolean active "activation of transition";
  output Boolean weaklyInputActiveVec[nIn] "places that causes weakly input activation";
  output Boolean weaklyOutputActiveVec[nOut] "places that causes weakly output activation";
  Boolean NoTokens;
algorithm
  NoTokens :=false;
  active := true;
  weaklyInputActiveVec := fill(false, nIn);
  weaklyOutputActiveVec := fill(false, nOut);
  //check input places
  for i in 1:nIn loop
        NoTokens :=not (tIn[i]-minTokens[i] >= -PNlib.Constants.almost_eps);
        if arcWeightIn[i] <= 0.0 then
        elseif NoTokens and (not fed[i]) then
          active := false;
        elseif NoTokens and fed[i] then  //weakly input active??
          weaklyInputActiveVec[i] := true;
        end if;
  end for;

  //output places
  for i in 1:nOut loop
      if tOut[i] >= maxTokens[i] then
        if emptied[i] then
          weaklyOutputActiveVec[i] := true;
        else
          active := false;
        end if;
      end if;
  end for;

  active := active and firingCon;
  // hack for Dymola 2017
  // weaklyOutputActiveVec := weaklyOutputActiveVec and fill(firingCon, nOut);
  for i in 1:nOut loop
    weaklyOutputActiveVec[i] := weaklyOutputActiveVec[i] and firingCon;
  end for;

  // hack for Dymola 2017
  //weaklyInputActiveVec := weaklyInputActiveVec and fill(firingCon, nIn);
  for i in 1:nIn loop
    weaklyInputActiveVec[i] := weaklyInputActiveVec[i] and firingCon;
  end for;
end activationCon;
