within PNlib.PN.Blocks;
block enablingInDisBeneGreedy "enabling process of discrete input transitions"
  parameter input Integer nIn "number of input transitions";
  input Integer arcWeight[:] "arc weights of input transitions";
  input Integer t "current token number";
  input Integer maxTokens "maximum capacity";
  input Boolean TAein[:] "active previous transitions which are already enabled by their input places";
  input Real enablingBene[:] "enabling benefit of input transitions";
  input Boolean timePassed "Does any timePassed of a output transition";
  input Boolean active[:] "Are the input transitions active?";
  output Boolean TEin_[nIn] "enabled input transitions";
protected
  Boolean TEin[nIn] "enabled input transitions";
  Integer arcWeightSum "arc weight sum";
  Integer Index "priority Index";
  Real enablingBene_[nIn]  "Benefit";
  Real BestValue "best Benefit";
algorithm
  TEin:=fill(false, nIn);
  arcWeightSum := 0;
  when timePassed then
      arcWeightSum:=PNlib.Functions.OddsAndEnds.conditionalSumInt(arcWeight, TAein);  //arc weight sum of all active input transitions which are already enabled by their input places
      if t + arcWeightSum <= maxTokens then  //Place has no actual conflict; all active input transitions are enabled
        TEin:=TAein;
        Index:=0;
        BestValue:=0;
        enablingBene_:=enablingBene;
      else
        arcWeightSum := 0;
        enablingBene_:=enablingBene;
        for i in 1: nIn loop  //discrete transitions are proven at first
          BestValue:=max(enablingBene_);
          Index:=Modelica.Math.Vectors.find(BestValue,enablingBene_);
          if Index>0 and TAein[Index]  and t+arcWeightSum+arcWeight[Index] <= maxTokens then
            TEin[Index] := true;
            arcWeightSum := arcWeightSum + arcWeight[Index];
          end if;
          enablingBene_[Index]:=-1;
        end for;
      end if;
  end when;
  // hack for Dymola 2017
  // TEin_ := TEin and active;
  for i in 1:nIn loop
    TEin_[i] := TEin[i] and active[i];
  end for;
end enablingInDisBeneGreedy;
