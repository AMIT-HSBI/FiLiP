within PNlib.PN.Blocks;
block enablingInConProb "enabling process of discrete input transitions"
  parameter input Integer nIn "number of input transitions";
  input Real arcWeight[:] "arc weights of input transitions";
  input Real t "current token number";
  input Real maxTokens "maximum capacity";
  input Boolean TAein[:] "active previous transitions which are already enabled by their input places";
  input Real enablingProb[:] "enabling probabilites of input transitions";
  input Boolean timePassed "Does any timePassed of a output transition";
  input Boolean active[:] "Are the input transitions active?";
  parameter input Integer localSeed "Local seed to initialize random number generator";
  parameter input Integer globalSeed "Global seed to initialize random number generator";
  output Boolean TEin_[nIn] "enabled input transitions";
  protected
  discrete Integer state128[4] "state of random number generator";
  Boolean TEin[nIn] "enabled input transitions";
  Integer remTAin[nIn](each start=0, each fixed=true) "remaining active input transitions";
  discrete Real cumEnablingProb[nIn](each start=0, each fixed=true) "cumulated, scaled enabling probabilities";
  Real arcWeightSum "arc weight sum";
  Integer nremTAin "number of remaining active input transitions";
  Integer nTAin "number ofactive input transitions";
  Integer k "iteration index";
  Integer posTE "possible enabled transition";
  discrete Real randNum "uniform distributed random number";
  discrete Real sumEnablingProbTAin "sum of the enabling probabilities of the active input transitions";
  Boolean endWhile;
  initial algorithm
  // Generate initial state from localSeed and globalSeed
  state128 := Modelica.Math.Random.Generators.Xorshift128plus.initialState(localSeed, globalSeed);
  (randNum, state128) := Modelica.Math.Random.Generators.Xorshift128plus.random(
      state128);
  algorithm
  TEin:=fill(false, nIn);
  arcWeightSum := 0;
  when timePassed then
      arcWeightSum:=PNlib.Functions.OddsAndEnds.conditionalSum(arcWeight, TAein);  //arc weight sum of all active input transitions which are already enabled by their input places
      if t + arcWeightSum -maxTokens <= PNlib.Constants.almost_eps or PNlib.Functions.OddsAndEnds.isEqual(arcWeightSum, 0.0) then  //Place has no actual conflict; all active input transitions are enabled
        TEin:=TAein;
      else                          //Place has an actual conflict
          arcWeightSum:=0;
          remTAin:=zeros(nIn);
          nremTAin:=0;
          for i in 1:nIn loop
            if TAein[i] then
              nremTAin:=nremTAin+1;  //number of active input transitions
              remTAin[nremTAin]:=i;  //active input transitions
            end if;
          end for;
          nTAin:=nremTAin;          //number of active input transitions
          sumEnablingProbTAin:=sum(enablingProb[remTAin[1:nremTAin]]);  //enabling probability sum of all active input transitions
          cumEnablingProb:=zeros(nIn);      //cumulative, scaled enabling probabilities
          cumEnablingProb[1]:=enablingProb[remTAin[1]]/sumEnablingProbTAin;
          for j in 2:nremTAin loop
            cumEnablingProb[j]:=cumEnablingProb[j-1]+enablingProb[remTAin[j]]/sumEnablingProbTAin;
          end for;
          for i in 1:nTAin loop
            (randNum, state128) := Modelica.Math.Random.Generators.Xorshift128plus.random(pre(state128)) "uniform distributed random number";
            endWhile:=false;
            k:=1;
            while k<=nremTAin and not endWhile loop
              if randNum <= cumEnablingProb[k] then
                posTE:=remTAin[k];
                endWhile:=true;
              else
                k:=k + 1;
              end if;
            end while;
            if t+arcWeightSum + arcWeight[posTE] -maxTokens <= PNlib.Constants.almost_eps or PNlib.Functions.OddsAndEnds.isEqual(arcWeight[i], 0.0) then
              arcWeightSum:=arcWeightSum + arcWeight[posTE];
              TEin[posTE]:=true;
            end if;
            nremTAin:=nremTAin - 1;
            if nremTAin > 0 then
              remTAin:=PNlib.Functions.OddsAndEnds.deleteElementInt(remTAin, k);
              cumEnablingProb:=zeros(nIn);
              sumEnablingProbTAin:=sum(enablingProb[remTAin[1:nremTAin]]);
              if sumEnablingProbTAin>0 then
                cumEnablingProb[1]:=enablingProb[remTAin[1]]/sumEnablingProbTAin;
                for j in 2:nremTAin loop
                  cumEnablingProb[j]:=cumEnablingProb[j-1]+enablingProb[remTAin[j]]/sumEnablingProbTAin;
                end for;
              else
                cumEnablingProb[1:nremTAin]:=fill(1/nremTAin, nremTAin);
              end if;
            end if;
          end for;
        end if;
  end when;
  // hack for Dymola 2017
  // TEin_ := TEin and active;
  for i in 1:nIn loop
    TEin_[i] := TEin[i] and active[i];
  end for;
end enablingInConProb;
