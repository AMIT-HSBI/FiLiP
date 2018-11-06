within FiliP.ModellStationen;

model TestStationUrlaubRandom
  extends Modelica.Icons.Example;


  //Strucktur veraendernde Variablen
  parameter Integer AnzahlPersonal = 1;
  parameter Integer AnzahlSchichten = 3;
  parameter Integer SchichtHatPOOL[:] = {1, 1, 1, 1, 1, 1};
  // Nicht Strucktur veraendernde Variablen
  // 1 Start Fenster "sonstiges"
  // Pool?, EinSpringen?, Defizit
  parameter Real MessZeit[3] = {0.1, 0.2, 0.3};
  parameter Real MessSchwellen[5] = {0.5, 0.4, 0.3, 0.2, 0.1};
    parameter Boolean NichtWochenEnde[50]={false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false};
  parameter Integer MonatEnde[12] = {31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365};
  // Ende Fenster "sonstiges"
  // Start Fenster Station
  parameter Real VKstundenWoche = 38.5;
  // Schicht Start, Schicht Dauer, Schicht Pause Dauer
  parameter Real Schichtzeiten[:, 3] = {{6, 8.2, 0.5}, {14, 8.2, 0.5}, {20.25, 10, 0.75}, {10, 8.2, 0.5}, {8, 8.2, 0.5}, {16, 8.2, 0.5}};
  //parameter Integer SchichtHatPOOL[:] = {1,1,1,1,1,1};
  parameter Real PoolWkeit[:] = {0.5, 0.5, 0.5, 0.5, 0.5, 0.5};
  // Ende Fenster Station
  // Start Fenster Wocheneinteilung
  //Fuer Mo=1, Di=2, Mi=3, ... bei StartTag fürs erste Tag im Jahr
  parameter Integer StartTag = 1 annotation(
    Dialog(enable = true, group = "Belastung"));
  parameter Real SollBelastung[7] = {110, 110, 110, 105, 100, 85, 90} annotation(
    Dialog(enable = true, group = "Belastung"));
  parameter Real PlanKorrektur = 0.45 annotation(
    Dialog(enable = true, group = "Belastung"));
  // Sollbesetzungen
  parameter Integer SollBesetzung[:, 7] = {{4, 4, 4, 4, 4, 3, 3},
                                           {4, 4, 4, 4, 4, 3, 3},
                                           {1, 1, 1, 1, 1, 1, 1},
                                           {1, 1, 1, 1, 1, 1, 1},
                                           {1, 1, 1, 1, 1, 1, 1},
                                           {1, 1, 1, 1, 1, 1, 1}};
  parameter Real SchwankungFallgewichtMin[7] = {-20, -20, -30, -30, -40, -40, -20} annotation(
    Dialog(enable = true, group = "Belastung"));
  parameter Real SchwankungFallgewichtMax[7] = {40, 40, 30, 20, 20, 20, 30} annotation(
    Dialog(enable = true, group = "Belastung"));
  parameter Real SchwankungFallgewichtMeist[7] = {20, 0, 0, -5, -5, -15, 5} annotation(
    Dialog(enable = true, group = "Belastung"));
  // Ende Fenster Wocheneinteilung
  //Start Fenster Personal
  // Stelle, Start Wochenende, Dauer Wochenende, IntervallWochenende, Anzahlwochenenden, StartNichtWochenEnde, IntervallNichtWochenende
  parameter Real PersonalDaten [:,7]= {{1,6,2,14,26,13,14},
                                       {1,13,2,14,26,6,14},
                                       {1,6,2,14,26,13,14},
                                       {1,13,2,14,26,6,14},
                                       {1,6,2,14,26,13,14},
                                       {1,13,2,14,26,6,14},
                                       {0.5,6,2,7,26,8,7},
                                       {0.5,6,2,7,26,8,7},
                                       {1,6,2,14,26,13,14},
                                       {1,13,2,14,26,6,14},
                                       {1,6,2,14,26,13,14},
                                       {1,13,2,14,26,6,14},
                                       {1,6,2,14,26,13,14},
                                       {1,13,2,14,26,6,14},
                                       {0.5,6,2,7,26,8,7},
                                       {0.5,6,2,7,26,8,7},
                                       {1,6,2,14,26,13,14},
                                       {1,13,2,14,26,6,14},
                                       {1,6,2,14,26,13,14},
                                       {1,13,2,14,26,6,14},
                                       {1,6,2,14,26,13,14},
                                       {1,13,2,14,26,6,14},
                                       {0.5,6,2,7,26,8,7},
                                       {0.5,6,2,7,26,8,7},
                                       {1,6,2,14,26,13,14},
                                        {1,13,2,14,26,6,14},
                                        {1,6,2,14,26,13,14},
                                        {1,13,2,14,26,6,14},
                                        {1,6,2,14,26,13,14},
                                        {1,13,2,14,26,6,14},
                                        {0.5,6,2,7,26,8,7},
                                        {0.5,6,2,7,26,8,7},
                                        {1,6,2,14,26,13,14},
                                        {1,13,2,14,26,6,14},
                                        {1,6,2,14,26,13,14},
                                        {1,13,2,14,26,6,14},
                                        {1,6,2,14,26,13,14},
                                        {1,13,2,14,26,6,14},
                                        {0.5,6,2,7,26,8,7},
                                        {0.5,6,2,7,26,8,7},
                                        {1,6,2,14,26,13,14},
                                        {1,13,2,14,26,6,14},
                                        {1,6,2,14,26,13,14},
                                        {1,13,2,14,26,6,14},
                                        {1,6,2,14,26,13,14},
                                        {1,13,2,14,26,6,14},
                                        {0.5,6,2,7,26,8,7},
                                        {0.5,6,2,7,26,8,7},
                                        {0.5,6,2,7,26,8,7},
                                        {0.5,6,2,7,26,8,7}};

  parameter Boolean KannInSchichtArbeiten [:,6]={{true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true}};
  parameter Boolean SpringtEinInSchicht [:,6]={{true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true},
                                            {true,true,true,true,true,true}};

  parameter Integer AnzahlUrlaubsWochen[50]={6,6,6,4,3,1,6,6,6,5,4,0,0,0,0,6,6,6,6,6,6,6,6,6,6,6,6,4,3,1,6,6,6,5,4,0,0,0,0,6,6,6,6,6,6,6,6,6,6,6};
  //Ende Fenster Personal
  //Start Fenster Urlaub
  parameter Integer MaxKopfeUrlaub= 4;
  parameter Real MaxStellenUrlaub= 3;
  //Ende Fenster Urlaub
  parameter Real KrankDauer[:] = {1, 7, 14, 21,28,35,42,500};
  parameter Real WkeitKrankDauer[:] = {216 / 456, 147 / 456, 33 / 456, 18 / 456, 15 / 456, 11 / 456, 4 / 456, 12/456};
  parameter Real WkeitKrankMonat[12] = {0.0186, 0.0186, 0.0186, 0.0186, 0.0186, 0.0186, 0.0186, 0.0186, 0.0186, 0.0186, 0.0186, 0.0186};

