within FiliP.ModellStationen;

model TestStationDoppel
  extends Modelica.Icons.Example;

protected
  //Strucktur veraendernde Variablen
  parameter Integer AnzahlStation1Personal = 3;
  parameter Integer AnzahlStation2Personal = 3;
  parameter Integer AnzahlSchichten1 = 3;
  parameter Integer AnzahlSchichten2 = 3;
  parameter Integer SchichtHatPOOL[:] = {0, 0, 0, 0, 0, 0};
  // Nicht Strucktur veraendernde Variablen
  // 1 Start Fenster "sonstiges"
  // Pool?, EinSpringen?, Defizit
  parameter Real MessZeit[3] = {0.1, 0.2, 0.3};
  parameter Real MessSchwellen[5] = {0.5, 0.4, 0.3, 0.2, 0.1};
  parameter Boolean NichtWochenEnde1[50]={false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false};
  parameter Boolean NichtWochenEnde2[50]={false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false};
  parameter Integer MonatEnde[12] = {31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365};
  // Ende Fenster "sonstiges"
  // Start Fenster Station
  parameter Real VKstundenWoche = 38.5;
  // Schicht Start, Schicht Dauer, Schicht Pause Dauer
  parameter Real Schichtzeiten1[:, 3] = {{6, 8.2, 0.5}, {14, 8.2, 0.5}, {20.25, 10, 0.75}, {10, 8.2, 0.5}, {8, 8.2, 0.5}, {16, 8.2, 0.5}};
  parameter Real Schichtzeiten2[:, 3] = {{6, 8.2, 0.5}, {14, 8.2, 0.5}, {20.25, 10, 0.75}, {10, 8.2, 0.5}, {8, 8.2, 0.5}, {16, 8.2, 0.5}};
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
  parameter Integer SollBesetzung1[:, 7] = {{4, 4, 4, 4, 4, 3, 3},
                                           {4, 4, 4, 4, 4, 3, 3},
                                           {1, 1, 1, 1, 1, 1, 1},
                                           {1, 1, 1, 1, 1, 1, 1},
                                           {1, 1, 1, 1, 1, 1, 1},
                                           {1, 1, 1, 1, 1, 1, 1}};
 parameter Integer SollBesetzung2[:, 7] = {{4, 4, 4, 4, 4, 3, 3},
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
  parameter Real PersonalDaten1 [:,7]= {{1,6,2,14,26,13,14},
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
  parameter Real PersonalDaten2 [:,7]= {{1,6,2,14,26,13,14},
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

  parameter Boolean KannInSchichtArbeiten1 [:,6]={{true,true,true,true,true,true},
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
parameter Boolean KannInSchichtArbeiten2 [:,6]={{true,true,true,true,true,true},
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
parameter Boolean SpringtEinInSchicht1 [:,6]={{true,true,true,true,true,true},
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
  parameter Boolean SpringtEinInSchicht2 [:,6]={{true,true,true,true,true,true},
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

  parameter Integer AnzahlUrlaubsWochen1[50]={6,6,6,4,3,1,6,6,6,5,4,0,0,0,0,6,6,6,6,6,6,6,6,6,6,6,6,4,3,1,6,6,6,5,4,0,0,0,0,6,6,6,6,6,6,6,6,6,6,6};
  parameter Integer AnzahlUrlaubsWochen2[50]={6,6,6,4,3,1,6,6,6,5,4,0,0,0,0,6,6,6,6,6,6,6,6,6,6,6,6,4,3,1,6,6,6,5,4,0,0,0,0,6,6,6,6,6,6,6,6,6,6,6};
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
  FiliP.Station station1(nP = AnzahlStation1Personal, AnzahlSchichten = AnzahlSchichten1, SollBesetzung = SollBesetzung1, SollBelastung = SollBelastung, PlanKorrektur = PlanKorrektur, a = SchwankungFallgewichtMin, b = SchwankungFallgewichtMax, c = SchwankungFallgewichtMeist, StartTag = StartTag, Schichtzeiten = Schichtzeiten1[:, 1:2], MessZeit = MessZeit, MessSchwellen = MessSchwellen, SchichtHatPOOL = SchichtHatPOOL, PoolWkeit = PoolWkeit) annotation(
    Placement(visible = true, transformation(extent = {{-20, 20}, {20, 60}}, rotation = 0)));
    FiliP.PflegekraftUrlaubRandom pflegekraft1(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2], VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[1,1], StartWochenEnde = PersonalDaten1[1,2], DauerWochenEnde = PersonalDaten1[1,3], IntervallWochenEnde = PersonalDaten1[1,4], IntervallNichtWochenEnde = PersonalDaten1[1,7], NichtWochenEnde = NichtWochenEnde1[1], StartNichtWochenEnde = PersonalDaten1[1,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[1,:], SpringtEinInSchicht=SpringtEinInSchicht1[1,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[1]) annotation (
         Placement(visible = true, transformation(extent = {{-60, -80}, {0, -20}}, rotation = 0)));
    FiliP.PflegekraftUrlaubRandom pflegekraft2(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[2,1], StartWochenEnde = PersonalDaten1[2,2], DauerWochenEnde = PersonalDaten1[2,3], IntervallWochenEnde = PersonalDaten1[2,4], IntervallNichtWochenEnde = PersonalDaten1[2,7], NichtWochenEnde = NichtWochenEnde1[2], StartNichtWochenEnde = PersonalDaten1[2,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[2,:], SpringtEinInSchicht=SpringtEinInSchicht1[2,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[2]) if AnzahlStation1Personal >1;
    FiliP.PflegekraftUrlaubRandom pflegekraft3(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[3,1], StartWochenEnde = PersonalDaten1[3,2], DauerWochenEnde = PersonalDaten1[3,3], IntervallWochenEnde = PersonalDaten1[3,4], IntervallNichtWochenEnde = PersonalDaten1[3,7], NichtWochenEnde = NichtWochenEnde1[3], StartNichtWochenEnde = PersonalDaten1[3,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[3,:], SpringtEinInSchicht=SpringtEinInSchicht1[3,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[3]) if AnzahlStation1Personal >2;
    FiliP.PflegekraftUrlaubRandom pflegekraft4(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[4,1], StartWochenEnde = PersonalDaten1[4,2], DauerWochenEnde = PersonalDaten1[4,3], IntervallWochenEnde = PersonalDaten1[4,4], IntervallNichtWochenEnde = PersonalDaten1[4,7], NichtWochenEnde = NichtWochenEnde1[4], StartNichtWochenEnde = PersonalDaten1[4,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[4,:], SpringtEinInSchicht=SpringtEinInSchicht1[4,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[4]) if AnzahlStation1Personal >3;
    FiliP.PflegekraftUrlaubRandom pflegekraft5(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[5,1], StartWochenEnde = PersonalDaten1[5,2], DauerWochenEnde = PersonalDaten1[5,3], IntervallWochenEnde = PersonalDaten1[5,4], IntervallNichtWochenEnde = PersonalDaten1[5,7], NichtWochenEnde = NichtWochenEnde1[5], StartNichtWochenEnde = PersonalDaten1[5,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[5,:], SpringtEinInSchicht=SpringtEinInSchicht1[5,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[5]) if AnzahlStation1Personal >4;
    FiliP.PflegekraftUrlaubRandom pflegekraft6(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[6,1], StartWochenEnde = PersonalDaten1[6,2], DauerWochenEnde = PersonalDaten1[6,3], IntervallWochenEnde = PersonalDaten1[6,4], IntervallNichtWochenEnde = PersonalDaten1[6,7], NichtWochenEnde = NichtWochenEnde1[6], StartNichtWochenEnde = PersonalDaten1[6,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[6,:], SpringtEinInSchicht=SpringtEinInSchicht1[6,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[6]) if AnzahlStation1Personal >5;
    FiliP.PflegekraftUrlaubRandom pflegekraft7(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[7,1], StartWochenEnde = PersonalDaten1[7,2], DauerWochenEnde = PersonalDaten1[7,3], IntervallWochenEnde = PersonalDaten1[7,4], IntervallNichtWochenEnde = PersonalDaten1[7,7], NichtWochenEnde = NichtWochenEnde1[7], StartNichtWochenEnde = PersonalDaten1[7,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[7,:], SpringtEinInSchicht=SpringtEinInSchicht1[7,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[7]) if AnzahlStation1Personal >6;
    FiliP.PflegekraftUrlaubRandom pflegekraft8(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[8,1], StartWochenEnde = PersonalDaten1[8,2], DauerWochenEnde = PersonalDaten1[8,3], IntervallWochenEnde = PersonalDaten1[8,4], IntervallNichtWochenEnde = PersonalDaten1[8,7], NichtWochenEnde = NichtWochenEnde1[8], StartNichtWochenEnde = PersonalDaten1[8,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[8,:], SpringtEinInSchicht=SpringtEinInSchicht1[8,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[8]) if AnzahlStation1Personal >7;
    //
    FiliP.PflegekraftUrlaubRandom pflegekraft9(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[9,1], StartWochenEnde = PersonalDaten1[9,2], DauerWochenEnde = PersonalDaten1[9,3], IntervallWochenEnde = PersonalDaten1[9,4], IntervallNichtWochenEnde = PersonalDaten1[9,7], NichtWochenEnde = NichtWochenEnde1[9], StartNichtWochenEnde = PersonalDaten1[9,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[9,:], SpringtEinInSchicht=SpringtEinInSchicht1[9,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[9]) if AnzahlStation1Personal >8;
    FiliP.PflegekraftUrlaubRandom pflegekraft10(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[10,1], StartWochenEnde = PersonalDaten1[10,2], DauerWochenEnde = PersonalDaten1[10,3], IntervallWochenEnde = PersonalDaten1[10,4], IntervallNichtWochenEnde = PersonalDaten1[10,7], NichtWochenEnde = NichtWochenEnde1[10], StartNichtWochenEnde = PersonalDaten1[10,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[10,:], SpringtEinInSchicht=SpringtEinInSchicht1[10,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[10]) if AnzahlStation1Personal >9;
    FiliP.PflegekraftUrlaubRandom pflegekraft11(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[11,1], StartWochenEnde = PersonalDaten1[11,2], DauerWochenEnde = PersonalDaten1[11,3], IntervallWochenEnde = PersonalDaten1[11,4], IntervallNichtWochenEnde = PersonalDaten1[11,7], NichtWochenEnde = NichtWochenEnde1[11], StartNichtWochenEnde = PersonalDaten1[11,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[11,:], SpringtEinInSchicht=SpringtEinInSchicht1[11,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[11]) if AnzahlStation1Personal >10;
    FiliP.PflegekraftUrlaubRandom pflegekraft12(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[12,1], StartWochenEnde = PersonalDaten1[12,2], DauerWochenEnde = PersonalDaten1[12,3], IntervallWochenEnde = PersonalDaten1[12,4], IntervallNichtWochenEnde = PersonalDaten1[12,7], NichtWochenEnde = NichtWochenEnde1[12], StartNichtWochenEnde = PersonalDaten1[12,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[12,:], SpringtEinInSchicht=SpringtEinInSchicht1[12,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[12]) if AnzahlStation1Personal >11;
    FiliP.PflegekraftUrlaubRandom pflegekraft13(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[13,1], StartWochenEnde = PersonalDaten1[13,2], DauerWochenEnde = PersonalDaten1[13,3], IntervallWochenEnde = PersonalDaten1[13,4], IntervallNichtWochenEnde = PersonalDaten1[13,7], NichtWochenEnde = NichtWochenEnde1[13], StartNichtWochenEnde = PersonalDaten1[13,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[13,:], SpringtEinInSchicht=SpringtEinInSchicht1[13,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[13]) if AnzahlStation1Personal >12;
    FiliP.PflegekraftUrlaubRandom pflegekraft14(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[14,1], StartWochenEnde = PersonalDaten1[14,2], DauerWochenEnde = PersonalDaten1[14,3], IntervallWochenEnde = PersonalDaten1[14,4], IntervallNichtWochenEnde = PersonalDaten1[14,7], NichtWochenEnde = NichtWochenEnde1[14], StartNichtWochenEnde = PersonalDaten1[14,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[14,:], SpringtEinInSchicht=SpringtEinInSchicht1[14,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[14]) if AnzahlStation1Personal >13;
    FiliP.PflegekraftUrlaubRandom pflegekraft15(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[15,1], StartWochenEnde = PersonalDaten1[15,2], DauerWochenEnde = PersonalDaten1[15,3], IntervallWochenEnde = PersonalDaten1[15,4], IntervallNichtWochenEnde = PersonalDaten1[15,7], NichtWochenEnde = NichtWochenEnde1[15], StartNichtWochenEnde = PersonalDaten1[15,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[15,:], SpringtEinInSchicht=SpringtEinInSchicht1[15,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[15]) if AnzahlStation1Personal >14;
    FiliP.PflegekraftUrlaubRandom pflegekraft16(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[16,1], StartWochenEnde = PersonalDaten1[16,2], DauerWochenEnde = PersonalDaten1[16,3], IntervallWochenEnde = PersonalDaten1[16,4], IntervallNichtWochenEnde = PersonalDaten1[16,7], NichtWochenEnde = NichtWochenEnde1[16], StartNichtWochenEnde = PersonalDaten1[16,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[16,:], SpringtEinInSchicht=SpringtEinInSchicht1[16,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[16]) if AnzahlStation1Personal >15;
    //
    FiliP.PflegekraftUrlaubRandom pflegekraft17(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[17,1], StartWochenEnde = PersonalDaten1[17,2], DauerWochenEnde = PersonalDaten1[17,3], IntervallWochenEnde = PersonalDaten1[17,4], IntervallNichtWochenEnde = PersonalDaten1[17,7], NichtWochenEnde = NichtWochenEnde1[17], StartNichtWochenEnde = PersonalDaten1[17,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[17,:], SpringtEinInSchicht=SpringtEinInSchicht1[17,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[17]) if AnzahlStation1Personal >16;
    FiliP.PflegekraftUrlaubRandom pflegekraft18(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[18,1], StartWochenEnde = PersonalDaten1[18,2], DauerWochenEnde = PersonalDaten1[18,3], IntervallWochenEnde = PersonalDaten1[18,4], IntervallNichtWochenEnde = PersonalDaten1[18,7], NichtWochenEnde = NichtWochenEnde1[18], StartNichtWochenEnde = PersonalDaten1[18,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[18,:], SpringtEinInSchicht=SpringtEinInSchicht1[18,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[18]) if AnzahlStation1Personal >17;
    FiliP.PflegekraftUrlaubRandom pflegekraft19(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[19,1], StartWochenEnde = PersonalDaten1[19,2], DauerWochenEnde = PersonalDaten1[19,3], IntervallWochenEnde = PersonalDaten1[19,4], IntervallNichtWochenEnde = PersonalDaten1[19,7], NichtWochenEnde = NichtWochenEnde1[19], StartNichtWochenEnde = PersonalDaten1[19,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[19,:], SpringtEinInSchicht=SpringtEinInSchicht1[19,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[19]) if AnzahlStation1Personal >18;
    FiliP.PflegekraftUrlaubRandom pflegekraft20(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[20,1], StartWochenEnde = PersonalDaten1[20,2], DauerWochenEnde = PersonalDaten1[20,3], IntervallWochenEnde = PersonalDaten1[20,4], IntervallNichtWochenEnde = PersonalDaten1[20,7], NichtWochenEnde = NichtWochenEnde1[20], StartNichtWochenEnde = PersonalDaten1[20,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[20,:], SpringtEinInSchicht=SpringtEinInSchicht1[20,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[20]) if AnzahlStation1Personal >19;
    FiliP.PflegekraftUrlaubRandom pflegekraft21(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[21,1], StartWochenEnde = PersonalDaten1[21,2], DauerWochenEnde = PersonalDaten1[21,3], IntervallWochenEnde = PersonalDaten1[21,4], IntervallNichtWochenEnde = PersonalDaten1[21,7], NichtWochenEnde = NichtWochenEnde1[21], StartNichtWochenEnde = PersonalDaten1[21,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[21,:], SpringtEinInSchicht=SpringtEinInSchicht1[21,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[21]) if AnzahlStation1Personal >20;
    FiliP.PflegekraftUrlaubRandom pflegekraft22(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[22,1], StartWochenEnde = PersonalDaten1[22,2], DauerWochenEnde = PersonalDaten1[22,3], IntervallWochenEnde = PersonalDaten1[22,4], IntervallNichtWochenEnde = PersonalDaten1[22,7], NichtWochenEnde = NichtWochenEnde1[22], StartNichtWochenEnde = PersonalDaten1[22,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[22,:], SpringtEinInSchicht=SpringtEinInSchicht1[22,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[22]) if AnzahlStation1Personal >21;
    FiliP.PflegekraftUrlaubRandom pflegekraft23(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[23,1], StartWochenEnde = PersonalDaten1[23,2], DauerWochenEnde = PersonalDaten1[23,3], IntervallWochenEnde = PersonalDaten1[23,4], IntervallNichtWochenEnde = PersonalDaten1[23,7], NichtWochenEnde = NichtWochenEnde1[23], StartNichtWochenEnde = PersonalDaten1[23,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[23,:], SpringtEinInSchicht=SpringtEinInSchicht1[23,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[23]) if AnzahlStation1Personal >22;
    FiliP.PflegekraftUrlaubRandom pflegekraft24(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[24,1], StartWochenEnde = PersonalDaten1[24,2], DauerWochenEnde = PersonalDaten1[24,3], IntervallWochenEnde = PersonalDaten1[24,4], IntervallNichtWochenEnde = PersonalDaten1[24,7], NichtWochenEnde = NichtWochenEnde1[24], StartNichtWochenEnde = PersonalDaten1[24,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[24,:], SpringtEinInSchicht=SpringtEinInSchicht1[24,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[24]) if AnzahlStation1Personal >23;
    //
    FiliP.PflegekraftUrlaubRandom pflegekraft25(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[25,1], StartWochenEnde = PersonalDaten1[25,2], DauerWochenEnde = PersonalDaten1[25,3], IntervallWochenEnde = PersonalDaten1[25,4], IntervallNichtWochenEnde = PersonalDaten1[25,7], NichtWochenEnde = NichtWochenEnde1[25], StartNichtWochenEnde = PersonalDaten1[25,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[25,:], SpringtEinInSchicht=SpringtEinInSchicht1[25,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[25]) if AnzahlStation1Personal >24;
    FiliP.PflegekraftUrlaubRandom pflegekraft26(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[26,1], StartWochenEnde = PersonalDaten1[26,2], DauerWochenEnde = PersonalDaten1[26,3], IntervallWochenEnde = PersonalDaten1[26,4], IntervallNichtWochenEnde = PersonalDaten1[26,7], NichtWochenEnde = NichtWochenEnde1[26], StartNichtWochenEnde = PersonalDaten1[26,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[26,:], SpringtEinInSchicht=SpringtEinInSchicht1[26,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[26]) if AnzahlStation1Personal >25;
    FiliP.PflegekraftUrlaubRandom pflegekraft27(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[27,1], StartWochenEnde = PersonalDaten1[27,2], DauerWochenEnde = PersonalDaten1[27,3], IntervallWochenEnde = PersonalDaten1[27,4], IntervallNichtWochenEnde = PersonalDaten1[27,7], NichtWochenEnde = NichtWochenEnde1[27], StartNichtWochenEnde = PersonalDaten1[27,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[27,:], SpringtEinInSchicht=SpringtEinInSchicht1[27,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[27]) if AnzahlStation1Personal >26;
    FiliP.PflegekraftUrlaubRandom pflegekraft28(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[28,1], StartWochenEnde = PersonalDaten1[28,2], DauerWochenEnde = PersonalDaten1[28,3], IntervallWochenEnde = PersonalDaten1[28,4], IntervallNichtWochenEnde = PersonalDaten1[28,7], NichtWochenEnde = NichtWochenEnde1[28], StartNichtWochenEnde = PersonalDaten1[28,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[28,:], SpringtEinInSchicht=SpringtEinInSchicht1[28,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[28]) if AnzahlStation1Personal >27;
    FiliP.PflegekraftUrlaubRandom pflegekraft29(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[29,1], StartWochenEnde = PersonalDaten1[29,2], DauerWochenEnde = PersonalDaten1[29,3], IntervallWochenEnde = PersonalDaten1[29,4], IntervallNichtWochenEnde = PersonalDaten1[29,7], NichtWochenEnde = NichtWochenEnde1[29], StartNichtWochenEnde = PersonalDaten1[29,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[29,:], SpringtEinInSchicht=SpringtEinInSchicht1[29,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[29]) if AnzahlStation1Personal >28;
    FiliP.PflegekraftUrlaubRandom pflegekraft30(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[30,1], StartWochenEnde = PersonalDaten1[30,2], DauerWochenEnde = PersonalDaten1[30,3], IntervallWochenEnde = PersonalDaten1[30,4], IntervallNichtWochenEnde = PersonalDaten1[30,7], NichtWochenEnde = NichtWochenEnde1[30], StartNichtWochenEnde = PersonalDaten1[30,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[30,:], SpringtEinInSchicht=SpringtEinInSchicht1[30,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[30]) if AnzahlStation1Personal >29;
    FiliP.PflegekraftUrlaubRandom pflegekraft31(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[31,1], StartWochenEnde = PersonalDaten1[31,2], DauerWochenEnde = PersonalDaten1[31,3], IntervallWochenEnde = PersonalDaten1[31,4], IntervallNichtWochenEnde = PersonalDaten1[31,7], NichtWochenEnde = NichtWochenEnde1[31], StartNichtWochenEnde = PersonalDaten1[31,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[31,:], SpringtEinInSchicht=SpringtEinInSchicht1[31,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[31]) if AnzahlStation1Personal >30;
    FiliP.PflegekraftUrlaubRandom pflegekraft32(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[32,1], StartWochenEnde = PersonalDaten1[32,2], DauerWochenEnde = PersonalDaten1[32,3], IntervallWochenEnde = PersonalDaten1[32,4], IntervallNichtWochenEnde = PersonalDaten1[32,7], NichtWochenEnde = NichtWochenEnde1[32], StartNichtWochenEnde = PersonalDaten1[32,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[32,:], SpringtEinInSchicht=SpringtEinInSchicht1[32,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[32]) if AnzahlStation1Personal >31;
    //
    FiliP.PflegekraftUrlaubRandom pflegekraft33(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[33,1], StartWochenEnde = PersonalDaten1[33,2], DauerWochenEnde = PersonalDaten1[33,3], IntervallWochenEnde = PersonalDaten1[33,4], IntervallNichtWochenEnde = PersonalDaten1[33,7], NichtWochenEnde = NichtWochenEnde1[33], StartNichtWochenEnde = PersonalDaten1[33,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[33,:], SpringtEinInSchicht=SpringtEinInSchicht1[33,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[33]) if AnzahlStation1Personal >32;
    FiliP.PflegekraftUrlaubRandom pflegekraft34(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[34,1], StartWochenEnde = PersonalDaten1[34,2], DauerWochenEnde = PersonalDaten1[34,3], IntervallWochenEnde = PersonalDaten1[34,4], IntervallNichtWochenEnde = PersonalDaten1[34,7], NichtWochenEnde = NichtWochenEnde1[34], StartNichtWochenEnde = PersonalDaten1[34,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[34,:], SpringtEinInSchicht=SpringtEinInSchicht1[34,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[34]) if AnzahlStation1Personal >33;
    FiliP.PflegekraftUrlaubRandom pflegekraft35(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[35,1], StartWochenEnde = PersonalDaten1[35,2], DauerWochenEnde = PersonalDaten1[35,3], IntervallWochenEnde = PersonalDaten1[35,4], IntervallNichtWochenEnde = PersonalDaten1[35,7], NichtWochenEnde = NichtWochenEnde1[35], StartNichtWochenEnde = PersonalDaten1[35,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[35,:], SpringtEinInSchicht=SpringtEinInSchicht1[35,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[35]) if AnzahlStation1Personal >34;
    FiliP.PflegekraftUrlaubRandom pflegekraft36(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[36,1], StartWochenEnde = PersonalDaten1[36,2], DauerWochenEnde = PersonalDaten1[36,3], IntervallWochenEnde = PersonalDaten1[36,4], IntervallNichtWochenEnde = PersonalDaten1[36,7], NichtWochenEnde = NichtWochenEnde1[36], StartNichtWochenEnde = PersonalDaten1[36,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[36,:], SpringtEinInSchicht=SpringtEinInSchicht1[36,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[36]) if AnzahlStation1Personal >35;
    FiliP.PflegekraftUrlaubRandom pflegekraft37(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[37,1], StartWochenEnde = PersonalDaten1[37,2], DauerWochenEnde = PersonalDaten1[37,3], IntervallWochenEnde = PersonalDaten1[37,4], IntervallNichtWochenEnde = PersonalDaten1[37,7], NichtWochenEnde = NichtWochenEnde1[37], StartNichtWochenEnde = PersonalDaten1[37,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[37,:], SpringtEinInSchicht=SpringtEinInSchicht1[37,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[37]) if AnzahlStation1Personal >36;
    FiliP.PflegekraftUrlaubRandom pflegekraft38(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[38,1], StartWochenEnde = PersonalDaten1[38,2], DauerWochenEnde = PersonalDaten1[38,3], IntervallWochenEnde = PersonalDaten1[38,4], IntervallNichtWochenEnde = PersonalDaten1[38,7], NichtWochenEnde = NichtWochenEnde1[38], StartNichtWochenEnde = PersonalDaten1[38,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[38,:], SpringtEinInSchicht=SpringtEinInSchicht1[38,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[38]) if AnzahlStation1Personal >37;
    FiliP.PflegekraftUrlaubRandom pflegekraft39(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[39,1], StartWochenEnde = PersonalDaten1[39,2], DauerWochenEnde = PersonalDaten1[39,3], IntervallWochenEnde = PersonalDaten1[39,4], IntervallNichtWochenEnde = PersonalDaten1[39,7], NichtWochenEnde = NichtWochenEnde1[39], StartNichtWochenEnde = PersonalDaten1[39,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[39,:], SpringtEinInSchicht=SpringtEinInSchicht1[39,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[39]) if AnzahlStation1Personal >38;
    FiliP.PflegekraftUrlaubRandom pflegekraft40(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[40,1], StartWochenEnde = PersonalDaten1[40,2], DauerWochenEnde = PersonalDaten1[40,3], IntervallWochenEnde = PersonalDaten1[40,4], IntervallNichtWochenEnde = PersonalDaten1[40,7], NichtWochenEnde = NichtWochenEnde1[40], StartNichtWochenEnde = PersonalDaten1[40,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[40,:], SpringtEinInSchicht=SpringtEinInSchicht1[40,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[40]) if AnzahlStation1Personal >39;
    //
    FiliP.PflegekraftUrlaubRandom pflegekraft41(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[41,1], StartWochenEnde = PersonalDaten1[41,2], DauerWochenEnde = PersonalDaten1[41,3], IntervallWochenEnde = PersonalDaten1[41,4], IntervallNichtWochenEnde = PersonalDaten1[41,7], NichtWochenEnde = NichtWochenEnde1[41], StartNichtWochenEnde = PersonalDaten1[41,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[41,:], SpringtEinInSchicht=SpringtEinInSchicht1[41,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[41]) if AnzahlStation1Personal >40;
    FiliP.PflegekraftUrlaubRandom pflegekraft42(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[42,1], StartWochenEnde = PersonalDaten1[42,2], DauerWochenEnde = PersonalDaten1[42,3], IntervallWochenEnde = PersonalDaten1[42,4], IntervallNichtWochenEnde = PersonalDaten1[42,7], NichtWochenEnde = NichtWochenEnde1[42], StartNichtWochenEnde = PersonalDaten1[42,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[42,:], SpringtEinInSchicht=SpringtEinInSchicht1[42,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[42]) if AnzahlStation1Personal >41;
    FiliP.PflegekraftUrlaubRandom pflegekraft43(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[43,1], StartWochenEnde = PersonalDaten1[43,2], DauerWochenEnde = PersonalDaten1[43,3], IntervallWochenEnde = PersonalDaten1[43,4], IntervallNichtWochenEnde = PersonalDaten1[43,7], NichtWochenEnde = NichtWochenEnde1[43], StartNichtWochenEnde = PersonalDaten1[43,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[43,:], SpringtEinInSchicht=SpringtEinInSchicht1[43,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[43]) if AnzahlStation1Personal >42;
    FiliP.PflegekraftUrlaubRandom pflegekraft44(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[44,1], StartWochenEnde = PersonalDaten1[44,2], DauerWochenEnde = PersonalDaten1[44,3], IntervallWochenEnde = PersonalDaten1[44,4], IntervallNichtWochenEnde = PersonalDaten1[44,7], NichtWochenEnde = NichtWochenEnde1[44], StartNichtWochenEnde = PersonalDaten1[44,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[44,:], SpringtEinInSchicht=SpringtEinInSchicht1[44,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[44]) if AnzahlStation1Personal >43;
    FiliP.PflegekraftUrlaubRandom pflegekraft45(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[45,1], StartWochenEnde = PersonalDaten1[45,2], DauerWochenEnde = PersonalDaten1[45,3], IntervallWochenEnde = PersonalDaten1[45,4], IntervallNichtWochenEnde = PersonalDaten1[45,7], NichtWochenEnde = NichtWochenEnde1[45], StartNichtWochenEnde = PersonalDaten1[45,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[45,:], SpringtEinInSchicht=SpringtEinInSchicht1[45,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[45]) if AnzahlStation1Personal >44;
    FiliP.PflegekraftUrlaubRandom pflegekraft46(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[46,1], StartWochenEnde = PersonalDaten1[46,2], DauerWochenEnde = PersonalDaten1[46,3], IntervallWochenEnde = PersonalDaten1[46,4], IntervallNichtWochenEnde = PersonalDaten1[46,7], NichtWochenEnde = NichtWochenEnde1[46], StartNichtWochenEnde = PersonalDaten1[46,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[46,:], SpringtEinInSchicht=SpringtEinInSchicht1[46,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[46]) if AnzahlStation1Personal >45;
    FiliP.PflegekraftUrlaubRandom pflegekraft47(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[47,1], StartWochenEnde = PersonalDaten1[47,2], DauerWochenEnde = PersonalDaten1[47,3], IntervallWochenEnde = PersonalDaten1[47,4], IntervallNichtWochenEnde = PersonalDaten1[47,7], NichtWochenEnde = NichtWochenEnde1[47], StartNichtWochenEnde = PersonalDaten1[47,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[47,:], SpringtEinInSchicht=SpringtEinInSchicht1[47,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[47]) if AnzahlStation1Personal >46;
    FiliP.PflegekraftUrlaubRandom pflegekraft48(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[48,1], StartWochenEnde = PersonalDaten1[48,2], DauerWochenEnde = PersonalDaten1[48,3], IntervallWochenEnde = PersonalDaten1[48,4], IntervallNichtWochenEnde = PersonalDaten1[48,7], NichtWochenEnde = NichtWochenEnde1[48], StartNichtWochenEnde = PersonalDaten1[48,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[48,:], SpringtEinInSchicht=SpringtEinInSchicht1[48,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[48]) if AnzahlStation1Personal >47;
    //
    FiliP.PflegekraftUrlaubRandom pflegekraft49(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[49,1], StartWochenEnde = PersonalDaten1[49,2], DauerWochenEnde = PersonalDaten1[49,3], IntervallWochenEnde = PersonalDaten1[49,4], IntervallNichtWochenEnde = PersonalDaten1[49,7], NichtWochenEnde = NichtWochenEnde1[49], StartNichtWochenEnde = PersonalDaten1[49,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[49,:], SpringtEinInSchicht=SpringtEinInSchicht1[49,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[49]) if AnzahlStation1Personal >48;
    FiliP.PflegekraftUrlaubRandom pflegekraft50(AnzahlSchichten=AnzahlSchichten1, Schichtzeiten=Schichtzeiten1, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten1[50,1], StartWochenEnde = PersonalDaten1[50,2], DauerWochenEnde = PersonalDaten1[50,3], IntervallWochenEnde = PersonalDaten1[50,4], IntervallNichtWochenEnde = PersonalDaten1[50,7], NichtWochenEnde = NichtWochenEnde1[50], StartNichtWochenEnde = PersonalDaten1[50,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[50,:], SpringtEinInSchicht=SpringtEinInSchicht1[50,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen1[50]) if AnzahlStation1Personal >49;

//Station2

FiliP.Station station2(nP = AnzahlStation2Personal, AnzahlSchichten = AnzahlSchichten2, SollBesetzung = SollBesetzung2, SollBelastung = SollBelastung, PlanKorrektur = PlanKorrektur, a = SchwankungFallgewichtMin, b = SchwankungFallgewichtMax, c = SchwankungFallgewichtMeist, StartTag = StartTag, Schichtzeiten = Schichtzeiten2[:, 1:2], MessZeit = MessZeit, MessSchwellen = MessSchwellen, SchichtHatPOOL = SchichtHatPOOL, PoolWkeit = PoolWkeit) annotation(
  Placement(visible = true, transformation(extent = {{-20, 20}, {20, 60}}, rotation = 0)));
  FiliP.PflegekraftUrlaubRandom pflegekraftB1(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2], VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[1,1], StartWochenEnde = PersonalDaten2[1,2], DauerWochenEnde = PersonalDaten2[1,3], IntervallWochenEnde = PersonalDaten2[1,4], IntervallNichtWochenEnde = PersonalDaten2[1,7], NichtWochenEnde = NichtWochenEnde2[1], StartNichtWochenEnde = PersonalDaten2[1,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[1,:], SpringtEinInSchicht=SpringtEinInSchicht2[1,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[1]) annotation (
       Placement(visible = true, transformation(extent = {{-60, -80}, {0, -20}}, rotation = 0)));
  FiliP.PflegekraftUrlaubRandom pflegekraftB2(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[2,1], StartWochenEnde = PersonalDaten2[2,2], DauerWochenEnde = PersonalDaten2[2,3], IntervallWochenEnde = PersonalDaten2[2,4], IntervallNichtWochenEnde = PersonalDaten2[2,7], NichtWochenEnde = NichtWochenEnde2[2], StartNichtWochenEnde = PersonalDaten2[2,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[2,:], SpringtEinInSchicht=SpringtEinInSchicht2[2,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[2]) if AnzahlStation1Personal >1;
  FiliP.PflegekraftUrlaubRandom pflegekraftB3(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[3,1], StartWochenEnde = PersonalDaten2[3,2], DauerWochenEnde = PersonalDaten2[3,3], IntervallWochenEnde = PersonalDaten2[3,4], IntervallNichtWochenEnde = PersonalDaten2[3,7], NichtWochenEnde = NichtWochenEnde2[3], StartNichtWochenEnde = PersonalDaten2[3,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[3,:], SpringtEinInSchicht=SpringtEinInSchicht2[3,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[3]) if AnzahlStation1Personal >2;
  FiliP.PflegekraftUrlaubRandom pflegekraftB4(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[4,1], StartWochenEnde = PersonalDaten2[4,2], DauerWochenEnde = PersonalDaten2[4,3], IntervallWochenEnde = PersonalDaten2[4,4], IntervallNichtWochenEnde = PersonalDaten2[4,7], NichtWochenEnde = NichtWochenEnde2[4], StartNichtWochenEnde = PersonalDaten2[4,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[4,:], SpringtEinInSchicht=SpringtEinInSchicht2[4,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[4]) if AnzahlStation1Personal >3;
  FiliP.PflegekraftUrlaubRandom pflegekraftB5(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[5,1], StartWochenEnde = PersonalDaten2[5,2], DauerWochenEnde = PersonalDaten2[5,3], IntervallWochenEnde = PersonalDaten2[5,4], IntervallNichtWochenEnde = PersonalDaten2[5,7], NichtWochenEnde = NichtWochenEnde2[5], StartNichtWochenEnde = PersonalDaten2[5,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[5,:], SpringtEinInSchicht=SpringtEinInSchicht2[5,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[5]) if AnzahlStation1Personal >4;
  FiliP.PflegekraftUrlaubRandom pflegekraftB6(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[6,1], StartWochenEnde = PersonalDaten2[6,2], DauerWochenEnde = PersonalDaten2[6,3], IntervallWochenEnde = PersonalDaten2[6,4], IntervallNichtWochenEnde = PersonalDaten2[6,7], NichtWochenEnde = NichtWochenEnde2[6], StartNichtWochenEnde = PersonalDaten2[6,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[6,:], SpringtEinInSchicht=SpringtEinInSchicht2[6,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[6]) if AnzahlStation1Personal >5;
  FiliP.PflegekraftUrlaubRandom pflegekraftB7(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[7,1], StartWochenEnde = PersonalDaten2[7,2], DauerWochenEnde = PersonalDaten2[7,3], IntervallWochenEnde = PersonalDaten2[7,4], IntervallNichtWochenEnde = PersonalDaten2[7,7], NichtWochenEnde = NichtWochenEnde2[7], StartNichtWochenEnde = PersonalDaten2[7,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[7,:], SpringtEinInSchicht=SpringtEinInSchicht2[7,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[7]) if AnzahlStation1Personal >6;
  FiliP.PflegekraftUrlaubRandom pflegekraftB8(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[8,1], StartWochenEnde = PersonalDaten2[8,2], DauerWochenEnde = PersonalDaten2[8,3], IntervallWochenEnde = PersonalDaten2[8,4], IntervallNichtWochenEnde = PersonalDaten2[8,7], NichtWochenEnde = NichtWochenEnde2[8], StartNichtWochenEnde = PersonalDaten2[8,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[8,:], SpringtEinInSchicht=SpringtEinInSchicht2[8,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[8]) if AnzahlStation1Personal >7;
  //
  FiliP.PflegekraftUrlaubRandom pflegekraftB9(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[9,1], StartWochenEnde = PersonalDaten2[9,2], DauerWochenEnde = PersonalDaten2[9,3], IntervallWochenEnde = PersonalDaten2[9,4], IntervallNichtWochenEnde = PersonalDaten2[9,7], NichtWochenEnde = NichtWochenEnde2[9], StartNichtWochenEnde = PersonalDaten2[9,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[9,:], SpringtEinInSchicht=SpringtEinInSchicht2[9,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[9]) if AnzahlStation1Personal >8;
  FiliP.PflegekraftUrlaubRandom pflegekraftB10(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[10,1], StartWochenEnde = PersonalDaten2[10,2], DauerWochenEnde = PersonalDaten2[10,3], IntervallWochenEnde = PersonalDaten2[10,4], IntervallNichtWochenEnde = PersonalDaten2[10,7], NichtWochenEnde = NichtWochenEnde2[10], StartNichtWochenEnde = PersonalDaten2[10,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[10,:], SpringtEinInSchicht=SpringtEinInSchicht2[10,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[10]) if AnzahlStation1Personal >9;
  FiliP.PflegekraftUrlaubRandom pflegekraftB11(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[11,1], StartWochenEnde = PersonalDaten2[11,2], DauerWochenEnde = PersonalDaten2[11,3], IntervallWochenEnde = PersonalDaten2[11,4], IntervallNichtWochenEnde = PersonalDaten2[11,7], NichtWochenEnde = NichtWochenEnde2[11], StartNichtWochenEnde = PersonalDaten2[11,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[11,:], SpringtEinInSchicht=SpringtEinInSchicht2[11,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[11]) if AnzahlStation1Personal >10;
  FiliP.PflegekraftUrlaubRandom pflegekraftB12(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[12,1], StartWochenEnde = PersonalDaten2[12,2], DauerWochenEnde = PersonalDaten2[12,3], IntervallWochenEnde = PersonalDaten2[12,4], IntervallNichtWochenEnde = PersonalDaten2[12,7], NichtWochenEnde = NichtWochenEnde2[12], StartNichtWochenEnde = PersonalDaten2[12,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[12,:], SpringtEinInSchicht=SpringtEinInSchicht2[12,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[12]) if AnzahlStation1Personal >11;
  FiliP.PflegekraftUrlaubRandom pflegekraftB13(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[13,1], StartWochenEnde = PersonalDaten2[13,2], DauerWochenEnde = PersonalDaten2[13,3], IntervallWochenEnde = PersonalDaten2[13,4], IntervallNichtWochenEnde = PersonalDaten2[13,7], NichtWochenEnde = NichtWochenEnde2[13], StartNichtWochenEnde = PersonalDaten2[13,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[13,:], SpringtEinInSchicht=SpringtEinInSchicht2[13,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[13]) if AnzahlStation1Personal >12;
  FiliP.PflegekraftUrlaubRandom pflegekraftB14(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[14,1], StartWochenEnde = PersonalDaten2[14,2], DauerWochenEnde = PersonalDaten2[14,3], IntervallWochenEnde = PersonalDaten2[14,4], IntervallNichtWochenEnde = PersonalDaten2[14,7], NichtWochenEnde = NichtWochenEnde2[14], StartNichtWochenEnde = PersonalDaten2[14,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[14,:], SpringtEinInSchicht=SpringtEinInSchicht2[14,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[14]) if AnzahlStation1Personal >13;
  FiliP.PflegekraftUrlaubRandom pflegekraftB15(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[15,1], StartWochenEnde = PersonalDaten2[15,2], DauerWochenEnde = PersonalDaten2[15,3], IntervallWochenEnde = PersonalDaten2[15,4], IntervallNichtWochenEnde = PersonalDaten2[15,7], NichtWochenEnde = NichtWochenEnde2[15], StartNichtWochenEnde = PersonalDaten2[15,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[15,:], SpringtEinInSchicht=SpringtEinInSchicht2[15,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[15]) if AnzahlStation1Personal >14;
  FiliP.PflegekraftUrlaubRandom pflegekraftB16(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[16,1], StartWochenEnde = PersonalDaten2[16,2], DauerWochenEnde = PersonalDaten2[16,3], IntervallWochenEnde = PersonalDaten2[16,4], IntervallNichtWochenEnde = PersonalDaten2[16,7], NichtWochenEnde = NichtWochenEnde2[16], StartNichtWochenEnde = PersonalDaten2[16,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[16,:], SpringtEinInSchicht=SpringtEinInSchicht2[16,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[16]) if AnzahlStation1Personal >15;
  //
  FiliP.PflegekraftUrlaubRandom pflegekraftB17(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[17,1], StartWochenEnde = PersonalDaten2[17,2], DauerWochenEnde = PersonalDaten2[17,3], IntervallWochenEnde = PersonalDaten2[17,4], IntervallNichtWochenEnde = PersonalDaten2[17,7], NichtWochenEnde = NichtWochenEnde2[17], StartNichtWochenEnde = PersonalDaten2[17,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[17,:], SpringtEinInSchicht=SpringtEinInSchicht2[17,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[17]) if AnzahlStation1Personal >16;
  FiliP.PflegekraftUrlaubRandom pflegekraftB18(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[18,1], StartWochenEnde = PersonalDaten2[18,2], DauerWochenEnde = PersonalDaten2[18,3], IntervallWochenEnde = PersonalDaten2[18,4], IntervallNichtWochenEnde = PersonalDaten2[18,7], NichtWochenEnde = NichtWochenEnde2[18], StartNichtWochenEnde = PersonalDaten2[18,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[18,:], SpringtEinInSchicht=SpringtEinInSchicht2[18,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[18]) if AnzahlStation1Personal >17;
  FiliP.PflegekraftUrlaubRandom pflegekraftB19(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[19,1], StartWochenEnde = PersonalDaten2[19,2], DauerWochenEnde = PersonalDaten2[19,3], IntervallWochenEnde = PersonalDaten2[19,4], IntervallNichtWochenEnde = PersonalDaten2[19,7], NichtWochenEnde = NichtWochenEnde2[19], StartNichtWochenEnde = PersonalDaten2[19,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[19,:], SpringtEinInSchicht=SpringtEinInSchicht2[19,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[19]) if AnzahlStation1Personal >18;
  FiliP.PflegekraftUrlaubRandom pflegekraftB20(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[20,1], StartWochenEnde = PersonalDaten2[20,2], DauerWochenEnde = PersonalDaten2[20,3], IntervallWochenEnde = PersonalDaten2[20,4], IntervallNichtWochenEnde = PersonalDaten2[20,7], NichtWochenEnde = NichtWochenEnde2[20], StartNichtWochenEnde = PersonalDaten2[20,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[20,:], SpringtEinInSchicht=SpringtEinInSchicht2[20,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[20]) if AnzahlStation1Personal >19;
  FiliP.PflegekraftUrlaubRandom pflegekraftB21(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[21,1], StartWochenEnde = PersonalDaten2[21,2], DauerWochenEnde = PersonalDaten2[21,3], IntervallWochenEnde = PersonalDaten2[21,4], IntervallNichtWochenEnde = PersonalDaten2[21,7], NichtWochenEnde = NichtWochenEnde2[21], StartNichtWochenEnde = PersonalDaten2[21,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[21,:], SpringtEinInSchicht=SpringtEinInSchicht2[21,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[21]) if AnzahlStation1Personal >20;
  FiliP.PflegekraftUrlaubRandom pflegekraftB22(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[22,1], StartWochenEnde = PersonalDaten2[22,2], DauerWochenEnde = PersonalDaten2[22,3], IntervallWochenEnde = PersonalDaten2[22,4], IntervallNichtWochenEnde = PersonalDaten2[22,7], NichtWochenEnde = NichtWochenEnde2[22], StartNichtWochenEnde = PersonalDaten2[22,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[22,:], SpringtEinInSchicht=SpringtEinInSchicht2[22,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[22]) if AnzahlStation1Personal >21;
  FiliP.PflegekraftUrlaubRandom pflegekraftB23(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[23,1], StartWochenEnde = PersonalDaten2[23,2], DauerWochenEnde = PersonalDaten2[23,3], IntervallWochenEnde = PersonalDaten2[23,4], IntervallNichtWochenEnde = PersonalDaten2[23,7], NichtWochenEnde = NichtWochenEnde2[23], StartNichtWochenEnde = PersonalDaten2[23,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[23,:], SpringtEinInSchicht=SpringtEinInSchicht2[23,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[23]) if AnzahlStation1Personal >22;
  FiliP.PflegekraftUrlaubRandom pflegekraftB24(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[24,1], StartWochenEnde = PersonalDaten2[24,2], DauerWochenEnde = PersonalDaten2[24,3], IntervallWochenEnde = PersonalDaten2[24,4], IntervallNichtWochenEnde = PersonalDaten2[24,7], NichtWochenEnde = NichtWochenEnde2[24], StartNichtWochenEnde = PersonalDaten2[24,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[24,:], SpringtEinInSchicht=SpringtEinInSchicht2[24,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[24]) if AnzahlStation1Personal >23;
  //
  FiliP.PflegekraftUrlaubRandom pflegekraftB25(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[25,1], StartWochenEnde = PersonalDaten2[25,2], DauerWochenEnde = PersonalDaten2[25,3], IntervallWochenEnde = PersonalDaten2[25,4], IntervallNichtWochenEnde = PersonalDaten2[25,7], NichtWochenEnde = NichtWochenEnde2[25], StartNichtWochenEnde = PersonalDaten2[25,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[25,:], SpringtEinInSchicht=SpringtEinInSchicht2[25,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[25]) if AnzahlStation1Personal >24;
  FiliP.PflegekraftUrlaubRandom pflegekraftB26(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[26,1], StartWochenEnde = PersonalDaten2[26,2], DauerWochenEnde = PersonalDaten2[26,3], IntervallWochenEnde = PersonalDaten2[26,4], IntervallNichtWochenEnde = PersonalDaten2[26,7], NichtWochenEnde = NichtWochenEnde2[26], StartNichtWochenEnde = PersonalDaten2[26,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[26,:], SpringtEinInSchicht=SpringtEinInSchicht2[26,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[26]) if AnzahlStation1Personal >25;
  FiliP.PflegekraftUrlaubRandom pflegekraftB27(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[27,1], StartWochenEnde = PersonalDaten2[27,2], DauerWochenEnde = PersonalDaten2[27,3], IntervallWochenEnde = PersonalDaten2[27,4], IntervallNichtWochenEnde = PersonalDaten2[27,7], NichtWochenEnde = NichtWochenEnde2[27], StartNichtWochenEnde = PersonalDaten2[27,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[27,:], SpringtEinInSchicht=SpringtEinInSchicht2[27,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[27]) if AnzahlStation1Personal >26;
  FiliP.PflegekraftUrlaubRandom pflegekraftB28(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[28,1], StartWochenEnde = PersonalDaten2[28,2], DauerWochenEnde = PersonalDaten2[28,3], IntervallWochenEnde = PersonalDaten2[28,4], IntervallNichtWochenEnde = PersonalDaten2[28,7], NichtWochenEnde = NichtWochenEnde2[28], StartNichtWochenEnde = PersonalDaten2[28,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[28,:], SpringtEinInSchicht=SpringtEinInSchicht2[28,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[28]) if AnzahlStation1Personal >27;
  FiliP.PflegekraftUrlaubRandom pflegekraftB29(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[29,1], StartWochenEnde = PersonalDaten2[29,2], DauerWochenEnde = PersonalDaten2[29,3], IntervallWochenEnde = PersonalDaten2[29,4], IntervallNichtWochenEnde = PersonalDaten2[29,7], NichtWochenEnde = NichtWochenEnde2[29], StartNichtWochenEnde = PersonalDaten2[29,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[29,:], SpringtEinInSchicht=SpringtEinInSchicht2[29,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[29]) if AnzahlStation1Personal >28;
  FiliP.PflegekraftUrlaubRandom pflegekraftB30(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[30,1], StartWochenEnde = PersonalDaten2[30,2], DauerWochenEnde = PersonalDaten2[30,3], IntervallWochenEnde = PersonalDaten2[30,4], IntervallNichtWochenEnde = PersonalDaten2[30,7], NichtWochenEnde = NichtWochenEnde2[30], StartNichtWochenEnde = PersonalDaten2[30,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[30,:], SpringtEinInSchicht=SpringtEinInSchicht2[30,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[30]) if AnzahlStation1Personal >29;
  FiliP.PflegekraftUrlaubRandom pflegekraftB31(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[31,1], StartWochenEnde = PersonalDaten2[31,2], DauerWochenEnde = PersonalDaten2[31,3], IntervallWochenEnde = PersonalDaten2[31,4], IntervallNichtWochenEnde = PersonalDaten2[31,7], NichtWochenEnde = NichtWochenEnde2[31], StartNichtWochenEnde = PersonalDaten2[31,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[31,:], SpringtEinInSchicht=SpringtEinInSchicht2[31,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[31]) if AnzahlStation1Personal >30;
  FiliP.PflegekraftUrlaubRandom pflegekraftB32(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[32,1], StartWochenEnde = PersonalDaten2[32,2], DauerWochenEnde = PersonalDaten2[32,3], IntervallWochenEnde = PersonalDaten2[32,4], IntervallNichtWochenEnde = PersonalDaten2[32,7], NichtWochenEnde = NichtWochenEnde2[32], StartNichtWochenEnde = PersonalDaten2[32,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[32,:], SpringtEinInSchicht=SpringtEinInSchicht2[32,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[32]) if AnzahlStation1Personal >31;
  //
  FiliP.PflegekraftUrlaubRandom pflegekraftB33(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[33,1], StartWochenEnde = PersonalDaten2[33,2], DauerWochenEnde = PersonalDaten2[33,3], IntervallWochenEnde = PersonalDaten2[33,4], IntervallNichtWochenEnde = PersonalDaten2[33,7], NichtWochenEnde = NichtWochenEnde2[33], StartNichtWochenEnde = PersonalDaten2[33,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[33,:], SpringtEinInSchicht=SpringtEinInSchicht2[33,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[33]) if AnzahlStation1Personal >32;
  FiliP.PflegekraftUrlaubRandom pflegekraftB34(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[34,1], StartWochenEnde = PersonalDaten2[34,2], DauerWochenEnde = PersonalDaten2[34,3], IntervallWochenEnde = PersonalDaten2[34,4], IntervallNichtWochenEnde = PersonalDaten2[34,7], NichtWochenEnde = NichtWochenEnde2[34], StartNichtWochenEnde = PersonalDaten2[34,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[34,:], SpringtEinInSchicht=SpringtEinInSchicht2[34,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[34]) if AnzahlStation1Personal >33;
  FiliP.PflegekraftUrlaubRandom pflegekraftB35(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[35,1], StartWochenEnde = PersonalDaten2[35,2], DauerWochenEnde = PersonalDaten2[35,3], IntervallWochenEnde = PersonalDaten2[35,4], IntervallNichtWochenEnde = PersonalDaten2[35,7], NichtWochenEnde = NichtWochenEnde2[35], StartNichtWochenEnde = PersonalDaten2[35,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[35,:], SpringtEinInSchicht=SpringtEinInSchicht2[35,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[35]) if AnzahlStation1Personal >34;
  FiliP.PflegekraftUrlaubRandom pflegekraftB36(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[36,1], StartWochenEnde = PersonalDaten2[36,2], DauerWochenEnde = PersonalDaten2[36,3], IntervallWochenEnde = PersonalDaten2[36,4], IntervallNichtWochenEnde = PersonalDaten2[36,7], NichtWochenEnde = NichtWochenEnde2[36], StartNichtWochenEnde = PersonalDaten2[36,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[36,:], SpringtEinInSchicht=SpringtEinInSchicht2[36,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[36]) if AnzahlStation1Personal >35;
  FiliP.PflegekraftUrlaubRandom pflegekraftB37(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[37,1], StartWochenEnde = PersonalDaten2[37,2], DauerWochenEnde = PersonalDaten2[37,3], IntervallWochenEnde = PersonalDaten2[37,4], IntervallNichtWochenEnde = PersonalDaten2[37,7], NichtWochenEnde = NichtWochenEnde2[37], StartNichtWochenEnde = PersonalDaten2[37,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[37,:], SpringtEinInSchicht=SpringtEinInSchicht2[37,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[37]) if AnzahlStation1Personal >36;
  FiliP.PflegekraftUrlaubRandom pflegekraftB38(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[38,1], StartWochenEnde = PersonalDaten2[38,2], DauerWochenEnde = PersonalDaten2[38,3], IntervallWochenEnde = PersonalDaten2[38,4], IntervallNichtWochenEnde = PersonalDaten2[38,7], NichtWochenEnde = NichtWochenEnde2[38], StartNichtWochenEnde = PersonalDaten2[38,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[38,:], SpringtEinInSchicht=SpringtEinInSchicht2[38,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[38]) if AnzahlStation1Personal >37;
  FiliP.PflegekraftUrlaubRandom pflegekraftB39(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[39,1], StartWochenEnde = PersonalDaten2[39,2], DauerWochenEnde = PersonalDaten2[39,3], IntervallWochenEnde = PersonalDaten2[39,4], IntervallNichtWochenEnde = PersonalDaten2[39,7], NichtWochenEnde = NichtWochenEnde2[39], StartNichtWochenEnde = PersonalDaten2[39,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[39,:], SpringtEinInSchicht=SpringtEinInSchicht2[39,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[39]) if AnzahlStation1Personal >38;
  FiliP.PflegekraftUrlaubRandom pflegekraftB40(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[40,1], StartWochenEnde = PersonalDaten2[40,2], DauerWochenEnde = PersonalDaten2[40,3], IntervallWochenEnde = PersonalDaten2[40,4], IntervallNichtWochenEnde = PersonalDaten2[40,7], NichtWochenEnde = NichtWochenEnde2[40], StartNichtWochenEnde = PersonalDaten2[40,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[40,:], SpringtEinInSchicht=SpringtEinInSchicht2[40,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[40]) if AnzahlStation1Personal >39;
  //
  FiliP.PflegekraftUrlaubRandom pflegekraftB41(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[41,1], StartWochenEnde = PersonalDaten2[41,2], DauerWochenEnde = PersonalDaten2[41,3], IntervallWochenEnde = PersonalDaten2[41,4], IntervallNichtWochenEnde = PersonalDaten2[41,7], NichtWochenEnde = NichtWochenEnde2[41], StartNichtWochenEnde = PersonalDaten2[41,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[41,:], SpringtEinInSchicht=SpringtEinInSchicht2[41,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[41]) if AnzahlStation1Personal >40;
  FiliP.PflegekraftUrlaubRandom pflegekraftB42(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[42,1], StartWochenEnde = PersonalDaten2[42,2], DauerWochenEnde = PersonalDaten2[42,3], IntervallWochenEnde = PersonalDaten2[42,4], IntervallNichtWochenEnde = PersonalDaten2[42,7], NichtWochenEnde = NichtWochenEnde2[42], StartNichtWochenEnde = PersonalDaten2[42,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[42,:], SpringtEinInSchicht=SpringtEinInSchicht2[42,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[42]) if AnzahlStation1Personal >41;
  FiliP.PflegekraftUrlaubRandom pflegekraftB43(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[43,1], StartWochenEnde = PersonalDaten2[43,2], DauerWochenEnde = PersonalDaten2[43,3], IntervallWochenEnde = PersonalDaten2[43,4], IntervallNichtWochenEnde = PersonalDaten2[43,7], NichtWochenEnde = NichtWochenEnde2[43], StartNichtWochenEnde = PersonalDaten2[43,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[43,:], SpringtEinInSchicht=SpringtEinInSchicht2[43,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[43]) if AnzahlStation1Personal >42;
  FiliP.PflegekraftUrlaubRandom pflegekraftB44(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[44,1], StartWochenEnde = PersonalDaten2[44,2], DauerWochenEnde = PersonalDaten2[44,3], IntervallWochenEnde = PersonalDaten2[44,4], IntervallNichtWochenEnde = PersonalDaten2[44,7], NichtWochenEnde = NichtWochenEnde2[44], StartNichtWochenEnde = PersonalDaten2[44,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[44,:], SpringtEinInSchicht=SpringtEinInSchicht2[44,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[44]) if AnzahlStation1Personal >43;
  FiliP.PflegekraftUrlaubRandom pflegekraftB45(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[45,1], StartWochenEnde = PersonalDaten2[45,2], DauerWochenEnde = PersonalDaten2[45,3], IntervallWochenEnde = PersonalDaten2[45,4], IntervallNichtWochenEnde = PersonalDaten2[45,7], NichtWochenEnde = NichtWochenEnde2[45], StartNichtWochenEnde = PersonalDaten2[45,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[45,:], SpringtEinInSchicht=SpringtEinInSchicht2[45,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[45]) if AnzahlStation1Personal >44;
  FiliP.PflegekraftUrlaubRandom pflegekraftB46(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[46,1], StartWochenEnde = PersonalDaten2[46,2], DauerWochenEnde = PersonalDaten2[46,3], IntervallWochenEnde = PersonalDaten2[46,4], IntervallNichtWochenEnde = PersonalDaten2[46,7], NichtWochenEnde = NichtWochenEnde2[46], StartNichtWochenEnde = PersonalDaten2[46,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[46,:], SpringtEinInSchicht=SpringtEinInSchicht2[46,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[46]) if AnzahlStation1Personal >45;
  FiliP.PflegekraftUrlaubRandom pflegekraftB47(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[47,1], StartWochenEnde = PersonalDaten2[47,2], DauerWochenEnde = PersonalDaten2[47,3], IntervallWochenEnde = PersonalDaten2[47,4], IntervallNichtWochenEnde = PersonalDaten2[47,7], NichtWochenEnde = NichtWochenEnde2[47], StartNichtWochenEnde = PersonalDaten2[47,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[47,:], SpringtEinInSchicht=SpringtEinInSchicht2[47,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[47]) if AnzahlStation1Personal >46;
  FiliP.PflegekraftUrlaubRandom pflegekraftB48(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[48,1], StartWochenEnde = PersonalDaten2[48,2], DauerWochenEnde = PersonalDaten2[48,3], IntervallWochenEnde = PersonalDaten2[48,4], IntervallNichtWochenEnde = PersonalDaten2[48,7], NichtWochenEnde = NichtWochenEnde2[48], StartNichtWochenEnde = PersonalDaten2[48,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[48,:], SpringtEinInSchicht=SpringtEinInSchicht2[48,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[48]) if AnzahlStation1Personal >47;
  //
  FiliP.PflegekraftUrlaubRandom pflegekraftB49(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[49,1], StartWochenEnde = PersonalDaten2[49,2], DauerWochenEnde = PersonalDaten2[49,3], IntervallWochenEnde = PersonalDaten2[49,4], IntervallNichtWochenEnde = PersonalDaten2[49,7], NichtWochenEnde = NichtWochenEnde2[49], StartNichtWochenEnde = PersonalDaten2[49,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[49,:], SpringtEinInSchicht=SpringtEinInSchicht2[49,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[49]) if AnzahlStation1Personal >48;
  FiliP.PflegekraftUrlaubRandom pflegekraftB50(AnzahlSchichten=AnzahlSchichten2, Schichtzeiten=Schichtzeiten2, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten2[50,1], StartWochenEnde = PersonalDaten2[50,2], DauerWochenEnde = PersonalDaten2[50,3], IntervallWochenEnde = PersonalDaten2[50,4], IntervallNichtWochenEnde = PersonalDaten2[50,7], NichtWochenEnde = NichtWochenEnde2[50], StartNichtWochenEnde = PersonalDaten2[50,6], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten1[50,:], SpringtEinInSchicht=SpringtEinInSchicht2[50,:], AnzahlUrlaubsWochen=AnzahlUrlaubsWochen2[50]) if AnzahlStation1Personal >49;





  PNlib.PN.Components.PD UrlaubKopf(maxTokens = MaxKopfeUrlaub, nInDis = AnzahlStation1Personal+AnzahlStation2Personal, nOutDis = AnzahlStation1Personal+AnzahlStation2Personal)  annotation(
    Placement(visible = true, transformation(origin = {68, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PC UrlaubStellen(maxTokens = MaxStellenUrlaub, nInDis = AnzahlStation1Personal+AnzahlStation2Personal, nOutDis = AnzahlStation1Personal+AnzahlStation2Personal)  annotation(
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


    for i in 1:(2*AnzahlSchichten1) loop
      connect(station1.PersonalIn[i], pflegekraft1.transitionOutDis[i]);
      connect(station1.PersonalIn[2*AnzahlSchichten1+i], pflegekraft2.transitionOutDis[i]);
      connect(station1.PersonalIn[4*AnzahlSchichten1+i], pflegekraft3.transitionOutDis[i]);
      connect(station1.PersonalIn[6*AnzahlSchichten1+i], pflegekraft4.transitionOutDis[i]);
      connect(station1.PersonalIn[8*AnzahlSchichten1+i], pflegekraft5.transitionOutDis[i]);
      connect(station1.PersonalIn[10*AnzahlSchichten1+i], pflegekraft6.transitionOutDis[i]);
      connect(station1.PersonalIn[12*AnzahlSchichten1+i], pflegekraft7.transitionOutDis[i]);
      connect(station1.PersonalIn[14*AnzahlSchichten1+i], pflegekraft8.transitionOutDis[i]);
      connect(station1.PersonalIn[16*AnzahlSchichten1+i], pflegekraft9.transitionOutDis[i]);
      connect(station1.PersonalIn[18*AnzahlSchichten1+i], pflegekraft10.transitionOutDis[i]);
      connect(station1.PersonalIn[20*AnzahlSchichten1+i], pflegekraft11.transitionOutDis[i]);
      connect(station1.PersonalIn[22*AnzahlSchichten1+i], pflegekraft12.transitionOutDis[i]);
      connect(station1.PersonalIn[24*AnzahlSchichten1+i], pflegekraft13.transitionOutDis[i]);
      connect(station1.PersonalIn[26*AnzahlSchichten1+i], pflegekraft14.transitionOutDis[i]);
      connect(station1.PersonalIn[28*AnzahlSchichten1+i], pflegekraft15.transitionOutDis[i]);
      connect(station1.PersonalIn[30*AnzahlSchichten1+i], pflegekraft16.transitionOutDis[i]);
      connect(station1.PersonalIn[32*AnzahlSchichten1+i], pflegekraft17.transitionOutDis[i]);
      connect(station1.PersonalIn[34*AnzahlSchichten1+i], pflegekraft18.transitionOutDis[i]);
      connect(station1.PersonalIn[36*AnzahlSchichten1+i], pflegekraft19.transitionOutDis[i]);
      connect(station1.PersonalIn[38*AnzahlSchichten1+i], pflegekraft20.transitionOutDis[i]);
      connect(station1.PersonalIn[40*AnzahlSchichten1+i], pflegekraft21.transitionOutDis[i]);
      connect(station1.PersonalIn[42*AnzahlSchichten1+i], pflegekraft22.transitionOutDis[i]);
      connect(station1.PersonalIn[44*AnzahlSchichten1+i], pflegekraft23.transitionOutDis[i]);
      connect(station1.PersonalIn[46*AnzahlSchichten1+i], pflegekraft24.transitionOutDis[i]);
      connect(station1.PersonalIn[48*AnzahlSchichten1+i], pflegekraft25.transitionOutDis[i]);
      connect(station1.PersonalIn[50*AnzahlSchichten1+i], pflegekraft26.transitionOutDis[i]);
      connect(station1.PersonalIn[52*AnzahlSchichten1+i], pflegekraft27.transitionOutDis[i]);
      connect(station1.PersonalIn[54*AnzahlSchichten1+i], pflegekraft28.transitionOutDis[i]);
      connect(station1.PersonalIn[56*AnzahlSchichten1+i], pflegekraft29.transitionOutDis[i]);
      connect(station1.PersonalIn[58*AnzahlSchichten1+i], pflegekraft30.transitionOutDis[i]);
      connect(station1.PersonalIn[60*AnzahlSchichten1+i], pflegekraft31.transitionOutDis[i]);
      connect(station1.PersonalIn[62*AnzahlSchichten1+i], pflegekraft32.transitionOutDis[i]);
      connect(station1.PersonalIn[64*AnzahlSchichten1+i], pflegekraft33.transitionOutDis[i]);
      connect(station1.PersonalIn[66*AnzahlSchichten1+i], pflegekraft34.transitionOutDis[i]);
      connect(station1.PersonalIn[68*AnzahlSchichten1+i], pflegekraft35.transitionOutDis[i]);
      connect(station1.PersonalIn[70*AnzahlSchichten1+i], pflegekraft36.transitionOutDis[i]);
      connect(station1.PersonalIn[72*AnzahlSchichten1+i], pflegekraft37.transitionOutDis[i]);
      connect(station1.PersonalIn[74*AnzahlSchichten1+i], pflegekraft38.transitionOutDis[i]);
      connect(station1.PersonalIn[76*AnzahlSchichten1+i], pflegekraft39.transitionOutDis[i]);
      connect(station1.PersonalIn[78*AnzahlSchichten1+i], pflegekraft40.transitionOutDis[i]);
      connect(station1.PersonalIn[80*AnzahlSchichten1+i], pflegekraft41.transitionOutDis[i]);
      connect(station1.PersonalIn[82*AnzahlSchichten1+i], pflegekraft42.transitionOutDis[i]);
      connect(station1.PersonalIn[84*AnzahlSchichten1+i], pflegekraft43.transitionOutDis[i]);
      connect(station1.PersonalIn[86*AnzahlSchichten1+i], pflegekraft44.transitionOutDis[i]);
      connect(station1.PersonalIn[88*AnzahlSchichten1+i], pflegekraft45.transitionOutDis[i]);
      connect(station1.PersonalIn[90*AnzahlSchichten1+i], pflegekraft46.transitionOutDis[i]);
      connect(station1.PersonalIn[92*AnzahlSchichten1+i], pflegekraft47.transitionOutDis[i]);
      connect(station1.PersonalIn[94*AnzahlSchichten1+i], pflegekraft48.transitionOutDis[i]);
      connect(station1.PersonalIn[96*AnzahlSchichten1+i], pflegekraft49.transitionOutDis[i]);
      connect(station1.PersonalIn[98*AnzahlSchichten1+i], pflegekraft50.transitionOutDis[i]);


      connect(station1.PersonalOut[i], pflegekraft1.transitionInDis[i]);
      connect(station1.PersonalOut[2*AnzahlSchichten1+i], pflegekraft2.transitionInDis[i]);
      connect(station1.PersonalOut[4*AnzahlSchichten1+i], pflegekraft3.transitionInDis[i]);
      connect(station1.PersonalOut[6*AnzahlSchichten1+i], pflegekraft4.transitionInDis[i]);
      connect(station1.PersonalOut[8*AnzahlSchichten1+i], pflegekraft5.transitionInDis[i]);
      connect(station1.PersonalOut[10*AnzahlSchichten1+i], pflegekraft6.transitionInDis[i]);
      connect(station1.PersonalOut[12*AnzahlSchichten1+i], pflegekraft7.transitionInDis[i]);
      connect(station1.PersonalOut[14*AnzahlSchichten1+i], pflegekraft8.transitionInDis[i]);
      connect(station1.PersonalOut[16*AnzahlSchichten1+i], pflegekraft9.transitionInDis[i]);
      connect(station1.PersonalOut[18*AnzahlSchichten1+i], pflegekraft10.transitionInDis[i]);
      connect(station1.PersonalOut[20*AnzahlSchichten1+i], pflegekraft11.transitionInDis[i]);
      connect(station1.PersonalOut[22*AnzahlSchichten1+i], pflegekraft12.transitionInDis[i]);
      connect(station1.PersonalOut[24*AnzahlSchichten1+i], pflegekraft13.transitionInDis[i]);
      connect(station1.PersonalOut[26*AnzahlSchichten1+i], pflegekraft14.transitionInDis[i]);
      connect(station1.PersonalOut[28*AnzahlSchichten1+i], pflegekraft15.transitionInDis[i]);
      connect(station1.PersonalOut[30*AnzahlSchichten1+i], pflegekraft16.transitionInDis[i]);
      connect(station1.PersonalOut[32*AnzahlSchichten1+i], pflegekraft17.transitionInDis[i]);
      connect(station1.PersonalOut[34*AnzahlSchichten1+i], pflegekraft18.transitionInDis[i]);
      connect(station1.PersonalOut[36*AnzahlSchichten1+i], pflegekraft19.transitionInDis[i]);
      connect(station1.PersonalOut[38*AnzahlSchichten1+i], pflegekraft20.transitionInDis[i]);
      connect(station1.PersonalOut[40*AnzahlSchichten1+i], pflegekraft21.transitionInDis[i]);
      connect(station1.PersonalOut[42*AnzahlSchichten1+i], pflegekraft22.transitionInDis[i]);
      connect(station1.PersonalOut[44*AnzahlSchichten1+i], pflegekraft23.transitionInDis[i]);
      connect(station1.PersonalOut[46*AnzahlSchichten1+i], pflegekraft24.transitionInDis[i]);
      connect(station1.PersonalOut[48*AnzahlSchichten1+i], pflegekraft25.transitionInDis[i]);
      connect(station1.PersonalOut[50*AnzahlSchichten1+i], pflegekraft26.transitionInDis[i]);
      connect(station1.PersonalOut[52*AnzahlSchichten1+i], pflegekraft27.transitionInDis[i]);
      connect(station1.PersonalOut[54*AnzahlSchichten1+i], pflegekraft28.transitionInDis[i]);
      connect(station1.PersonalOut[56*AnzahlSchichten1+i], pflegekraft29.transitionInDis[i]);
      connect(station1.PersonalOut[58*AnzahlSchichten1+i], pflegekraft30.transitionInDis[i]);
      connect(station1.PersonalOut[60*AnzahlSchichten1+i], pflegekraft31.transitionInDis[i]);
      connect(station1.PersonalOut[62*AnzahlSchichten1+i], pflegekraft32.transitionInDis[i]);
      connect(station1.PersonalOut[64*AnzahlSchichten1+i], pflegekraft33.transitionInDis[i]);
      connect(station1.PersonalOut[66*AnzahlSchichten1+i], pflegekraft34.transitionInDis[i]);
      connect(station1.PersonalOut[68*AnzahlSchichten1+i], pflegekraft35.transitionInDis[i]);
      connect(station1.PersonalOut[70*AnzahlSchichten1+i], pflegekraft36.transitionInDis[i]);
      connect(station1.PersonalOut[72*AnzahlSchichten1+i], pflegekraft37.transitionInDis[i]);
      connect(station1.PersonalOut[74*AnzahlSchichten1+i], pflegekraft38.transitionInDis[i]);
      connect(station1.PersonalOut[76*AnzahlSchichten1+i], pflegekraft39.transitionInDis[i]);
      connect(station1.PersonalOut[78*AnzahlSchichten1+i], pflegekraft40.transitionInDis[i]);
      connect(station1.PersonalOut[80*AnzahlSchichten1+i], pflegekraft41.transitionInDis[i]);
      connect(station1.PersonalOut[82*AnzahlSchichten1+i], pflegekraft42.transitionInDis[i]);
      connect(station1.PersonalOut[84*AnzahlSchichten1+i], pflegekraft43.transitionInDis[i]);
      connect(station1.PersonalOut[86*AnzahlSchichten1+i], pflegekraft44.transitionInDis[i]);
      connect(station1.PersonalOut[88*AnzahlSchichten1+i], pflegekraft45.transitionInDis[i]);
      connect(station1.PersonalOut[90*AnzahlSchichten1+i], pflegekraft46.transitionInDis[i]);
      connect(station1.PersonalOut[92*AnzahlSchichten1+i], pflegekraft47.transitionInDis[i]);
      connect(station1.PersonalOut[94*AnzahlSchichten1+i], pflegekraft48.transitionInDis[i]);
      connect(station1.PersonalOut[96*AnzahlSchichten1+i], pflegekraft49.transitionInDis[i]);
      connect(station1.PersonalOut[98*AnzahlSchichten1+i], pflegekraft50.transitionInDis[i]);
  end for;

  connect(pflegekraftB1.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+1]);
  connect(pflegekraftB2.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+2]);
  connect(pflegekraftB3.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+3]);
  connect(pflegekraftB4.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+4]);
  connect(pflegekraftB5.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+5]);
  connect(pflegekraftB6.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+6]);
  connect(pflegekraftB7.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+7]);
  connect(pflegekraftB8.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+8]);
  connect(pflegekraftB9.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+9]);
  connect(pflegekraftB10.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+10]);
  connect(pflegekraftB11.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+11]);
  connect(pflegekraftB12.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+12]);
  connect(pflegekraftB13.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+13]);
  connect(pflegekraftB14.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+14]);
  connect(pflegekraftB15.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+15]);
  connect(pflegekraftB16.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+16]);
  connect(pflegekraftB17.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+17]);
  connect(pflegekraftB18.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+18]);
  connect(pflegekraftB19.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+19]);
  connect(pflegekraftB20.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+20]);
  connect(pflegekraftB21.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+21]);
  connect(pflegekraftB22.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+22]);
  connect(pflegekraftB23.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+23]);
  connect(pflegekraftB24.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+24]);
  connect(pflegekraftB25.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+25]);
  connect(pflegekraftB26.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+26]);
  connect(pflegekraftB27.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+27]);
  connect(pflegekraftB28.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+28]);
  connect(pflegekraftB29.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+29]);
  connect(pflegekraftB30.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+30]);
  connect(pflegekraftB31.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+31]);
  connect(pflegekraftB32.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+32]);
  connect(pflegekraftB33.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+33]);
  connect(pflegekraftB34.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+34]);
  connect(pflegekraftB35.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+35]);
  connect(pflegekraftB36.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+36]);
  connect(pflegekraftB37.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+37]);
  connect(pflegekraftB38.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+38]);
  connect(pflegekraftB39.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+39]);
  connect(pflegekraftB40.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+40]);
  connect(pflegekraftB41.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+41]);
  connect(pflegekraftB42.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+42]);
  connect(pflegekraftB43.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+43]);
  connect(pflegekraftB44.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+44]);
  connect(pflegekraftB45.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+45]);
  connect(pflegekraftB46.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+46]);
  connect(pflegekraftB47.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+47]);
  connect(pflegekraftB48.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+48]);
  connect(pflegekraftB49.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+49]);
  connect(pflegekraftB50.UrlaubStelleOut, UrlaubStellen.inTransitionDis[AnzahlStation1Personal+50]);

  /////////////////////////////////////////////////
  connect(pflegekraftB1.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+1]);
  connect(pflegekraftB2.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+2]);
  connect(pflegekraftB3.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+3]);
  connect(pflegekraftB4.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+4]);
  connect(pflegekraftB5.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+5]);
  connect(pflegekraftB6.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+6]);
  connect(pflegekraftB7.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+7]);
  connect(pflegekraftB8.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+8]);
  connect(pflegekraftB9.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+9]);
  connect(pflegekraftB10.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+10]);
  connect(pflegekraftB11.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+11]);
  connect(pflegekraftB12.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+12]);
  connect(pflegekraftB13.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+13]);
  connect(pflegekraftB14.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+14]);
  connect(pflegekraftB15.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+15]);
  connect(pflegekraftB16.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+16]);
  connect(pflegekraftB17.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+17]);
  connect(pflegekraftB18.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+18]);
  connect(pflegekraftB19.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+19]);
  connect(pflegekraftB20.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+20]);
  connect(pflegekraftB21.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+21]);
  connect(pflegekraftB22.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+22]);
  connect(pflegekraftB23.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+23]);
  connect(pflegekraftB24.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+24]);
  connect(pflegekraftB25.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+25]);
  connect(pflegekraftB26.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+26]);
  connect(pflegekraftB27.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+27]);
  connect(pflegekraftB28.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+28]);
  connect(pflegekraftB29.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+29]);
  connect(pflegekraftB30.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+30]);
  connect(pflegekraftB31.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+31]);
  connect(pflegekraftB32.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+32]);
  connect(pflegekraftB33.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+33]);
  connect(pflegekraftB34.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+34]);
  connect(pflegekraftB35.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+35]);
  connect(pflegekraftB36.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+36]);
  connect(pflegekraftB37.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+37]);
  connect(pflegekraftB38.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+38]);
  connect(pflegekraftB39.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+39]);
  connect(pflegekraftB40.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+40]);
  connect(pflegekraftB41.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+41]);
  connect(pflegekraftB42.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+42]);
  connect(pflegekraftB43.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+43]);
  connect(pflegekraftB44.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+44]);
  connect(pflegekraftB45.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+45]);
  connect(pflegekraftB46.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+46]);
  connect(pflegekraftB47.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+47]);
  connect(pflegekraftB48.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+48]);
  connect(pflegekraftB49.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+49]);
  connect(pflegekraftB50.UrlaubKopfOut, UrlaubKopf.inTransitionDis[AnzahlStation1Personal+50]);
  /////////////////////////////////////////////////
  connect(pflegekraftB1.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+1]);
  connect(pflegekraftB2.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+2]);
  connect(pflegekraftB3.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+3]);
  connect(pflegekraftB4.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+4]);
  connect(pflegekraftB5.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+5]);
  connect(pflegekraftB6.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+6]);
  connect(pflegekraftB7.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+7]);
  connect(pflegekraftB8.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+8]);
  connect(pflegekraftB9.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+9]);
  connect(pflegekraftB10.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+10]);
  connect(pflegekraftB11.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+11]);
  connect(pflegekraftB12.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+12]);
  connect(pflegekraftB13.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+13]);
  connect(pflegekraftB14.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+14]);
  connect(pflegekraftB15.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+15]);
  connect(pflegekraftB16.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+16]);
  connect(pflegekraftB17.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+17]);
  connect(pflegekraftB18.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+18]);
  connect(pflegekraftB19.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+19]);
  connect(pflegekraftB20.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+20]);
  connect(pflegekraftB21.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+21]);
  connect(pflegekraftB22.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+22]);
  connect(pflegekraftB23.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+23]);
  connect(pflegekraftB24.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+24]);
  connect(pflegekraftB25.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+25]);
  connect(pflegekraftB26.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+26]);
  connect(pflegekraftB27.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+27]);
  connect(pflegekraftB28.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+28]);
  connect(pflegekraftB29.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+29]);
  connect(pflegekraftB30.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+30]);
  connect(pflegekraftB31.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+31]);
  connect(pflegekraftB32.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+32]);
  connect(pflegekraftB33.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+33]);
  connect(pflegekraftB34.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+34]);
  connect(pflegekraftB35.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+35]);
  connect(pflegekraftB36.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+36]);
  connect(pflegekraftB37.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+37]);
  connect(pflegekraftB38.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+38]);
  connect(pflegekraftB39.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+39]);
  connect(pflegekraftB40.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+40]);
  connect(pflegekraftB41.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+41]);
  connect(pflegekraftB42.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+42]);
  connect(pflegekraftB43.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+43]);
  connect(pflegekraftB44.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+44]);
  connect(pflegekraftB45.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+45]);
  connect(pflegekraftB46.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+46]);
  connect(pflegekraftB47.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+47]);
  connect(pflegekraftB48.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+48]);
  connect(pflegekraftB49.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+49]);
  connect(pflegekraftB50.UrlaubStelleIn, UrlaubStellen.outTransitionDis[AnzahlStation1Personal+50]);
  /////////////////////////////////////////////////
  connect(pflegekraftB1.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+1]);
  connect(pflegekraftB2.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+2]);
  connect(pflegekraftB3.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+3]);
  connect(pflegekraftB4.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+4]);
  connect(pflegekraftB5.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+5]);
  connect(pflegekraftB6.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+6]);
  connect(pflegekraftB7.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+7]);
  connect(pflegekraftB8.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+8]);
  connect(pflegekraftB9.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+9]);
  connect(pflegekraftB10.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+10]);
  connect(pflegekraftB11.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+11]);
  connect(pflegekraftB12.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+12]);
  connect(pflegekraftB13.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+13]);
  connect(pflegekraftB14.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+14]);
  connect(pflegekraftB15.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+15]);
  connect(pflegekraftB16.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+16]);
  connect(pflegekraftB17.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+17]);
  connect(pflegekraftB18.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+18]);
  connect(pflegekraftB19.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+19]);
  connect(pflegekraftB20.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+20]);
  connect(pflegekraftB21.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+21]);
  connect(pflegekraftB22.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+22]);
  connect(pflegekraftB23.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+23]);
  connect(pflegekraftB24.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+24]);
  connect(pflegekraftB25.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+25]);
  connect(pflegekraftB26.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+26]);
  connect(pflegekraftB27.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+27]);
  connect(pflegekraftB28.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+28]);
  connect(pflegekraftB29.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+29]);
  connect(pflegekraftB30.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+30]);
  connect(pflegekraftB31.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+31]);
  connect(pflegekraftB32.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+32]);
  connect(pflegekraftB33.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+33]);
  connect(pflegekraftB34.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+34]);
  connect(pflegekraftB35.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+35]);
  connect(pflegekraftB36.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+36]);
  connect(pflegekraftB37.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+37]);
  connect(pflegekraftB38.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+38]);
  connect(pflegekraftB39.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+39]);
  connect(pflegekraftB40.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+40]);
  connect(pflegekraftB41.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+41]);
  connect(pflegekraftB42.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+42]);
  connect(pflegekraftB43.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+43]);
  connect(pflegekraftB44.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+44]);
  connect(pflegekraftB45.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+45]);
  connect(pflegekraftB46.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+46]);
  connect(pflegekraftB47.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+47]);
  connect(pflegekraftB48.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+48]);
  connect(pflegekraftB49.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+49]);
  connect(pflegekraftB50.UrlaubKopfIn, UrlaubKopf.outTransitionDis[AnzahlStation1Personal+50]);


    for i in 1:(2*AnzahlSchichten2) loop
      connect(station2.PersonalIn[i], pflegekraftB1.transitionOutDis[i]);
      connect(station2.PersonalIn[2*AnzahlSchichten2+i], pflegekraftB2.transitionOutDis[i]);
      connect(station2.PersonalIn[4*AnzahlSchichten2+i], pflegekraftB3.transitionOutDis[i]);
      connect(station2.PersonalIn[6*AnzahlSchichten2+i], pflegekraftB4.transitionOutDis[i]);
      connect(station2.PersonalIn[8*AnzahlSchichten2+i], pflegekraftB5.transitionOutDis[i]);
      connect(station2.PersonalIn[10*AnzahlSchichten2+i], pflegekraftB6.transitionOutDis[i]);
      connect(station2.PersonalIn[12*AnzahlSchichten2+i], pflegekraftB7.transitionOutDis[i]);
      connect(station2.PersonalIn[14*AnzahlSchichten2+i], pflegekraftB8.transitionOutDis[i]);
      connect(station2.PersonalIn[16*AnzahlSchichten2+i], pflegekraftB9.transitionOutDis[i]);
      connect(station2.PersonalIn[18*AnzahlSchichten2+i], pflegekraftB10.transitionOutDis[i]);
      connect(station2.PersonalIn[20*AnzahlSchichten2+i], pflegekraftB11.transitionOutDis[i]);
      connect(station2.PersonalIn[22*AnzahlSchichten2+i], pflegekraftB12.transitionOutDis[i]);
      connect(station2.PersonalIn[24*AnzahlSchichten2+i], pflegekraftB13.transitionOutDis[i]);
      connect(station2.PersonalIn[26*AnzahlSchichten2+i], pflegekraftB14.transitionOutDis[i]);
      connect(station2.PersonalIn[28*AnzahlSchichten2+i], pflegekraftB15.transitionOutDis[i]);
      connect(station2.PersonalIn[30*AnzahlSchichten2+i], pflegekraftB16.transitionOutDis[i]);
      connect(station2.PersonalIn[32*AnzahlSchichten2+i], pflegekraftB17.transitionOutDis[i]);
      connect(station2.PersonalIn[34*AnzahlSchichten2+i], pflegekraftB18.transitionOutDis[i]);
      connect(station2.PersonalIn[36*AnzahlSchichten2+i], pflegekraftB19.transitionOutDis[i]);
      connect(station2.PersonalIn[38*AnzahlSchichten2+i], pflegekraftB20.transitionOutDis[i]);
      connect(station2.PersonalIn[40*AnzahlSchichten2+i], pflegekraftB21.transitionOutDis[i]);
      connect(station2.PersonalIn[42*AnzahlSchichten2+i], pflegekraftB22.transitionOutDis[i]);
      connect(station2.PersonalIn[44*AnzahlSchichten2+i], pflegekraftB23.transitionOutDis[i]);
      connect(station2.PersonalIn[46*AnzahlSchichten2+i], pflegekraftB24.transitionOutDis[i]);
      connect(station2.PersonalIn[48*AnzahlSchichten2+i], pflegekraftB25.transitionOutDis[i]);
      connect(station2.PersonalIn[50*AnzahlSchichten2+i], pflegekraftB26.transitionOutDis[i]);
      connect(station2.PersonalIn[52*AnzahlSchichten2+i], pflegekraftB27.transitionOutDis[i]);
      connect(station2.PersonalIn[54*AnzahlSchichten2+i], pflegekraftB28.transitionOutDis[i]);
      connect(station2.PersonalIn[56*AnzahlSchichten2+i], pflegekraftB29.transitionOutDis[i]);
      connect(station2.PersonalIn[58*AnzahlSchichten2+i], pflegekraftB30.transitionOutDis[i]);
      connect(station2.PersonalIn[60*AnzahlSchichten2+i], pflegekraftB31.transitionOutDis[i]);
      connect(station2.PersonalIn[62*AnzahlSchichten2+i], pflegekraftB32.transitionOutDis[i]);
      connect(station2.PersonalIn[64*AnzahlSchichten2+i], pflegekraftB33.transitionOutDis[i]);
      connect(station2.PersonalIn[66*AnzahlSchichten2+i], pflegekraftB34.transitionOutDis[i]);
      connect(station2.PersonalIn[68*AnzahlSchichten2+i], pflegekraftB35.transitionOutDis[i]);
      connect(station2.PersonalIn[70*AnzahlSchichten2+i], pflegekraftB36.transitionOutDis[i]);
      connect(station2.PersonalIn[72*AnzahlSchichten2+i], pflegekraftB37.transitionOutDis[i]);
      connect(station2.PersonalIn[74*AnzahlSchichten2+i], pflegekraftB38.transitionOutDis[i]);
      connect(station2.PersonalIn[76*AnzahlSchichten2+i], pflegekraftB39.transitionOutDis[i]);
      connect(station2.PersonalIn[78*AnzahlSchichten2+i], pflegekraftB40.transitionOutDis[i]);
      connect(station2.PersonalIn[80*AnzahlSchichten2+i], pflegekraftB41.transitionOutDis[i]);
      connect(station2.PersonalIn[82*AnzahlSchichten2+i], pflegekraftB42.transitionOutDis[i]);
      connect(station2.PersonalIn[84*AnzahlSchichten2+i], pflegekraftB43.transitionOutDis[i]);
      connect(station2.PersonalIn[86*AnzahlSchichten2+i], pflegekraftB44.transitionOutDis[i]);
      connect(station2.PersonalIn[88*AnzahlSchichten2+i], pflegekraftB45.transitionOutDis[i]);
      connect(station2.PersonalIn[90*AnzahlSchichten2+i], pflegekraftB46.transitionOutDis[i]);
      connect(station2.PersonalIn[92*AnzahlSchichten2+i], pflegekraftB47.transitionOutDis[i]);
      connect(station2.PersonalIn[94*AnzahlSchichten2+i], pflegekraftB48.transitionOutDis[i]);
      connect(station2.PersonalIn[96*AnzahlSchichten2+i], pflegekraftB49.transitionOutDis[i]);
      connect(station2.PersonalIn[98*AnzahlSchichten2+i], pflegekraftB50.transitionOutDis[i]);


      connect(station2.PersonalOut[i], pflegekraftB1.transitionInDis[i]);
      connect(station2.PersonalOut[2*AnzahlSchichten2+i], pflegekraftB2.transitionInDis[i]);
      connect(station2.PersonalOut[4*AnzahlSchichten2+i], pflegekraftB3.transitionInDis[i]);
      connect(station2.PersonalOut[6*AnzahlSchichten2+i], pflegekraftB4.transitionInDis[i]);
      connect(station2.PersonalOut[8*AnzahlSchichten2+i], pflegekraftB5.transitionInDis[i]);
      connect(station2.PersonalOut[10*AnzahlSchichten2+i], pflegekraftB6.transitionInDis[i]);
      connect(station2.PersonalOut[12*AnzahlSchichten2+i], pflegekraftB7.transitionInDis[i]);
      connect(station2.PersonalOut[14*AnzahlSchichten2+i], pflegekraftB8.transitionInDis[i]);
      connect(station2.PersonalOut[16*AnzahlSchichten2+i], pflegekraftB9.transitionInDis[i]);
      connect(station2.PersonalOut[18*AnzahlSchichten2+i], pflegekraftB10.transitionInDis[i]);
      connect(station2.PersonalOut[20*AnzahlSchichten2+i], pflegekraftB11.transitionInDis[i]);
      connect(station2.PersonalOut[22*AnzahlSchichten2+i], pflegekraftB12.transitionInDis[i]);
      connect(station2.PersonalOut[24*AnzahlSchichten2+i], pflegekraftB13.transitionInDis[i]);
      connect(station2.PersonalOut[26*AnzahlSchichten2+i], pflegekraftB14.transitionInDis[i]);
      connect(station2.PersonalOut[28*AnzahlSchichten2+i], pflegekraftB15.transitionInDis[i]);
      connect(station2.PersonalOut[30*AnzahlSchichten2+i], pflegekraftB16.transitionInDis[i]);
      connect(station2.PersonalOut[32*AnzahlSchichten2+i], pflegekraftB17.transitionInDis[i]);
      connect(station2.PersonalOut[34*AnzahlSchichten2+i], pflegekraftB18.transitionInDis[i]);
      connect(station2.PersonalOut[36*AnzahlSchichten2+i], pflegekraftB19.transitionInDis[i]);
      connect(station2.PersonalOut[38*AnzahlSchichten2+i], pflegekraftB20.transitionInDis[i]);
      connect(station2.PersonalOut[40*AnzahlSchichten2+i], pflegekraftB21.transitionInDis[i]);
      connect(station2.PersonalOut[42*AnzahlSchichten2+i], pflegekraftB22.transitionInDis[i]);
      connect(station2.PersonalOut[44*AnzahlSchichten2+i], pflegekraftB23.transitionInDis[i]);
      connect(station2.PersonalOut[46*AnzahlSchichten2+i], pflegekraftB24.transitionInDis[i]);
      connect(station2.PersonalOut[48*AnzahlSchichten2+i], pflegekraftB25.transitionInDis[i]);
      connect(station2.PersonalOut[50*AnzahlSchichten2+i], pflegekraftB26.transitionInDis[i]);
      connect(station2.PersonalOut[52*AnzahlSchichten2+i], pflegekraftB27.transitionInDis[i]);
      connect(station2.PersonalOut[54*AnzahlSchichten2+i], pflegekraftB28.transitionInDis[i]);
      connect(station2.PersonalOut[56*AnzahlSchichten2+i], pflegekraftB29.transitionInDis[i]);
      connect(station2.PersonalOut[58*AnzahlSchichten2+i], pflegekraftB30.transitionInDis[i]);
      connect(station2.PersonalOut[60*AnzahlSchichten2+i], pflegekraftB31.transitionInDis[i]);
      connect(station2.PersonalOut[62*AnzahlSchichten2+i], pflegekraftB32.transitionInDis[i]);
      connect(station2.PersonalOut[64*AnzahlSchichten2+i], pflegekraftB33.transitionInDis[i]);
      connect(station2.PersonalOut[66*AnzahlSchichten2+i], pflegekraftB34.transitionInDis[i]);
      connect(station2.PersonalOut[68*AnzahlSchichten2+i], pflegekraftB35.transitionInDis[i]);
      connect(station2.PersonalOut[70*AnzahlSchichten2+i], pflegekraftB36.transitionInDis[i]);
      connect(station2.PersonalOut[72*AnzahlSchichten2+i], pflegekraftB37.transitionInDis[i]);
      connect(station2.PersonalOut[74*AnzahlSchichten2+i], pflegekraftB38.transitionInDis[i]);
      connect(station2.PersonalOut[76*AnzahlSchichten2+i], pflegekraftB39.transitionInDis[i]);
      connect(station2.PersonalOut[78*AnzahlSchichten2+i], pflegekraftB40.transitionInDis[i]);
      connect(station2.PersonalOut[80*AnzahlSchichten2+i], pflegekraftB41.transitionInDis[i]);
      connect(station2.PersonalOut[82*AnzahlSchichten2+i], pflegekraftB42.transitionInDis[i]);
      connect(station2.PersonalOut[84*AnzahlSchichten2+i], pflegekraftB43.transitionInDis[i]);
      connect(station2.PersonalOut[86*AnzahlSchichten2+i], pflegekraftB44.transitionInDis[i]);
      connect(station2.PersonalOut[88*AnzahlSchichten2+i], pflegekraftB45.transitionInDis[i]);
      connect(station2.PersonalOut[90*AnzahlSchichten2+i], pflegekraftB46.transitionInDis[i]);
      connect(station2.PersonalOut[92*AnzahlSchichten2+i], pflegekraftB47.transitionInDis[i]);
      connect(station2.PersonalOut[94*AnzahlSchichten2+i], pflegekraftB48.transitionInDis[i]);
      connect(station2.PersonalOut[96*AnzahlSchichten2+i], pflegekraftB49.transitionInDis[i]);
      connect(station2.PersonalOut[98*AnzahlSchichten2+i], pflegekraftB50.transitionInDis[i]);
  end for annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-400, -400}, {400, 400}}, initialScale = 0.1)),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})));
//////////////////////////////////////////////////////////////////////////////
/*,
    experiment(StartTime = 0, StopTime = 365, Tolerance = 1e-06)*/
end TestStationDoppel;
