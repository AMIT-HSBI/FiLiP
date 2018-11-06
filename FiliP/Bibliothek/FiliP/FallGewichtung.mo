within FiliP;
block FallGewichtung
parameter input Real SollBelastung[7]={110,110,110,105,100,85,90};
parameter input Real PlanKorrektur=0.45;
parameter input Real a[7]={-20,-20,-30,-30,-40,-40,-20};
parameter input Real b[7]={40,40,30,20,20,20,30};
parameter input Real c[7]={20,0,0,-5,-5,-15,5};
parameter input Integer StartTag;
parameter Integer localSeed = PNlib.Functions.Random.counter() "Local seed to initialize random number generator" annotation(Dialog(enable = true, group = "Random Number Generator"));
output Real IstBelastung;
output Integer WocheTag;
protected
outer PNlib.PN.Components.Settings settings "global settings for animation and display";
Integer Tag;
discrete Integer state128[4] "state of random number generator";
Real r128 "random number";
Real DeltaBelastung;
//Integer WocheTag;
algorithm
 when sample(1,1) then
    WocheTag:=1+mod(Tag,7);
    (r128, state128) := Modelica.Math.Random.Generators.Xorshift128plus.random(pre(state128));
    DeltaBelastung := PNlib.Functions.Random.randomtriangular(a[WocheTag], b[WocheTag], c[WocheTag], r128);
    IstBelastung:=IstBelastung+PlanKorrektur*(SollBelastung[WocheTag]-IstBelastung)+DeltaBelastung;
    Tag:=Tag+1;
  end when;
initial algorithm
// Generate initial state from localSeed and globalSeed
  Tag := StartTag;
  WocheTag:=1+mod(Tag,7);
  state128 := Modelica.Math.Random.Generators.Xorshift128plus.initialState(localSeed, settings.globalSeed);
  (r128, state128) := Modelica.Math.Random.Generators.Xorshift128plus.random(state128);
  DeltaBelastung := PNlib.Functions.Random.randomtriangular(a[Tag], b[Tag], c[Tag], r128);
  IstBelastung := SollBelastung[WocheTag];
  annotation(
    Icon(graphics = {Rectangle( fillColor = {255, 255, 255},fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Rectangle(origin = {-5, -7}, fillColor = {85, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-61, 7}, {61, -7}}), Rectangle(origin = {-62, -33}, fillPattern = FillPattern.Solid, extent = {{-4, 19}, {4, -19}}),  Rectangle(origin = {52, -33}, fillPattern = FillPattern.Solid, extent = {{-4, 19}, {4, -19}}), Ellipse(origin = {-35, 11}, fillColor = {85, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-33, 7}, {65, -11}}, endAngle = 360), Rectangle(origin = {40, 5}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-12, 7}, {-6, 1}}), Ellipse(origin = {46, 10}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-14, 12}, {14, -12}}, endAngle = 360)}));end FallGewichtung;
