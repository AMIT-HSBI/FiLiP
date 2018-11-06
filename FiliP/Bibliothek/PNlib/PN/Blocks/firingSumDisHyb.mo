within PNlib.PN.Blocks;
block firingSumDisHyb "calculates the firing sum of discrete places"
  input Boolean fire[:] "firability of transitions";
  input Real arcWeight[:] "arc weights";
  output Real firingSum "firing sum";
algorithm
  firingSum := 0;
  for i in 1:size(fire, 1) loop
    if fire[i] then
      firingSum := firingSum + arcWeight[i];
    end if;
  end for;
end firingSumDisHyb;
