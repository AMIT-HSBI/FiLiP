within PNlib.PN.Blocks;
block enablingInConPrio "enabling process of discrete input transitions"
  parameter input Integer nIn "number of input transitions";
  input Real arcWeight[:] "arc weights of input transitions";
  input Real t "current token number";
  input Real maxTokens "maximum capacity";
  input Boolean TAein[:] "active previous transitions which are already enabled by their input places";
  input Integer enablingPrio[:] "enabling priorities of input transitions";
  input Boolean timePassed "Does any timePassed of a output transition";
  input Boolean active[:] "Are the input transitions active?";
  output Boolean TEin_[nIn] "enabled input transitions";
protected
  Boolean TEin[nIn] "enabled input transitions";
  Real arcWeightSum "arc weight sum";
  Integer Index "priority Index";
algorithm
  TEin:=fill(false, nIn);
  arcWeightSum := 0;
  Index := 0;
  when timePassed then
      arcWeightSum:=PNlib.Functions.OddsAndEnds.conditionalSum(arcWeight, TAein);  //arc weight sum of all active input transitions which are already enabled by their input places
      if t + arcWeightSum -maxTokens <= PNlib.Constants.almost_eps or PNlib.Functions.OddsAndEnds.isEqual(arcWeightSum, 0.0) then  //Place has no actual conflict; all active input transitions are enabled
        TEin:=TAein;
      else                          //Place has an actual conflict
        arcWeightSum:=0;
        for i in 1:nIn loop
          Index:=Modelica.Math.Vectors.find(i,enablingPrio);
          if Index>0 and TAein[Index] and t+(arcWeightSum+arcWeight[Index]-maxTokens) <= PNlib.Constants.almost_eps then  ///new 07.03.2011
            TEin[Index]:=true;
            arcWeightSum:=arcWeightSum + arcWeight[Index];
          end if;
        end for;
      end if;
  end when;
  // hack for Dymola 2017
  // TEin_ := TEin and active;
  for i in 1:nIn loop
    TEin_[i] := TEin[i] and active[i];
  end for;
end enablingInConPrio;
