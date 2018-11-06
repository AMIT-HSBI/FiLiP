within PNlib.PN.Blocks;
block enablingOutDisBeneBaB "enabling process of output transitions"
  parameter input Integer nOut "number of output transitions";
  input Integer arcWeight[:] "arc weights of output transitions";
  input Integer t "current token number";
  input Integer minTokens "minimum capacity";
  input Boolean TAout[:] "active output transitions with passed time";
  input Real enablingBene[:] "enabling benefit of output transitions";
  input Boolean timePassed "Does any timePassed of a output transition";
  output Boolean TEout_[nOut] "enabled output transitions";
protected
  Boolean TEout[nOut] "enabled output transitions";
  Integer arcWeightSum "arc weight sum";
  discrete Real benefitMax "theoretical benefit";
  Boolean valid "valid solution";
  discrete Real benefitLimit "best valid benefit";
algorithm
  TEout := fill(false, nOut);
  benefitMax:=sum(enablingBene);
  benefitLimit:=0;
  arcWeightSum := 0;
  when timePassed then
      arcWeightSum := PNlib.Functions.OddsAndEnds.conditionalSumInt(arcWeight, TAout);  //arc weight sum of all active output transitions
      if t - arcWeightSum >= minTokens then  //Place has no actual conflict; all active output transitions are enabled
        TEout := TAout;
        valid:=false;
      else
           arcWeightSum := 0;
           (TEout, arcWeightSum,  benefitMax, valid, benefitLimit):=PNlib.PN.Functions.Enabling.benefitBaBDisOut(1, nOut, enablingBene, arcWeight, enablingBene ./arcWeight, t, benefitMax, minTokens, TEout, 0, benefitLimit, TAout);
      end if;
  end when;
  // hack for Dymola 2017
  // TEout_ := TEout and TAout;
  for i in 1:nOut loop
    TEout_[i] := TEout[i] and TAout[i];
  end for;
end enablingOutDisBeneBaB;
