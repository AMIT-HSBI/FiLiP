within PNlib.PN.Blocks;
block enablingConPrio "enabling process of output transitions"
  parameter input Integer nCon "number of output transitions";
  input Integer arcWeight[:] "arc weights of output transitions";
  input Integer t "current token number";
  input Integer minTokens "minimum capacity";
  input Integer maxTokens "maximum capacity";
  input Boolean TA[:] "active output transitions with passed time";
  input Integer enablingPrio[:] "enabling priorities of output transitions";
  output Boolean TE[nCon] "enabled output transitions";
protected
  Boolean TE_[nCon] "enabled output transitions";
  Integer arcWeightSum "arc weight sum";
  Integer Index "priority Index";
algorithm
  TE_ := fill(false, nCon);
  Index := 0;
  arcWeightSum := PNlib.Functions.OddsAndEnds.conditionalSumInt(arcWeight, TA);  //arc weight sum of all active output transitions
      if t - arcWeightSum >= minTokens and t + arcWeightSum <= maxTokens then  //Place has no actual conflict; all active output transitions are enabled
        TE_ := TA;
      else                          //Place has an actual conflict;
        arcWeightSum := 0;
        for i in 1: nCon loop  //discrete transitions are proven at first
          Index:=Modelica.Math.Vectors.find(i,enablingPrio);
          if Index>0 and TA[Index] and t-(arcWeightSum+arcWeight[Index]) >= minTokens and t+(arcWeightSum+arcWeight[Index])<=maxTokens then
            TE_[Index] := true;
            arcWeightSum := arcWeightSum + arcWeight[Index];
          end if;
        end for;
      end if;
    TE:= TE_;
end enablingConPrio;