public
  inner PNlib.PN.Components.Settings settings annotation(
    Placement(visible = true, transformation(origin = {306, 290}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Real WkeitKrank = if time <= MonatEnde[1] then WkeitKrankMonat[1] else if time <= MonatEnde[2] then WkeitKrankMonat[2] else if time <= MonatEnde[3] then WkeitKrankMonat[3] else if time <= MonatEnde[4] then WkeitKrankMonat[4] else if time <= MonatEnde[5] then WkeitKrankMonat[5] else if time <= MonatEnde[6] then WkeitKrankMonat[6] else if time <= MonatEnde[7] then WkeitKrankMonat[7] else if time <= MonatEnde[8] then WkeitKrankMonat[8] else if time <= MonatEnde[9] then WkeitKrankMonat[9] else if time <= MonatEnde[10] then WkeitKrankMonat[10] else if time <= MonatEnde[11] then WkeitKrankMonat[11] else WkeitKrankMonat[12];
  FiliP.Station station(nP = AnzahlPersonal, AnzahlSchichten = AnzahlSchichten, SollBesetzung = SollBesetzung, SollBelastung = SollBelastung, PlanKorrektur = PlanKorrektur, a = SchwankungFallgewichtMin, b = SchwankungFallgewichtMax, c = SchwankungFallgewichtMeist, StartTag = StartTag, Schichtzeiten = Schichtzeiten[:, 1:2], MessZeit = MessZeit, MessSchwellen = MessSchwellen, SchichtHatPOOL = SchichtHatPOOL, PoolWkeit = PoolWkeit) annotation(
    Placement(visible = true, transformation(extent = {{-20, 20}, {20, 60}}, rotation = 0)));
    FiliP.PflegekraftUrlaubRandom pflegekraft1(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2], VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[1,1], StartWochenEnde = PersonalDaten[1,2], DauerWochenEnde = PersonalDaten[1,3], IntervallWochenEnde = PersonalDaten[1,4], IntervallNichtWochenEnde = PersonalDaten[1,7], NichtWochenEnde = NichtWochenEnde[1], AnzahlWochenEnden=PersonalDaten[1,5], StartNichtWochenEnde = PersonalDaten[1,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[1,:], SpringtEinInSchicht=SpringtEinInSchicht[1,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[1]) annotation (
         Placement(visible = true, transformation(extent = {{-60, -80}, {0, -20}}, rotation = 0)));
    FiliP.PflegekraftUrlaubRandom pflegekraft2(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[2,1], StartWochenEnde = PersonalDaten[2,2], DauerWochenEnde = PersonalDaten[2,3], IntervallWochenEnde = PersonalDaten[2,4], IntervallNichtWochenEnde = PersonalDaten[2,7], NichtWochenEnde = NichtWochenEnde[2], StartNichtWochenEnde = PersonalDaten[2,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[2,:], SpringtEinInSchicht=SpringtEinInSchicht[2,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[2]) if AnzahlPersonal >1;
    FiliP.PflegekraftUrlaubRandom pflegekraft3(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[3,1], StartWochenEnde = PersonalDaten[3,2], DauerWochenEnde = PersonalDaten[3,3], IntervallWochenEnde = PersonalDaten[3,4], IntervallNichtWochenEnde = PersonalDaten[3,7], NichtWochenEnde = NichtWochenEnde[3], StartNichtWochenEnde = PersonalDaten[3,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[3,:], SpringtEinInSchicht=SpringtEinInSchicht[3,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[3]) if AnzahlPersonal >2;
    FiliP.PflegekraftUrlaubRandom pflegekraft4(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[4,1], StartWochenEnde = PersonalDaten[4,2], DauerWochenEnde = PersonalDaten[4,3], IntervallWochenEnde = PersonalDaten[4,4], IntervallNichtWochenEnde = PersonalDaten[4,7], NichtWochenEnde = NichtWochenEnde[4], StartNichtWochenEnde = PersonalDaten[4,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[4,:], SpringtEinInSchicht=SpringtEinInSchicht[4,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[4]) if AnzahlPersonal >3;
    FiliP.PflegekraftUrlaubRandom pflegekraft5(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[5,1], StartWochenEnde = PersonalDaten[5,2], DauerWochenEnde = PersonalDaten[5,3], IntervallWochenEnde = PersonalDaten[5,4], IntervallNichtWochenEnde = PersonalDaten[5,7], NichtWochenEnde = NichtWochenEnde[5], StartNichtWochenEnde = PersonalDaten[5,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[5,:], SpringtEinInSchicht=SpringtEinInSchicht[5,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[5]) if AnzahlPersonal >4;
    FiliP.PflegekraftUrlaubRandom pflegekraft6(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[6,1], StartWochenEnde = PersonalDaten[6,2], DauerWochenEnde = PersonalDaten[6,3], IntervallWochenEnde = PersonalDaten[6,4], IntervallNichtWochenEnde = PersonalDaten[6,7], NichtWochenEnde = NichtWochenEnde[6], StartNichtWochenEnde = PersonalDaten[6,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[6,:], SpringtEinInSchicht=SpringtEinInSchicht[6,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[6]) if AnzahlPersonal >5;
    FiliP.PflegekraftUrlaubRandom pflegekraft7(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[7,1], StartWochenEnde = PersonalDaten[7,2], DauerWochenEnde = PersonalDaten[7,3], IntervallWochenEnde = PersonalDaten[7,4], IntervallNichtWochenEnde = PersonalDaten[7,7], NichtWochenEnde = NichtWochenEnde[7], StartNichtWochenEnde = PersonalDaten[7,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[7,:], SpringtEinInSchicht=SpringtEinInSchicht[7,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[7]) if AnzahlPersonal >6;
    FiliP.PflegekraftUrlaubRandom pflegekraft8(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[8,1], StartWochenEnde = PersonalDaten[8,2], DauerWochenEnde = PersonalDaten[8,3], IntervallWochenEnde = PersonalDaten[8,4], IntervallNichtWochenEnde = PersonalDaten[8,7], NichtWochenEnde = NichtWochenEnde[8], StartNichtWochenEnde = PersonalDaten[8,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[8,:], SpringtEinInSchicht=SpringtEinInSchicht[8,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[8]) if AnzahlPersonal >7;
    //
    FiliP.PflegekraftUrlaubRandom pflegekraft9(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[9,1], StartWochenEnde = PersonalDaten[9,2], DauerWochenEnde = PersonalDaten[9,3], IntervallWochenEnde = PersonalDaten[9,4], IntervallNichtWochenEnde = PersonalDaten[9,7], NichtWochenEnde = NichtWochenEnde[9], StartNichtWochenEnde = PersonalDaten[9,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[9,:], SpringtEinInSchicht=SpringtEinInSchicht[9,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[9]) if AnzahlPersonal >8;
    FiliP.PflegekraftUrlaubRandom pflegekraft10(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[10,1], StartWochenEnde = PersonalDaten[10,2], DauerWochenEnde = PersonalDaten[10,3], IntervallWochenEnde = PersonalDaten[10,4], IntervallNichtWochenEnde = PersonalDaten[10,7], NichtWochenEnde = NichtWochenEnde[10], StartNichtWochenEnde = PersonalDaten[10,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[10,:], SpringtEinInSchicht=SpringtEinInSchicht[10,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[10]) if AnzahlPersonal >9;
    FiliP.PflegekraftUrlaubRandom pflegekraft11(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[11,1], StartWochenEnde = PersonalDaten[11,2], DauerWochenEnde = PersonalDaten[11,3], IntervallWochenEnde = PersonalDaten[11,4], IntervallNichtWochenEnde = PersonalDaten[11,7], NichtWochenEnde = NichtWochenEnde[11], StartNichtWochenEnde = PersonalDaten[11,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[11,:], SpringtEinInSchicht=SpringtEinInSchicht[11,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[11]) if AnzahlPersonal >10;
    FiliP.PflegekraftUrlaubRandom pflegekraft12(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[12,1], StartWochenEnde = PersonalDaten[12,2], DauerWochenEnde = PersonalDaten[12,3], IntervallWochenEnde = PersonalDaten[12,4], IntervallNichtWochenEnde = PersonalDaten[12,7], NichtWochenEnde = NichtWochenEnde[12], StartNichtWochenEnde = PersonalDaten[12,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[12,:], SpringtEinInSchicht=SpringtEinInSchicht[12,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[12]) if AnzahlPersonal >11;
    FiliP.PflegekraftUrlaubRandom pflegekraft13(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[13,1], StartWochenEnde = PersonalDaten[13,2], DauerWochenEnde = PersonalDaten[13,3], IntervallWochenEnde = PersonalDaten[13,4], IntervallNichtWochenEnde = PersonalDaten[13,7], NichtWochenEnde = NichtWochenEnde[13], StartNichtWochenEnde = PersonalDaten[13,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[13,:], SpringtEinInSchicht=SpringtEinInSchicht[13,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[13]) if AnzahlPersonal >12;
    FiliP.PflegekraftUrlaubRandom pflegekraft14(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[14,1], StartWochenEnde = PersonalDaten[14,2], DauerWochenEnde = PersonalDaten[14,3], IntervallWochenEnde = PersonalDaten[14,4], IntervallNichtWochenEnde = PersonalDaten[14,7], NichtWochenEnde = NichtWochenEnde[14], StartNichtWochenEnde = PersonalDaten[14,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[14,:], SpringtEinInSchicht=SpringtEinInSchicht[14,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[14]) if AnzahlPersonal >13;
    FiliP.PflegekraftUrlaubRandom pflegekraft15(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[15,1], StartWochenEnde = PersonalDaten[15,2], DauerWochenEnde = PersonalDaten[15,3], IntervallWochenEnde = PersonalDaten[15,4], IntervallNichtWochenEnde = PersonalDaten[15,7], NichtWochenEnde = NichtWochenEnde[15], StartNichtWochenEnde = PersonalDaten[15,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[15,:], SpringtEinInSchicht=SpringtEinInSchicht[15,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[15]) if AnzahlPersonal >14;
    FiliP.PflegekraftUrlaubRandom pflegekraft16(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[16,1], StartWochenEnde = PersonalDaten[16,2], DauerWochenEnde = PersonalDaten[16,3], IntervallWochenEnde = PersonalDaten[16,4], IntervallNichtWochenEnde = PersonalDaten[16,7], NichtWochenEnde = NichtWochenEnde[16], StartNichtWochenEnde = PersonalDaten[16,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[16,:], SpringtEinInSchicht=SpringtEinInSchicht[16,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[16]) if AnzahlPersonal >15;
    //
    FiliP.PflegekraftUrlaubRandom pflegekraft17(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[17,1], StartWochenEnde = PersonalDaten[17,2], DauerWochenEnde = PersonalDaten[17,3], IntervallWochenEnde = PersonalDaten[17,4], IntervallNichtWochenEnde = PersonalDaten[17,7], NichtWochenEnde = NichtWochenEnde[17], StartNichtWochenEnde = PersonalDaten[17,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[17,:], SpringtEinInSchicht=SpringtEinInSchicht[17,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[17]) if AnzahlPersonal >16;
    FiliP.PflegekraftUrlaubRandom pflegekraft18(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[18,1], StartWochenEnde = PersonalDaten[18,2], DauerWochenEnde = PersonalDaten[18,3], IntervallWochenEnde = PersonalDaten[18,4], IntervallNichtWochenEnde = PersonalDaten[18,7], NichtWochenEnde = NichtWochenEnde[18], StartNichtWochenEnde = PersonalDaten[18,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[18,:], SpringtEinInSchicht=SpringtEinInSchicht[18,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[18]) if AnzahlPersonal >17;
    FiliP.PflegekraftUrlaubRandom pflegekraft19(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[19,1], StartWochenEnde = PersonalDaten[19,2], DauerWochenEnde = PersonalDaten[19,3], IntervallWochenEnde = PersonalDaten[19,4], IntervallNichtWochenEnde = PersonalDaten[19,7], NichtWochenEnde = NichtWochenEnde[19], StartNichtWochenEnde = PersonalDaten[19,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[19,:], SpringtEinInSchicht=SpringtEinInSchicht[19,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[19]) if AnzahlPersonal >18;
    FiliP.PflegekraftUrlaubRandom pflegekraft20(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[20,1], StartWochenEnde = PersonalDaten[20,2], DauerWochenEnde = PersonalDaten[20,3], IntervallWochenEnde = PersonalDaten[20,4], IntervallNichtWochenEnde = PersonalDaten[20,7], NichtWochenEnde = NichtWochenEnde[20], StartNichtWochenEnde = PersonalDaten[20,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[20,:], SpringtEinInSchicht=SpringtEinInSchicht[20,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[20]) if AnzahlPersonal >19;
    FiliP.PflegekraftUrlaubRandom pflegekraft21(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[21,1], StartWochenEnde = PersonalDaten[21,2], DauerWochenEnde = PersonalDaten[21,3], IntervallWochenEnde = PersonalDaten[21,4], IntervallNichtWochenEnde = PersonalDaten[21,7], NichtWochenEnde = NichtWochenEnde[21], StartNichtWochenEnde = PersonalDaten[21,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[21,:], SpringtEinInSchicht=SpringtEinInSchicht[21,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[21]) if AnzahlPersonal >20;
    FiliP.PflegekraftUrlaubRandom pflegekraft22(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[22,1], StartWochenEnde = PersonalDaten[22,2], DauerWochenEnde = PersonalDaten[22,3], IntervallWochenEnde = PersonalDaten[22,4], IntervallNichtWochenEnde = PersonalDaten[22,7], NichtWochenEnde = NichtWochenEnde[22], StartNichtWochenEnde = PersonalDaten[22,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[22,:], SpringtEinInSchicht=SpringtEinInSchicht[22,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[22]) if AnzahlPersonal >21;
    FiliP.PflegekraftUrlaubRandom pflegekraft23(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[23,1], StartWochenEnde = PersonalDaten[23,2], DauerWochenEnde = PersonalDaten[23,3], IntervallWochenEnde = PersonalDaten[23,4], IntervallNichtWochenEnde = PersonalDaten[23,7], NichtWochenEnde = NichtWochenEnde[23], StartNichtWochenEnde = PersonalDaten[23,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[23,:], SpringtEinInSchicht=SpringtEinInSchicht[23,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[23]) if AnzahlPersonal >22;
    FiliP.PflegekraftUrlaubRandom pflegekraft24(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[24,1], StartWochenEnde = PersonalDaten[24,2], DauerWochenEnde = PersonalDaten[24,3], IntervallWochenEnde = PersonalDaten[24,4], IntervallNichtWochenEnde = PersonalDaten[24,7], NichtWochenEnde = NichtWochenEnde[24], StartNichtWochenEnde = PersonalDaten[24,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[24,:], SpringtEinInSchicht=SpringtEinInSchicht[24,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[24]) if AnzahlPersonal >23;
    //
    FiliP.PflegekraftUrlaubRandom pflegekraft25(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[25,1], StartWochenEnde = PersonalDaten[25,2], DauerWochenEnde = PersonalDaten[25,3], IntervallWochenEnde = PersonalDaten[25,4], IntervallNichtWochenEnde = PersonalDaten[25,7], NichtWochenEnde = NichtWochenEnde[25], StartNichtWochenEnde = PersonalDaten[25,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[25,:], SpringtEinInSchicht=SpringtEinInSchicht[25,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[25]) if AnzahlPersonal >24;
    FiliP.PflegekraftUrlaubRandom pflegekraft26(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[26,1], StartWochenEnde = PersonalDaten[26,2], DauerWochenEnde = PersonalDaten[26,3], IntervallWochenEnde = PersonalDaten[26,4], IntervallNichtWochenEnde = PersonalDaten[26,7], NichtWochenEnde = NichtWochenEnde[26], StartNichtWochenEnde = PersonalDaten[26,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[26,:], SpringtEinInSchicht=SpringtEinInSchicht[26,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[26]) if AnzahlPersonal >25;
    FiliP.PflegekraftUrlaubRandom pflegekraft27(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[27,1], StartWochenEnde = PersonalDaten[27,2], DauerWochenEnde = PersonalDaten[27,3], IntervallWochenEnde = PersonalDaten[27,4], IntervallNichtWochenEnde = PersonalDaten[27,7], NichtWochenEnde = NichtWochenEnde[27], StartNichtWochenEnde = PersonalDaten[27,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[27,:], SpringtEinInSchicht=SpringtEinInSchicht[27,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[27]) if AnzahlPersonal >26;
    FiliP.PflegekraftUrlaubRandom pflegekraft28(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[28,1], StartWochenEnde = PersonalDaten[28,2], DauerWochenEnde = PersonalDaten[28,3], IntervallWochenEnde = PersonalDaten[28,4], IntervallNichtWochenEnde = PersonalDaten[28,7], NichtWochenEnde = NichtWochenEnde[28], StartNichtWochenEnde = PersonalDaten[28,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[28,:], SpringtEinInSchicht=SpringtEinInSchicht[28,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[28]) if AnzahlPersonal >27;
    FiliP.PflegekraftUrlaubRandom pflegekraft29(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[29,1], StartWochenEnde = PersonalDaten[29,2], DauerWochenEnde = PersonalDaten[29,3], IntervallWochenEnde = PersonalDaten[29,4], IntervallNichtWochenEnde = PersonalDaten[29,7], NichtWochenEnde = NichtWochenEnde[29], StartNichtWochenEnde = PersonalDaten[29,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[29,:], SpringtEinInSchicht=SpringtEinInSchicht[29,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[29]) if AnzahlPersonal >28;
    FiliP.PflegekraftUrlaubRandom pflegekraft30(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[30,1], StartWochenEnde = PersonalDaten[30,2], DauerWochenEnde = PersonalDaten[30,3], IntervallWochenEnde = PersonalDaten[30,4], IntervallNichtWochenEnde = PersonalDaten[30,7], NichtWochenEnde = NichtWochenEnde[30], StartNichtWochenEnde = PersonalDaten[30,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[30,:], SpringtEinInSchicht=SpringtEinInSchicht[30,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[30]) if AnzahlPersonal >29;
    FiliP.PflegekraftUrlaubRandom pflegekraft31(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[31,1], StartWochenEnde = PersonalDaten[31,2], DauerWochenEnde = PersonalDaten[31,3], IntervallWochenEnde = PersonalDaten[31,4], IntervallNichtWochenEnde = PersonalDaten[31,7], NichtWochenEnde = NichtWochenEnde[31], StartNichtWochenEnde = PersonalDaten[31,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[31,:], SpringtEinInSchicht=SpringtEinInSchicht[31,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[31]) if AnzahlPersonal >30;
    FiliP.PflegekraftUrlaubRandom pflegekraft32(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[32,1], StartWochenEnde = PersonalDaten[32,2], DauerWochenEnde = PersonalDaten[32,3], IntervallWochenEnde = PersonalDaten[32,4], IntervallNichtWochenEnde = PersonalDaten[32,7], NichtWochenEnde = NichtWochenEnde[32], StartNichtWochenEnde = PersonalDaten[32,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[32,:], SpringtEinInSchicht=SpringtEinInSchicht[32,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[32]) if AnzahlPersonal >31;
    //
    FiliP.PflegekraftUrlaubRandom pflegekraft33(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[33,1], StartWochenEnde = PersonalDaten[33,2], DauerWochenEnde = PersonalDaten[33,3], IntervallWochenEnde = PersonalDaten[33,4], IntervallNichtWochenEnde = PersonalDaten[33,7], NichtWochenEnde = NichtWochenEnde[33], StartNichtWochenEnde = PersonalDaten[33,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[33,:], SpringtEinInSchicht=SpringtEinInSchicht[33,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[33]) if AnzahlPersonal >32;
    FiliP.PflegekraftUrlaubRandom pflegekraft34(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[34,1], StartWochenEnde = PersonalDaten[34,2], DauerWochenEnde = PersonalDaten[34,3], IntervallWochenEnde = PersonalDaten[34,4], IntervallNichtWochenEnde = PersonalDaten[34,7], NichtWochenEnde = NichtWochenEnde[34], StartNichtWochenEnde = PersonalDaten[34,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[34,:], SpringtEinInSchicht=SpringtEinInSchicht[34,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[34]) if AnzahlPersonal >33;
    FiliP.PflegekraftUrlaubRandom pflegekraft35(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[35,1], StartWochenEnde = PersonalDaten[35,2], DauerWochenEnde = PersonalDaten[35,3], IntervallWochenEnde = PersonalDaten[35,4], IntervallNichtWochenEnde = PersonalDaten[35,7], NichtWochenEnde = NichtWochenEnde[35], StartNichtWochenEnde = PersonalDaten[35,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[35,:], SpringtEinInSchicht=SpringtEinInSchicht[35,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[35]) if AnzahlPersonal >34;
    FiliP.PflegekraftUrlaubRandom pflegekraft36(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[36,1], StartWochenEnde = PersonalDaten[36,2], DauerWochenEnde = PersonalDaten[36,3], IntervallWochenEnde = PersonalDaten[36,4], IntervallNichtWochenEnde = PersonalDaten[36,7], NichtWochenEnde = NichtWochenEnde[36], StartNichtWochenEnde = PersonalDaten[36,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[36,:], SpringtEinInSchicht=SpringtEinInSchicht[36,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[36]) if AnzahlPersonal >35;
    FiliP.PflegekraftUrlaubRandom pflegekraft37(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[37,1], StartWochenEnde = PersonalDaten[37,2], DauerWochenEnde = PersonalDaten[37,3], IntervallWochenEnde = PersonalDaten[37,4], IntervallNichtWochenEnde = PersonalDaten[37,7], NichtWochenEnde = NichtWochenEnde[37], StartNichtWochenEnde = PersonalDaten[37,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[37,:], SpringtEinInSchicht=SpringtEinInSchicht[37,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[37]) if AnzahlPersonal >36;
    FiliP.PflegekraftUrlaubRandom pflegekraft38(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[38,1], StartWochenEnde = PersonalDaten[38,2], DauerWochenEnde = PersonalDaten[38,3], IntervallWochenEnde = PersonalDaten[38,4], IntervallNichtWochenEnde = PersonalDaten[38,7], NichtWochenEnde = NichtWochenEnde[38], StartNichtWochenEnde = PersonalDaten[38,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[38,:], SpringtEinInSchicht=SpringtEinInSchicht[38,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[38]) if AnzahlPersonal >37;
    FiliP.PflegekraftUrlaubRandom pflegekraft39(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[39,1], StartWochenEnde = PersonalDaten[39,2], DauerWochenEnde = PersonalDaten[39,3], IntervallWochenEnde = PersonalDaten[39,4], IntervallNichtWochenEnde = PersonalDaten[39,7], NichtWochenEnde = NichtWochenEnde[39], StartNichtWochenEnde = PersonalDaten[39,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[39,:], SpringtEinInSchicht=SpringtEinInSchicht[39,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[39]) if AnzahlPersonal >38;
    FiliP.PflegekraftUrlaubRandom pflegekraft40(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[40,1], StartWochenEnde = PersonalDaten[40,2], DauerWochenEnde = PersonalDaten[40,3], IntervallWochenEnde = PersonalDaten[40,4], IntervallNichtWochenEnde = PersonalDaten[40,7], NichtWochenEnde = NichtWochenEnde[40], StartNichtWochenEnde = PersonalDaten[40,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[40,:], SpringtEinInSchicht=SpringtEinInSchicht[40,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[40]) if AnzahlPersonal >39;
    //
    FiliP.PflegekraftUrlaubRandom pflegekraft41(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[41,1], StartWochenEnde = PersonalDaten[41,2], DauerWochenEnde = PersonalDaten[41,3], IntervallWochenEnde = PersonalDaten[41,4], IntervallNichtWochenEnde = PersonalDaten[41,7], NichtWochenEnde = NichtWochenEnde[41], StartNichtWochenEnde = PersonalDaten[41,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[41,:], SpringtEinInSchicht=SpringtEinInSchicht[41,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[41]) if AnzahlPersonal >40;
    FiliP.PflegekraftUrlaubRandom pflegekraft42(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[42,1], StartWochenEnde = PersonalDaten[42,2], DauerWochenEnde = PersonalDaten[42,3], IntervallWochenEnde = PersonalDaten[42,4], IntervallNichtWochenEnde = PersonalDaten[42,7], NichtWochenEnde = NichtWochenEnde[42], StartNichtWochenEnde = PersonalDaten[42,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[42,:], SpringtEinInSchicht=SpringtEinInSchicht[42,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[42]) if AnzahlPersonal >41;
    FiliP.PflegekraftUrlaubRandom pflegekraft43(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[43,1], StartWochenEnde = PersonalDaten[43,2], DauerWochenEnde = PersonalDaten[43,3], IntervallWochenEnde = PersonalDaten[43,4], IntervallNichtWochenEnde = PersonalDaten[43,7], NichtWochenEnde = NichtWochenEnde[43], StartNichtWochenEnde = PersonalDaten[43,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[43,:], SpringtEinInSchicht=SpringtEinInSchicht[43,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[43]) if AnzahlPersonal >42;
    FiliP.PflegekraftUrlaubRandom pflegekraft44(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[44,1], StartWochenEnde = PersonalDaten[44,2], DauerWochenEnde = PersonalDaten[44,3], IntervallWochenEnde = PersonalDaten[44,4], IntervallNichtWochenEnde = PersonalDaten[44,7], NichtWochenEnde = NichtWochenEnde[44], StartNichtWochenEnde = PersonalDaten[44,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[44,:], SpringtEinInSchicht=SpringtEinInSchicht[44,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[44]) if AnzahlPersonal >43;
    FiliP.PflegekraftUrlaubRandom pflegekraft45(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[45,1], StartWochenEnde = PersonalDaten[45,2], DauerWochenEnde = PersonalDaten[45,3], IntervallWochenEnde = PersonalDaten[45,4], IntervallNichtWochenEnde = PersonalDaten[45,7], NichtWochenEnde = NichtWochenEnde[45], StartNichtWochenEnde = PersonalDaten[45,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[45,:], SpringtEinInSchicht=SpringtEinInSchicht[45,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[45]) if AnzahlPersonal >44;
    FiliP.PflegekraftUrlaubRandom pflegekraft46(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[46,1], StartWochenEnde = PersonalDaten[46,2], DauerWochenEnde = PersonalDaten[46,3], IntervallWochenEnde = PersonalDaten[46,4], IntervallNichtWochenEnde = PersonalDaten[46,7], NichtWochenEnde = NichtWochenEnde[46], StartNichtWochenEnde = PersonalDaten[46,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[46,:], SpringtEinInSchicht=SpringtEinInSchicht[46,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[46]) if AnzahlPersonal >45;
    FiliP.PflegekraftUrlaubRandom pflegekraft47(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[47,1], StartWochenEnde = PersonalDaten[47,2], DauerWochenEnde = PersonalDaten[47,3], IntervallWochenEnde = PersonalDaten[47,4], IntervallNichtWochenEnde = PersonalDaten[47,7], NichtWochenEnde = NichtWochenEnde[47], StartNichtWochenEnde = PersonalDaten[47,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[47,:], SpringtEinInSchicht=SpringtEinInSchicht[47,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[47]) if AnzahlPersonal >46;
    FiliP.PflegekraftUrlaubRandom pflegekraft48(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[48,1], StartWochenEnde = PersonalDaten[48,2], DauerWochenEnde = PersonalDaten[48,3], IntervallWochenEnde = PersonalDaten[48,4], IntervallNichtWochenEnde = PersonalDaten[48,7], NichtWochenEnde = NichtWochenEnde[48], StartNichtWochenEnde = PersonalDaten[48,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[48,:], SpringtEinInSchicht=SpringtEinInSchicht[48,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[48]) if AnzahlPersonal >47;
    //
    FiliP.PflegekraftUrlaubRandom pflegekraft49(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[49,1], StartWochenEnde = PersonalDaten[49,2], DauerWochenEnde = PersonalDaten[49,3], IntervallWochenEnde = PersonalDaten[49,4], IntervallNichtWochenEnde = PersonalDaten[49,7], NichtWochenEnde = NichtWochenEnde[49], StartNichtWochenEnde = PersonalDaten[49,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[49,:], SpringtEinInSchicht=SpringtEinInSchicht[49,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[49]) if AnzahlPersonal >48;
    FiliP.PflegekraftUrlaubRandom pflegekraft50(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[50,1], StartWochenEnde = PersonalDaten[50,2], DauerWochenEnde = PersonalDaten[50,3], IntervallWochenEnde = PersonalDaten[50,4], IntervallNichtWochenEnde = PersonalDaten[50,7], NichtWochenEnde = NichtWochenEnde[50], StartNichtWochenEnde = PersonalDaten[50,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[50,:], SpringtEinInSchicht=SpringtEinInSchicht[50,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen[50]) if AnzahlPersonal >49;





  PNlib.PN.Components.PD UrlaubKopf(maxTokens = MaxKopfeUrlaub, nInDis = AnzahlPersonal, nOutDis = AnzahlPersonal)  annotation(
    Placement(visible = true, transformation(origin = {68, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PC UrlaubStellen(maxTokens = MaxStellenUrlaub, nInDis = AnzahlPersonal, nOutDis = AnzahlPersonal)  annotation(
    Placement(visible = true, transformation(origin = {70, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));


equation
  connect(pflegekraft1.UrlaubStelleOut, UrlaubStellen.inTransitionDis[1]);
  connect(pflegekraft2.UrlaubStelleOut, UrlaubStellen.inTransitionDis[2]);
  connect(pflegekraft3.UrlaubStelleOut, UrlaubStellen.inTransitionDis[3]);
  connect(pflegekraft4.UrlaubStelleOut, UrlaubStellen.inTransitionDis[4]);
  connect(pflegekraft5.UrlaubStelleOut, UrlaubStellen.inTransitionDis[5]);
  connect(pflegekraft6.UrlaubStelleOut, UrlaubStellen.inTransitionDis[6]);
  connect(pflegekraft7.UrlaubStelleOut, UrlaubStellen.inTransitionDis[7]);
  connect(pflegekraft8.UrlaubStelleOut, UrlaubStellen.inTransitionDis[8]);
  connect(pflegekraft9.UrlaubStelleOut, UrlaubStellen.inTransitionDis[9]);
  connect(pflegekraft10.UrlaubStelleOut, UrlaubStellen.inTransitionDis[10]);
  connect(pflegekraft11.UrlaubStelleOut, UrlaubStellen.inTransitionDis[11]);
  connect(pflegekraft12.UrlaubStelleOut, UrlaubStellen.inTransitionDis[12]);
  connect(pflegekraft13.UrlaubStelleOut, UrlaubStellen.inTransitionDis[13]);
  connect(pflegekraft14.UrlaubStelleOut, UrlaubStellen.inTransitionDis[14]);
  connect(pflegekraft15.UrlaubStelleOut, UrlaubStellen.inTransitionDis[15]);
  connect(pflegekraft16.UrlaubStelleOut, UrlaubStellen.inTransitionDis[16]);
  connect(pflegekraft17.UrlaubStelleOut, UrlaubStellen.inTransitionDis[17]);
  connect(pflegekraft18.UrlaubStelleOut, UrlaubStellen.inTransitionDis[18]);
  connect(pflegekraft19.UrlaubStelleOut, UrlaubStellen.inTransitionDis[19]);
  connect(pflegekraft20.UrlaubStelleOut, UrlaubStellen.inTransitionDis[20]);
  connect(pflegekraft21.UrlaubStelleOut, UrlaubStellen.inTransitionDis[21]);
  connect(pflegekraft22.UrlaubStelleOut, UrlaubStellen.inTransitionDis[22]);
  connect(pflegekraft23.UrlaubStelleOut, UrlaubStellen.inTransitionDis[23]);
  connect(pflegekraft24.UrlaubStelleOut, UrlaubStellen.inTransitionDis[24]);
  connect(pflegekraft25.UrlaubStelleOut, UrlaubStellen.inTransitionDis[25]);
  connect(pflegekraft26.UrlaubStelleOut, UrlaubStellen.inTransitionDis[26]);
  connect(pflegekraft27.UrlaubStelleOut, UrlaubStellen.inTransitionDis[27]);
  connect(pflegekraft28.UrlaubStelleOut, UrlaubStellen.inTransitionDis[28]);
  connect(pflegekraft29.UrlaubStelleOut, UrlaubStellen.inTransitionDis[29]);
  connect(pflegekraft30.UrlaubStelleOut, UrlaubStellen.inTransitionDis[30]);
  connect(pflegekraft31.UrlaubStelleOut, UrlaubStellen.inTransitionDis[31]);
  connect(pflegekraft32.UrlaubStelleOut, UrlaubStellen.inTransitionDis[32]);
  connect(pflegekraft33.UrlaubStelleOut, UrlaubStellen.inTransitionDis[33]);
  connect(pflegekraft34.UrlaubStelleOut, UrlaubStellen.inTransitionDis[34]);
  connect(pflegekraft35.UrlaubStelleOut, UrlaubStellen.inTransitionDis[35]);
  connect(pflegekraft36.UrlaubStelleOut, UrlaubStellen.inTransitionDis[36]);
  connect(pflegekraft37.UrlaubStelleOut, UrlaubStellen.inTransitionDis[37]);
  connect(pflegekraft38.UrlaubStelleOut, UrlaubStellen.inTransitionDis[38]);
  connect(pflegekraft39.UrlaubStelleOut, UrlaubStellen.inTransitionDis[39]);
  connect(pflegekraft40.UrlaubStelleOut, UrlaubStellen.inTransitionDis[40]);
  connect(pflegekraft41.UrlaubStelleOut, UrlaubStellen.inTransitionDis[41]);
  connect(pflegekraft42.UrlaubStelleOut, UrlaubStellen.inTransitionDis[42]);
  connect(pflegekraft43.UrlaubStelleOut, UrlaubStellen.inTransitionDis[43]);
  connect(pflegekraft44.UrlaubStelleOut, UrlaubStellen.inTransitionDis[44]);
  connect(pflegekraft45.UrlaubStelleOut, UrlaubStellen.inTransitionDis[45]);
  connect(pflegekraft46.UrlaubStelleOut, UrlaubStellen.inTransitionDis[46]);
  connect(pflegekraft47.UrlaubStelleOut, UrlaubStellen.inTransitionDis[47]);
  connect(pflegekraft48.UrlaubStelleOut, UrlaubStellen.inTransitionDis[48]);
  connect(pflegekraft49.UrlaubStelleOut, UrlaubStellen.inTransitionDis[49]);
  connect(pflegekraft50.UrlaubStelleOut, UrlaubStellen.inTransitionDis[50]);

/////////////////////////////////////////////////
  connect(pflegekraft1.UrlaubKopfOut, UrlaubKopf.inTransitionDis[1]);
  connect(pflegekraft2.UrlaubKopfOut, UrlaubKopf.inTransitionDis[2]);
  connect(pflegekraft3.UrlaubKopfOut, UrlaubKopf.inTransitionDis[3]);
  connect(pflegekraft4.UrlaubKopfOut, UrlaubKopf.inTransitionDis[4]);
  connect(pflegekraft5.UrlaubKopfOut, UrlaubKopf.inTransitionDis[5]);
  connect(pflegekraft6.UrlaubKopfOut, UrlaubKopf.inTransitionDis[6]);
  connect(pflegekraft7.UrlaubKopfOut, UrlaubKopf.inTransitionDis[7]);
  connect(pflegekraft8.UrlaubKopfOut, UrlaubKopf.inTransitionDis[8]);
  connect(pflegekraft9.UrlaubKopfOut, UrlaubKopf.inTransitionDis[9]);
  connect(pflegekraft10.UrlaubKopfOut, UrlaubKopf.inTransitionDis[10]);
  connect(pflegekraft11.UrlaubKopfOut, UrlaubKopf.inTransitionDis[11]);
  connect(pflegekraft12.UrlaubKopfOut, UrlaubKopf.inTransitionDis[12]);
  connect(pflegekraft13.UrlaubKopfOut, UrlaubKopf.inTransitionDis[13]);
  connect(pflegekraft14.UrlaubKopfOut, UrlaubKopf.inTransitionDis[14]);
  connect(pflegekraft15.UrlaubKopfOut, UrlaubKopf.inTransitionDis[15]);
  connect(pflegekraft16.UrlaubKopfOut, UrlaubKopf.inTransitionDis[16]);
  connect(pflegekraft17.UrlaubKopfOut, UrlaubKopf.inTransitionDis[17]);
  connect(pflegekraft18.UrlaubKopfOut, UrlaubKopf.inTransitionDis[18]);
  connect(pflegekraft19.UrlaubKopfOut, UrlaubKopf.inTransitionDis[19]);
  connect(pflegekraft20.UrlaubKopfOut, UrlaubKopf.inTransitionDis[20]);
  connect(pflegekraft21.UrlaubKopfOut, UrlaubKopf.inTransitionDis[21]);
  connect(pflegekraft22.UrlaubKopfOut, UrlaubKopf.inTransitionDis[22]);
  connect(pflegekraft23.UrlaubKopfOut, UrlaubKopf.inTransitionDis[23]);
  connect(pflegekraft24.UrlaubKopfOut, UrlaubKopf.inTransitionDis[24]);
  connect(pflegekraft25.UrlaubKopfOut, UrlaubKopf.inTransitionDis[25]);
  connect(pflegekraft26.UrlaubKopfOut, UrlaubKopf.inTransitionDis[26]);
  connect(pflegekraft27.UrlaubKopfOut, UrlaubKopf.inTransitionDis[27]);
  connect(pflegekraft28.UrlaubKopfOut, UrlaubKopf.inTransitionDis[28]);
  connect(pflegekraft29.UrlaubKopfOut, UrlaubKopf.inTransitionDis[29]);
  connect(pflegekraft30.UrlaubKopfOut, UrlaubKopf.inTransitionDis[30]);
  connect(pflegekraft31.UrlaubKopfOut, UrlaubKopf.inTransitionDis[31]);
  connect(pflegekraft32.UrlaubKopfOut, UrlaubKopf.inTransitionDis[32]);
  connect(pflegekraft33.UrlaubKopfOut, UrlaubKopf.inTransitionDis[33]);
  connect(pflegekraft34.UrlaubKopfOut, UrlaubKopf.inTransitionDis[34]);
  connect(pflegekraft35.UrlaubKopfOut, UrlaubKopf.inTransitionDis[35]);
  connect(pflegekraft36.UrlaubKopfOut, UrlaubKopf.inTransitionDis[36]);
  connect(pflegekraft37.UrlaubKopfOut, UrlaubKopf.inTransitionDis[37]);
  connect(pflegekraft38.UrlaubKopfOut, UrlaubKopf.inTransitionDis[38]);
  connect(pflegekraft39.UrlaubKopfOut, UrlaubKopf.inTransitionDis[39]);
  connect(pflegekraft40.UrlaubKopfOut, UrlaubKopf.inTransitionDis[40]);
  connect(pflegekraft41.UrlaubKopfOut, UrlaubKopf.inTransitionDis[41]);
  connect(pflegekraft42.UrlaubKopfOut, UrlaubKopf.inTransitionDis[42]);
  connect(pflegekraft43.UrlaubKopfOut, UrlaubKopf.inTransitionDis[43]);
  connect(pflegekraft44.UrlaubKopfOut, UrlaubKopf.inTransitionDis[44]);
  connect(pflegekraft45.UrlaubKopfOut, UrlaubKopf.inTransitionDis[45]);
  connect(pflegekraft46.UrlaubKopfOut, UrlaubKopf.inTransitionDis[46]);
  connect(pflegekraft47.UrlaubKopfOut, UrlaubKopf.inTransitionDis[47]);
  connect(pflegekraft48.UrlaubKopfOut, UrlaubKopf.inTransitionDis[48]);
  connect(pflegekraft49.UrlaubKopfOut, UrlaubKopf.inTransitionDis[49]);
  connect(pflegekraft50.UrlaubKopfOut, UrlaubKopf.inTransitionDis[50]);
/////////////////////////////////////////////////
  connect(pflegekraft1.UrlaubStelleIn, UrlaubStellen.outTransitionDis[1]);
  connect(pflegekraft2.UrlaubStelleIn, UrlaubStellen.outTransitionDis[2]);
  connect(pflegekraft3.UrlaubStelleIn, UrlaubStellen.outTransitionDis[3]);
  connect(pflegekraft4.UrlaubStelleIn, UrlaubStellen.outTransitionDis[4]);
  connect(pflegekraft5.UrlaubStelleIn, UrlaubStellen.outTransitionDis[5]);
  connect(pflegekraft6.UrlaubStelleIn, UrlaubStellen.outTransitionDis[6]);
  connect(pflegekraft7.UrlaubStelleIn, UrlaubStellen.outTransitionDis[7]);
  connect(pflegekraft8.UrlaubStelleIn, UrlaubStellen.outTransitionDis[8]);
  connect(pflegekraft9.UrlaubStelleIn, UrlaubStellen.outTransitionDis[9]);
  connect(pflegekraft10.UrlaubStelleIn, UrlaubStellen.outTransitionDis[10]);
  connect(pflegekraft11.UrlaubStelleIn, UrlaubStellen.outTransitionDis[11]);
  connect(pflegekraft12.UrlaubStelleIn, UrlaubStellen.outTransitionDis[12]);
  connect(pflegekraft13.UrlaubStelleIn, UrlaubStellen.outTransitionDis[13]);
  connect(pflegekraft14.UrlaubStelleIn, UrlaubStellen.outTransitionDis[14]);
  connect(pflegekraft15.UrlaubStelleIn, UrlaubStellen.outTransitionDis[15]);
  connect(pflegekraft16.UrlaubStelleIn, UrlaubStellen.outTransitionDis[16]);
  connect(pflegekraft17.UrlaubStelleIn, UrlaubStellen.outTransitionDis[17]);
  connect(pflegekraft18.UrlaubStelleIn, UrlaubStellen.outTransitionDis[18]);
  connect(pflegekraft19.UrlaubStelleIn, UrlaubStellen.outTransitionDis[19]);
  connect(pflegekraft20.UrlaubStelleIn, UrlaubStellen.outTransitionDis[20]);
  connect(pflegekraft21.UrlaubStelleIn, UrlaubStellen.outTransitionDis[21]);
  connect(pflegekraft22.UrlaubStelleIn, UrlaubStellen.outTransitionDis[22]);
  connect(pflegekraft23.UrlaubStelleIn, UrlaubStellen.outTransitionDis[23]);
  connect(pflegekraft24.UrlaubStelleIn, UrlaubStellen.outTransitionDis[24]);
  connect(pflegekraft25.UrlaubStelleIn, UrlaubStellen.outTransitionDis[25]);
  connect(pflegekraft26.UrlaubStelleIn, UrlaubStellen.outTransitionDis[26]);
  connect(pflegekraft27.UrlaubStelleIn, UrlaubStellen.outTransitionDis[27]);
  connect(pflegekraft28.UrlaubStelleIn, UrlaubStellen.outTransitionDis[28]);
  connect(pflegekraft29.UrlaubStelleIn, UrlaubStellen.outTransitionDis[29]);
  connect(pflegekraft30.UrlaubStelleIn, UrlaubStellen.outTransitionDis[30]);
  connect(pflegekraft31.UrlaubStelleIn, UrlaubStellen.outTransitionDis[31]);
  connect(pflegekraft32.UrlaubStelleIn, UrlaubStellen.outTransitionDis[32]);
  connect(pflegekraft33.UrlaubStelleIn, UrlaubStellen.outTransitionDis[33]);
  connect(pflegekraft34.UrlaubStelleIn, UrlaubStellen.outTransitionDis[34]);
  connect(pflegekraft35.UrlaubStelleIn, UrlaubStellen.outTransitionDis[35]);
  connect(pflegekraft36.UrlaubStelleIn, UrlaubStellen.outTransitionDis[36]);
  connect(pflegekraft37.UrlaubStelleIn, UrlaubStellen.outTransitionDis[37]);
  connect(pflegekraft38.UrlaubStelleIn, UrlaubStellen.outTransitionDis[38]);
  connect(pflegekraft39.UrlaubStelleIn, UrlaubStellen.outTransitionDis[39]);
  connect(pflegekraft40.UrlaubStelleIn, UrlaubStellen.outTransitionDis[40]);
  connect(pflegekraft41.UrlaubStelleIn, UrlaubStellen.outTransitionDis[41]);
  connect(pflegekraft42.UrlaubStelleIn, UrlaubStellen.outTransitionDis[42]);
  connect(pflegekraft43.UrlaubStelleIn, UrlaubStellen.outTransitionDis[43]);
  connect(pflegekraft44.UrlaubStelleIn, UrlaubStellen.outTransitionDis[44]);
  connect(pflegekraft45.UrlaubStelleIn, UrlaubStellen.outTransitionDis[45]);
  connect(pflegekraft46.UrlaubStelleIn, UrlaubStellen.outTransitionDis[46]);
  connect(pflegekraft47.UrlaubStelleIn, UrlaubStellen.outTransitionDis[47]);
  connect(pflegekraft48.UrlaubStelleIn, UrlaubStellen.outTransitionDis[48]);
  connect(pflegekraft49.UrlaubStelleIn, UrlaubStellen.outTransitionDis[49]);
  connect(pflegekraft50.UrlaubStelleIn, UrlaubStellen.outTransitionDis[50]);
/////////////////////////////////////////////////
  connect(pflegekraft1.UrlaubKopfIn, UrlaubKopf.outTransitionDis[1]);
  connect(pflegekraft2.UrlaubKopfIn, UrlaubKopf.outTransitionDis[2]);
  connect(pflegekraft3.UrlaubKopfIn, UrlaubKopf.outTransitionDis[3]);
  connect(pflegekraft4.UrlaubKopfIn, UrlaubKopf.outTransitionDis[4]);
  connect(pflegekraft5.UrlaubKopfIn, UrlaubKopf.outTransitionDis[5]);
  connect(pflegekraft6.UrlaubKopfIn, UrlaubKopf.outTransitionDis[6]);
  connect(pflegekraft7.UrlaubKopfIn, UrlaubKopf.outTransitionDis[7]);
  connect(pflegekraft8.UrlaubKopfIn, UrlaubKopf.outTransitionDis[8]);
  connect(pflegekraft9.UrlaubKopfIn, UrlaubKopf.outTransitionDis[9]);
  connect(pflegekraft10.UrlaubKopfIn, UrlaubKopf.outTransitionDis[10]);
  connect(pflegekraft11.UrlaubKopfIn, UrlaubKopf.outTransitionDis[11]);
  connect(pflegekraft12.UrlaubKopfIn, UrlaubKopf.outTransitionDis[12]);
  connect(pflegekraft13.UrlaubKopfIn, UrlaubKopf.outTransitionDis[13]);
  connect(pflegekraft14.UrlaubKopfIn, UrlaubKopf.outTransitionDis[14]);
  connect(pflegekraft15.UrlaubKopfIn, UrlaubKopf.outTransitionDis[15]);
  connect(pflegekraft16.UrlaubKopfIn, UrlaubKopf.outTransitionDis[16]);
  connect(pflegekraft17.UrlaubKopfIn, UrlaubKopf.outTransitionDis[17]);
  connect(pflegekraft18.UrlaubKopfIn, UrlaubKopf.outTransitionDis[18]);
  connect(pflegekraft19.UrlaubKopfIn, UrlaubKopf.outTransitionDis[19]);
  connect(pflegekraft20.UrlaubKopfIn, UrlaubKopf.outTransitionDis[20]);
  connect(pflegekraft21.UrlaubKopfIn, UrlaubKopf.outTransitionDis[21]);
  connect(pflegekraft22.UrlaubKopfIn, UrlaubKopf.outTransitionDis[22]);
  connect(pflegekraft23.UrlaubKopfIn, UrlaubKopf.outTransitionDis[23]);
  connect(pflegekraft24.UrlaubKopfIn, UrlaubKopf.outTransitionDis[24]);
  connect(pflegekraft25.UrlaubKopfIn, UrlaubKopf.outTransitionDis[25]);
  connect(pflegekraft26.UrlaubKopfIn, UrlaubKopf.outTransitionDis[26]);
  connect(pflegekraft27.UrlaubKopfIn, UrlaubKopf.outTransitionDis[27]);
  connect(pflegekraft28.UrlaubKopfIn, UrlaubKopf.outTransitionDis[28]);
  connect(pflegekraft29.UrlaubKopfIn, UrlaubKopf.outTransitionDis[29]);
  connect(pflegekraft30.UrlaubKopfIn, UrlaubKopf.outTransitionDis[30]);
  connect(pflegekraft31.UrlaubKopfIn, UrlaubKopf.outTransitionDis[31]);
  connect(pflegekraft32.UrlaubKopfIn, UrlaubKopf.outTransitionDis[32]);
  connect(pflegekraft33.UrlaubKopfIn, UrlaubKopf.outTransitionDis[33]);
  connect(pflegekraft34.UrlaubKopfIn, UrlaubKopf.outTransitionDis[34]);
  connect(pflegekraft35.UrlaubKopfIn, UrlaubKopf.outTransitionDis[35]);
  connect(pflegekraft36.UrlaubKopfIn, UrlaubKopf.outTransitionDis[36]);
  connect(pflegekraft37.UrlaubKopfIn, UrlaubKopf.outTransitionDis[37]);
  connect(pflegekraft38.UrlaubKopfIn, UrlaubKopf.outTransitionDis[38]);
  connect(pflegekraft39.UrlaubKopfIn, UrlaubKopf.outTransitionDis[39]);
  connect(pflegekraft40.UrlaubKopfIn, UrlaubKopf.outTransitionDis[40]);
  connect(pflegekraft41.UrlaubKopfIn, UrlaubKopf.outTransitionDis[41]);
  connect(pflegekraft42.UrlaubKopfIn, UrlaubKopf.outTransitionDis[42]);
  connect(pflegekraft43.UrlaubKopfIn, UrlaubKopf.outTransitionDis[43]);
  connect(pflegekraft44.UrlaubKopfIn, UrlaubKopf.outTransitionDis[44]);
  connect(pflegekraft45.UrlaubKopfIn, UrlaubKopf.outTransitionDis[45]);
  connect(pflegekraft46.UrlaubKopfIn, UrlaubKopf.outTransitionDis[46]);
  connect(pflegekraft47.UrlaubKopfIn, UrlaubKopf.outTransitionDis[47]);
  connect(pflegekraft48.UrlaubKopfIn, UrlaubKopf.outTransitionDis[48]);
  connect(pflegekraft49.UrlaubKopfIn, UrlaubKopf.outTransitionDis[49]);
  connect(pflegekraft50.UrlaubKopfIn, UrlaubKopf.outTransitionDis[50]);


    for i in 1:(2*AnzahlSchichten) loop
      connect(station.PersonalIn[i], pflegekraft1.transitionOutDis[i]);
      connect(station.PersonalIn[2*AnzahlSchichten+i], pflegekraft2.transitionOutDis[i]);
      connect(station.PersonalIn[4*AnzahlSchichten+i], pflegekraft3.transitionOutDis[i]);
      connect(station.PersonalIn[6*AnzahlSchichten+i], pflegekraft4.transitionOutDis[i]);
      connect(station.PersonalIn[8*AnzahlSchichten+i], pflegekraft5.transitionOutDis[i]);
      connect(station.PersonalIn[10*AnzahlSchichten+i], pflegekraft6.transitionOutDis[i]);
      connect(station.PersonalIn[12*AnzahlSchichten+i], pflegekraft7.transitionOutDis[i]);
      connect(station.PersonalIn[14*AnzahlSchichten+i], pflegekraft8.transitionOutDis[i]);
      connect(station.PersonalIn[16*AnzahlSchichten+i], pflegekraft9.transitionOutDis[i]);
      connect(station.PersonalIn[18*AnzahlSchichten+i], pflegekraft10.transitionOutDis[i]);
      connect(station.PersonalIn[20*AnzahlSchichten+i], pflegekraft11.transitionOutDis[i]);
      connect(station.PersonalIn[22*AnzahlSchichten+i], pflegekraft12.transitionOutDis[i]);
      connect(station.PersonalIn[24*AnzahlSchichten+i], pflegekraft13.transitionOutDis[i]);
      connect(station.PersonalIn[26*AnzahlSchichten+i], pflegekraft14.transitionOutDis[i]);
      connect(station.PersonalIn[28*AnzahlSchichten+i], pflegekraft15.transitionOutDis[i]);
      connect(station.PersonalIn[30*AnzahlSchichten+i], pflegekraft16.transitionOutDis[i]);
      connect(station.PersonalIn[32*AnzahlSchichten+i], pflegekraft17.transitionOutDis[i]);
      connect(station.PersonalIn[34*AnzahlSchichten+i], pflegekraft18.transitionOutDis[i]);
      connect(station.PersonalIn[36*AnzahlSchichten+i], pflegekraft19.transitionOutDis[i]);
      connect(station.PersonalIn[38*AnzahlSchichten+i], pflegekraft20.transitionOutDis[i]);
      connect(station.PersonalIn[40*AnzahlSchichten+i], pflegekraft21.transitionOutDis[i]);
      connect(station.PersonalIn[42*AnzahlSchichten+i], pflegekraft22.transitionOutDis[i]);
      connect(station.PersonalIn[44*AnzahlSchichten+i], pflegekraft23.transitionOutDis[i]);
      connect(station.PersonalIn[46*AnzahlSchichten+i], pflegekraft24.transitionOutDis[i]);
      connect(station.PersonalIn[48*AnzahlSchichten+i], pflegekraft25.transitionOutDis[i]);
      connect(station.PersonalIn[50*AnzahlSchichten+i], pflegekraft26.transitionOutDis[i]);
      connect(station.PersonalIn[52*AnzahlSchichten+i], pflegekraft27.transitionOutDis[i]);
      connect(station.PersonalIn[54*AnzahlSchichten+i], pflegekraft28.transitionOutDis[i]);
      connect(station.PersonalIn[56*AnzahlSchichten+i], pflegekraft29.transitionOutDis[i]);
      connect(station.PersonalIn[58*AnzahlSchichten+i], pflegekraft30.transitionOutDis[i]);
      connect(station.PersonalIn[60*AnzahlSchichten+i], pflegekraft31.transitionOutDis[i]);
      connect(station.PersonalIn[62*AnzahlSchichten+i], pflegekraft32.transitionOutDis[i]);
      connect(station.PersonalIn[64*AnzahlSchichten+i], pflegekraft33.transitionOutDis[i]);
      connect(station.PersonalIn[66*AnzahlSchichten+i], pflegekraft34.transitionOutDis[i]);
      connect(station.PersonalIn[68*AnzahlSchichten+i], pflegekraft35.transitionOutDis[i]);
      connect(station.PersonalIn[70*AnzahlSchichten+i], pflegekraft36.transitionOutDis[i]);
      connect(station.PersonalIn[72*AnzahlSchichten+i], pflegekraft37.transitionOutDis[i]);
      connect(station.PersonalIn[74*AnzahlSchichten+i], pflegekraft38.transitionOutDis[i]);
      connect(station.PersonalIn[76*AnzahlSchichten+i], pflegekraft39.transitionOutDis[i]);
      connect(station.PersonalIn[78*AnzahlSchichten+i], pflegekraft40.transitionOutDis[i]);
      connect(station.PersonalIn[80*AnzahlSchichten+i], pflegekraft41.transitionOutDis[i]);
      connect(station.PersonalIn[82*AnzahlSchichten+i], pflegekraft42.transitionOutDis[i]);
      connect(station.PersonalIn[84*AnzahlSchichten+i], pflegekraft43.transitionOutDis[i]);
      connect(station.PersonalIn[86*AnzahlSchichten+i], pflegekraft44.transitionOutDis[i]);
      connect(station.PersonalIn[88*AnzahlSchichten+i], pflegekraft45.transitionOutDis[i]);
      connect(station.PersonalIn[90*AnzahlSchichten+i], pflegekraft46.transitionOutDis[i]);
      connect(station.PersonalIn[92*AnzahlSchichten+i], pflegekraft47.transitionOutDis[i]);
      connect(station.PersonalIn[94*AnzahlSchichten+i], pflegekraft48.transitionOutDis[i]);
      connect(station.PersonalIn[96*AnzahlSchichten+i], pflegekraft49.transitionOutDis[i]);
      connect(station.PersonalIn[98*AnzahlSchichten+i], pflegekraft50.transitionOutDis[i]);


      connect(station.PersonalOut[i], pflegekraft1.transitionInDis[i]);
      connect(station.PersonalOut[2*AnzahlSchichten+i], pflegekraft2.transitionInDis[i]);
      connect(station.PersonalOut[4*AnzahlSchichten+i], pflegekraft3.transitionInDis[i]);
      connect(station.PersonalOut[6*AnzahlSchichten+i], pflegekraft4.transitionInDis[i]);
      connect(station.PersonalOut[8*AnzahlSchichten+i], pflegekraft5.transitionInDis[i]);
      connect(station.PersonalOut[10*AnzahlSchichten+i], pflegekraft6.transitionInDis[i]);
      connect(station.PersonalOut[12*AnzahlSchichten+i], pflegekraft7.transitionInDis[i]);
      connect(station.PersonalOut[14*AnzahlSchichten+i], pflegekraft8.transitionInDis[i]);
      connect(station.PersonalOut[16*AnzahlSchichten+i], pflegekraft9.transitionInDis[i]);
      connect(station.PersonalOut[18*AnzahlSchichten+i], pflegekraft10.transitionInDis[i]);
      connect(station.PersonalOut[20*AnzahlSchichten+i], pflegekraft11.transitionInDis[i]);
      connect(station.PersonalOut[22*AnzahlSchichten+i], pflegekraft12.transitionInDis[i]);
      connect(station.PersonalOut[24*AnzahlSchichten+i], pflegekraft13.transitionInDis[i]);
      connect(station.PersonalOut[26*AnzahlSchichten+i], pflegekraft14.transitionInDis[i]);
      connect(station.PersonalOut[28*AnzahlSchichten+i], pflegekraft15.transitionInDis[i]);
      connect(station.PersonalOut[30*AnzahlSchichten+i], pflegekraft16.transitionInDis[i]);
      connect(station.PersonalOut[32*AnzahlSchichten+i], pflegekraft17.transitionInDis[i]);
      connect(station.PersonalOut[34*AnzahlSchichten+i], pflegekraft18.transitionInDis[i]);
      connect(station.PersonalOut[36*AnzahlSchichten+i], pflegekraft19.transitionInDis[i]);
      connect(station.PersonalOut[38*AnzahlSchichten+i], pflegekraft20.transitionInDis[i]);
      connect(station.PersonalOut[40*AnzahlSchichten+i], pflegekraft21.transitionInDis[i]);
      connect(station.PersonalOut[42*AnzahlSchichten+i], pflegekraft22.transitionInDis[i]);
      connect(station.PersonalOut[44*AnzahlSchichten+i], pflegekraft23.transitionInDis[i]);
      connect(station.PersonalOut[46*AnzahlSchichten+i], pflegekraft24.transitionInDis[i]);
      connect(station.PersonalOut[48*AnzahlSchichten+i], pflegekraft25.transitionInDis[i]);
      connect(station.PersonalOut[50*AnzahlSchichten+i], pflegekraft26.transitionInDis[i]);
      connect(station.PersonalOut[52*AnzahlSchichten+i], pflegekraft27.transitionInDis[i]);
      connect(station.PersonalOut[54*AnzahlSchichten+i], pflegekraft28.transitionInDis[i]);
      connect(station.PersonalOut[56*AnzahlSchichten+i], pflegekraft29.transitionInDis[i]);
      connect(station.PersonalOut[58*AnzahlSchichten+i], pflegekraft30.transitionInDis[i]);
      connect(station.PersonalOut[60*AnzahlSchichten+i], pflegekraft31.transitionInDis[i]);
      connect(station.PersonalOut[62*AnzahlSchichten+i], pflegekraft32.transitionInDis[i]);
      connect(station.PersonalOut[64*AnzahlSchichten+i], pflegekraft33.transitionInDis[i]);
      connect(station.PersonalOut[66*AnzahlSchichten+i], pflegekraft34.transitionInDis[i]);
      connect(station.PersonalOut[68*AnzahlSchichten+i], pflegekraft35.transitionInDis[i]);
      connect(station.PersonalOut[70*AnzahlSchichten+i], pflegekraft36.transitionInDis[i]);
      connect(station.PersonalOut[72*AnzahlSchichten+i], pflegekraft37.transitionInDis[i]);
      connect(station.PersonalOut[74*AnzahlSchichten+i], pflegekraft38.transitionInDis[i]);
      connect(station.PersonalOut[76*AnzahlSchichten+i], pflegekraft39.transitionInDis[i]);
      connect(station.PersonalOut[78*AnzahlSchichten+i], pflegekraft40.transitionInDis[i]);
      connect(station.PersonalOut[80*AnzahlSchichten+i], pflegekraft41.transitionInDis[i]);
      connect(station.PersonalOut[82*AnzahlSchichten+i], pflegekraft42.transitionInDis[i]);
      connect(station.PersonalOut[84*AnzahlSchichten+i], pflegekraft43.transitionInDis[i]);
      connect(station.PersonalOut[86*AnzahlSchichten+i], pflegekraft44.transitionInDis[i]);
      connect(station.PersonalOut[88*AnzahlSchichten+i], pflegekraft45.transitionInDis[i]);
      connect(station.PersonalOut[90*AnzahlSchichten+i], pflegekraft46.transitionInDis[i]);
      connect(station.PersonalOut[92*AnzahlSchichten+i], pflegekraft47.transitionInDis[i]);
      connect(station.PersonalOut[94*AnzahlSchichten+i], pflegekraft48.transitionInDis[i]);
      connect(station.PersonalOut[96*AnzahlSchichten+i], pflegekraft49.transitionInDis[i]);
      connect(station.PersonalOut[98*AnzahlSchichten+i], pflegekraft50.transitionInDis[i]);
  end for annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-400, -400}, {400, 400}}, initialScale = 0.1)),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})));
//////////////////////////////////////////////////////////////////////////////
/*,
    experiment(StartTime = 0, StopTime = 365, Tolerance = 1e-06)*/
end TestStationUrlaubRandom;
