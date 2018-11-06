within PNlib.PN.Blocks;
block enablingInDisBeneBaB "enabling process of discrete input transitions"
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
  discrete Real benefitMax "theoretical benefit";
  Boolean valid "valid solution";
  discrete Real benefitLimit "best valid benefit";
algorithm
  TEin:=fill(false, nIn);
  arcWeightSum := 0;
  benefitMax:=sum(enablingBene);
  benefitLimit:=0;
  when timePassed then
      arcWeightSum:=PNlib.Functions.OddsAndEnds.conditionalSumInt(arcWeight, TAein);  //arc weight sum of all active input transitions which are already enabled by their input places
      if t + arcWeightSum <= maxTokens then  //Place has no actual conflict; all active input transitions are enabled
        TEin:=TAein;
        valid:=false;
      else
            arcWeightSum := 0;
            (TEin, arcWeightSum,  benefitMax, valid, benefitLimit):=PNlib.PN.Functions.Enabling.benefitBaBDisIn(1, nIn, enablingBene, arcWeight, enablingBene ./arcWeight, t, benefitMax, maxTokens, TEin, 0, benefitLimit, TAein);
      end if;
  end when;
  // hack for Dymola 2017
  // TEin_ := TEin and active;
  for i in 1:nIn loop
    TEin_[i] := TEin[i] and active[i];
  end for;
end enablingInDisBeneBaB;
