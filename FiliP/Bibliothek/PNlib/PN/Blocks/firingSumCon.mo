within PNlib.PN.Blocks;
block firingSumCon "calculates the firing sum of continuous places"
  input Boolean fire[:] "firability of transitions";
  input Real arcWeight[:] "arc weights";
  input Real instSpeed[:] "istantaneous speed of transitions";
  output Real conFiringSum "continuous firing sum";
protected
  Real vec1[size(fire, 1)];
//algorithm //changed 21.03.11 due to negative values
equation
  for i in 1:size(fire, 1) loop
    if fire[i] then
      vec1[i] = arcWeight[i]*instSpeed[i];
    else
      vec1[i] = 0;
    end if;
  end for;
  conFiringSum = sum(vec1);
end firingSumCon;
