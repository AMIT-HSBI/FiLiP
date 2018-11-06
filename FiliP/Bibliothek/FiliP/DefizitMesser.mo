within FiliP;
 
block DefizitMesser
input Integer SollBesetzung;
input Integer IstBesetzung;
input Real SollBelastung=103;
input Real IstBelastung;
parameter input Real MessSchwellen[5]={0.5, 0.4, 0.3, 0.2, 0.1};
parameter input Real MessZeit;
parameter input Real Schichtzeit;
output Integer Defizit(start=0);
output Integer Ueberbelastet [5](each start=0);
protected
Real BelastungsFaktor;
Real MessSchwellen_[5]={1,1,1,1,1}+MessSchwellen;
algorithm
when sample((Schichtzeit+ MessZeit)/24,1) then
    Defizit:= Defizit + (SollBesetzung - IstBesetzung);
    BelastungsFaktor:= if IstBesetzung==0 then PNlib.Constants.inf else (IstBelastung*SollBesetzung)/(IstBesetzung*SollBelastung);
    if BelastungsFaktor>= MessSchwellen_[1] then
      Ueberbelastet[1]:= Ueberbelastet[1] + 1;
    elseif BelastungsFaktor>= MessSchwellen_[2] then
      Ueberbelastet[2]:= Ueberbelastet[2] + 1;
    elseif BelastungsFaktor>= MessSchwellen_[3] then
      Ueberbelastet[3]:= Ueberbelastet[3] + 1;
    elseif BelastungsFaktor>= MessSchwellen_[4] then
      Ueberbelastet[4]:= Ueberbelastet[4] + 1;
    elseif BelastungsFaktor>= MessSchwellen_[5] then
      Ueberbelastet[5]:= Ueberbelastet[5] + 1;
    end if; 
end when;
annotation(
    Icon(graphics = {Rectangle(fillColor = {255, 0, 0}, extent = {{-100, 100}, {100, -100}}), Text(origin = {-4, 7}, extent = {{-70, 55}, {70, -55}}, textString = "D")}));end DefizitMesser;
