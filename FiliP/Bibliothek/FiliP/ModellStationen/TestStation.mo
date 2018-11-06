within FiliP.ModellStationen;
model TestStation
  extends Modelica.Icons.Example;

//Strucktur veraendernde Variablen
    parameter Integer AnzahlPersonal= 50;
    parameter Integer AnzahlSchichten= 3;
    parameter Integer SchichtHatPOOL[:] = {1,1,1,1,1,1};
// Nicht Strucktur veraendernde Variablen

   // 1 Start Fenster "sonstiges"
    // Pool?, EinSpringen?, Defizit

    parameter Real MessZeit [3] ={0.1, 0.2, 0.3};
    parameter Real MessSchwellen[5]={0.5, 0.4, 0.3, 0.2, 0.1};
    parameter Boolean NichtWochenEnde[50]={false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false};
    parameter Integer MonatEnde[12] ={31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365};

 // Ende Fenster "sonstiges"


    // Start Fenster Station

     parameter Real VKstundenWoche = 38.5 ;
    // Schicht Start, Schicht Dauer, Schicht Pause Dauer
     parameter Real Schichtzeiten[:, 3] = {{6, 8.2, 0.5},
                                          {14, 8.2, 0.5},
                                          {20.25, 10, 0.75},
                                          {10, 8.2, 0.5},
                                          {8, 8.2, 0.5},
                                          {16, 8.2, 0.5}};
    //parameter Integer SchichtHatPOOL[:] = {1,1,1,1,1,1};
    parameter Real PoolWkeit[:] = {0.5, 0.5, 0.5, 0.5, 0.5, 0.5};

    // Ende Fenster Station


    // Start Fenster Wocheneinteilung
    //Fuer Mo=1, Di=2, Mi=3, ... bei StartTag fürs erste Tag im Jahr

    parameter Integer StartTag=1 annotation(Dialog(enable = true, group = "Belastung"));
    parameter Real SollBelastung[7]={110,110,110,105,100,85,90} annotation(Dialog(enable = true, group = "Belastung"));
    parameter Real PlanKorrektur=0.45 annotation(Dialog(enable = true, group = "Belastung"));
    // Sollbesetzungen
    parameter Integer SollBesetzung[:, 7] = {{4, 4, 4, 4, 4, 3, 3},
                                             {4, 4, 4, 4, 4, 3, 3},
                                             {1, 1, 1, 1, 1, 1, 1},
                                             {1, 1, 1, 1, 1, 1, 1},
                                             {1, 1, 1, 1, 1, 1, 1},
                                             {1, 1, 1, 1, 1, 1, 1}};
    parameter Real SchwankungFallgewichtMin[7]={-20,-20,-30,-30,-40,-40,-20} annotation(Dialog(enable = true, group = "Belastung"));
    parameter Real SchwankungFallgewichtMax[7]={40,40,30,20,20,20,30} annotation(Dialog(enable = true, group = "Belastung"));
    parameter Real SchwankungFallgewichtMeist[7]={20,0,0,-5,-5,-15,5} annotation(Dialog(enable = true, group = "Belastung"));
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

  //Ende Fenster Personal
    parameter Integer UrlaubStart [:,10]={{8, 36, 64, 500,501,502,503,504,505,506},
                                         {15, 43, 71, 500,501,502,503,504,505,506},
                                         {92, 120, 148, 500,501,502,503,504,505,506},
                                         {99, 127, 155, 500,501,502,503,504,505,506},
                                         {176, 204, 232, 500,501,502,503,504,505,506},
                                         {183, 211, 239, 500,501,502,503,504,505,506},
                                         {260, 274, 288, 302, 316, 330, 500,501,502,503},
                                         {267, 281, 295, 309, 323, 337, 500,501,502,503},
                                         {8, 36, 64, 500,501,502,503,504,505,506},
                                         {15, 43, 71, 500,501,502,503,504,505,506},
                                         {92, 120, 148, 500,501,502,503,504,505,506},
                                         {99, 127, 155, 500,501,502,503,504,505,506},
                                         {176, 204, 232, 500,501,502,503,504,505,506},
                                         {183, 211, 239, 500,501,502,503,504,505,506},
                                         {260, 274, 288, 302, 316, 330, 500,501,502,503},
                                         {267, 281, 295, 309, 323, 337, 500,501,502,503},
                                         {8, 36, 64, 500,501,502,503,504,505,506},
                                         {15, 43, 71, 500,501,502,503,504,505,506},
                                         {92, 120, 148, 500,501,502,503,504,505,506},
                                         {99, 127, 155, 500,501,502,503,504,505,506},
                                         {176, 204, 232, 500,501,502,503,504,505,506},
                                         {183, 211, 239, 500,501,502,503,504,505,506},
                                         {260, 274, 288, 302, 316, 330, 500,501,502,503},
                                         {267, 281, 295, 309, 323, 337, 500,501,502,503},
                                         {8, 36, 64, 500,501,502,503,504,505,506},
                                          {15, 43, 71, 500,501,502,503,504,505,506},
                                          {92, 120, 148, 500,501,502,503,504,505,506},
                                          {99, 127, 155, 500,501,502,503,504,505,506},
                                          {176, 204, 232, 500,501,502,503,504,505,506},
                                          {183, 211, 239, 500,501,502,503,504,505,506},
                                          {260, 274, 288, 302, 316, 330, 500,501,502,503},
                                          {267, 281, 295, 309, 323, 337, 500,501,502,503},
                                          {8, 36, 64, 500,501,502,503,504,505,506},
                                          {15, 43, 71, 500,501,502,503,504,505,506},
                                          {92, 120, 148, 500,501,502,503,504,505,506},
                                          {99, 127, 155, 500,501,502,503,504,505,506},
                                          {176, 204, 232, 500,501,502,503,504,505,506},
                                          {183, 211, 239, 500,501,502,503,504,505,506},
                                          {260, 274, 288, 302, 316, 330, 500,501,502,503},
                                          {267, 281, 295, 309, 323, 337, 500,501,502,503},
                                          {8, 36, 64, 500,501,502,503,504,505,506},
                                          {15, 43, 71, 500,501,502,503,504,505,506},
                                          {92, 120, 148, 500,501,502,503,504,505,506},
                                          {99, 127, 155, 500,501,502,503,504,505,506},
                                          {176, 204, 232, 500,501,502,503,504,505,506},
                                          {183, 211, 239, 500,501,502,503,504,505,506},
                                          {260, 274, 288, 302, 316, 330, 500,501,502,503},
                                          {267, 281, 295, 309, 323, 337, 500,501,502,503},
                                          {260, 274, 288, 302, 316, 330, 500,501,502,503},
                                          {267, 281, 295, 309, 323, 337, 500,501,502,503}};
    parameter Integer UrlaubEnde [:,10]={{20, 48, 76, 500,501,502,503,504,505,506},
                                        {27, 55, 83, 500,501,502,503,504,505,506},
                                        {104, 132, 160, 500,501,502,503,504,505,506},
                                        {111, 139, 167, 500,501,502,503,504,505,506},
                                        {188, 216, 244, 500,501,502,503,504,505,506},
                                        {195, 223, 251, 500,501,502,503,504,505,506},
                                        {265, 279, 294, 308, 322, 336, 500,501,502,503},
                                        {272, 286, 301, 315, 329, 343, 500,501,502,503},
                                        {20, 48, 76, 500,501,502,503,504,505,506},
                                        {27, 55, 83, 500,501,502,503,504,505,506},
                                        {104, 132, 160, 500,501,502,503,504,505,506},
                                        {111, 139, 167, 500,501,502,503,504,505,506},
                                        {188, 216, 244, 500,501,502,503,504,505,506},
                                        {195, 223, 251, 500,501,502,503,504,505,506},
                                        {265, 279, 294, 308, 322, 336, 500,501,502,503},
                                        {272, 286, 301, 315, 329, 343, 500,501,502,503},
                                        {20, 48, 76, 500,501,502,503,504,505,506},
                                        {27, 55, 83, 500,501,502,503,504,505,506},
                                        {104, 132, 160, 500,501,502,503,504,505,506},
                                        {111, 139, 167, 500,501,502,503,504,505,506},
                                        {188, 216, 244, 500,501,502,503,504,505,506},
                                        {195, 223, 251, 500,501,502,503,504,505,506},
                                        {265, 279, 294, 308, 322, 336, 500,501,502,503},
                                        {272, 286, 301, 315, 329, 343, 500,501,502,503},
                                        {20, 48, 76, 500,501,502,503,504,505,506},
                                        {27, 55, 83, 500,501,502,503,504,505,506},
                                        {104, 132, 160, 500,501,502,503,504,505,506},
                                        {111, 139, 167, 500,501,502,503,504,505,506},
                                        {188, 216, 244, 500,501,502,503,504,505,506},
                                        {195, 223, 251, 500,501,502,503,504,505,506},
                                        {265, 279, 294, 308, 322, 336, 500,501,502,503},
                                        {272, 286, 301, 315, 329, 343, 500,501,502,503},
                                        {20, 48, 76, 500,501,502,503,504,505,506},
                                        {27, 55, 83, 500,501,502,503,504,505,506},
                                        {104, 132, 160, 500,501,502,503,504,505,506},
                                        {111, 139, 167, 500,501,502,503,504,505,506},
                                        {188, 216, 244, 500,501,502,503,504,505,506},
                                        {195, 223, 251, 500,501,502,503,504,505,506},
                                        {265, 279, 294, 308, 322, 336, 500,501,502,503},
                                        {272, 286, 301, 315, 329, 343, 500,501,502,503},
                                        {20, 48, 76, 500,501,502,503,504,505,506},
                                        {27, 55, 83, 500,501,502,503,504,505,506},
                                        {104, 132, 160, 500,501,502,503,504,505,506},
                                        {111, 139, 167, 500,501,502,503,504,505,506},
                                        {188, 216, 244, 500,501,502,503,504,505,506},
                                        {195, 223, 251, 500,501,502,503,504,505,506},
                                        {265, 279, 294, 308, 322, 336, 500,501,502,503},
                                        {272, 286, 301, 315, 329, 343, 500,501,502,503},
                                        {265, 279, 294, 308, 322, 336, 500,501,502,503},
                                        {272, 286, 301, 315, 329, 343, 500,501,502,503}};

parameter Real KrankDauer[:] = {1, 7, 14, 21,28,35,42,500};
parameter Real WkeitKrankDauer[:] = {216 / 456, 147 / 456, 33 / 456, 18 / 456, 15 / 456, 11 / 456, 4 / 456, 12/456};
parameter Real WkeitKrankMonat[12] = {0.0186, 0.0186, 0.0186, 0.0186, 0.0186, 0.0186, 0.0186, 0.0186, 0.0186, 0.0186, 0.0186, 0.0186};





public
  inner PNlib.PN.Components.Settings settings annotation(
   Placement(visible = true, transformation(origin = {306, 290}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Real WkeitKrank = if time <= MonatEnde[1] then WkeitKrankMonat[1] else if time <= MonatEnde[2] then WkeitKrankMonat[2] else if time <= MonatEnde[3] then WkeitKrankMonat[3] else if time <= MonatEnde[4] then WkeitKrankMonat[4] else if time <= MonatEnde[5] then WkeitKrankMonat[5] else if time <= MonatEnde[6] then WkeitKrankMonat[6] else if time <= MonatEnde[7] then WkeitKrankMonat[7] else if time <= MonatEnde[8] then WkeitKrankMonat[8] else if time <= MonatEnde[9] then WkeitKrankMonat[9] else if time <= MonatEnde[10] then WkeitKrankMonat[10] else if time <= MonatEnde[11] then WkeitKrankMonat[11] else WkeitKrankMonat[12];

 FiliP.Station station(nP = AnzahlPersonal, AnzahlSchichten=AnzahlSchichten, SollBesetzung=SollBesetzung, SollBelastung=SollBelastung, PlanKorrektur=PlanKorrektur,a=SchwankungFallgewichtMin, b=SchwankungFallgewichtMax, c=SchwankungFallgewichtMeist, StartTag=StartTag, Schichtzeiten=Schichtzeiten[:,1:2],MessZeit=MessZeit, MessSchwellen=MessSchwellen, SchichtHatPOOL=SchichtHatPOOL,PoolWkeit=PoolWkeit)
 annotation (Placement(visible = true, transformation(extent = {{-20, 20}, {20, 60}}, rotation = 0)));
 FiliP.Pflegekraft pflegekraft1(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2], VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[1,1], StartWochenEnde = PersonalDaten[1,2], DauerWochenEnde = PersonalDaten[1,3], IntervallWochenEnde = PersonalDaten[1,4], IntervallNichtWochenEnde = PersonalDaten[1,7], NichtWochenEnde = NichtWochenEnde[1], StartNichtWochenEnde = PersonalDaten[1,6], UrlaubStartTermine=UrlaubStart[1,:], UrlaubEndTermine=UrlaubEnde[1,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[1,:], SpringtEinInSchicht=SpringtEinInSchicht[1,:]) annotation (
      Placement(visible = true, transformation(extent = {{-60, -80}, {0, -20}}, rotation = 0)));
 FiliP.Pflegekraft pflegekraft2(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[2,1], StartWochenEnde = PersonalDaten[2,2], DauerWochenEnde = PersonalDaten[2,3], IntervallWochenEnde = PersonalDaten[2,4], IntervallNichtWochenEnde = PersonalDaten[2,7], NichtWochenEnde = NichtWochenEnde[2], StartNichtWochenEnde = PersonalDaten[2,6], UrlaubStartTermine=UrlaubStart[2,:], UrlaubEndTermine=UrlaubEnde[2,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[2,:], SpringtEinInSchicht=SpringtEinInSchicht[2,:]) if AnzahlPersonal >1;
 FiliP.Pflegekraft pflegekraft3(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[3,1], StartWochenEnde = PersonalDaten[3,2], DauerWochenEnde = PersonalDaten[3,3], IntervallWochenEnde = PersonalDaten[3,4], IntervallNichtWochenEnde = PersonalDaten[3,7], NichtWochenEnde = NichtWochenEnde[3], StartNichtWochenEnde = PersonalDaten[3,6], UrlaubStartTermine=UrlaubStart[3,:], UrlaubEndTermine=UrlaubEnde[3,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[3,:], SpringtEinInSchicht=SpringtEinInSchicht[3,:]) if AnzahlPersonal >2;
 FiliP.Pflegekraft pflegekraft4(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[4,1], StartWochenEnde = PersonalDaten[4,2], DauerWochenEnde = PersonalDaten[4,3], IntervallWochenEnde = PersonalDaten[4,4], IntervallNichtWochenEnde = PersonalDaten[4,7], NichtWochenEnde = NichtWochenEnde[4], StartNichtWochenEnde = PersonalDaten[4,6], UrlaubStartTermine=UrlaubStart[4,:], UrlaubEndTermine=UrlaubEnde[4,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[4,:], SpringtEinInSchicht=SpringtEinInSchicht[4,:]) if AnzahlPersonal >3;
 FiliP.Pflegekraft pflegekraft5(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[5,1], StartWochenEnde = PersonalDaten[5,2], DauerWochenEnde = PersonalDaten[5,3], IntervallWochenEnde = PersonalDaten[5,4], IntervallNichtWochenEnde = PersonalDaten[5,7], NichtWochenEnde = NichtWochenEnde[5], StartNichtWochenEnde = PersonalDaten[5,6], UrlaubStartTermine=UrlaubStart[5,:], UrlaubEndTermine=UrlaubEnde[5,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[5,:], SpringtEinInSchicht=SpringtEinInSchicht[5,:]) if AnzahlPersonal >4;
 FiliP.Pflegekraft pflegekraft6(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[6,1], StartWochenEnde = PersonalDaten[6,2], DauerWochenEnde = PersonalDaten[6,3], IntervallWochenEnde = PersonalDaten[6,4], IntervallNichtWochenEnde = PersonalDaten[6,7], NichtWochenEnde = NichtWochenEnde[6], StartNichtWochenEnde = PersonalDaten[6,6], UrlaubStartTermine=UrlaubStart[6,:], UrlaubEndTermine=UrlaubEnde[6,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[6,:], SpringtEinInSchicht=SpringtEinInSchicht[6,:]) if AnzahlPersonal >5;
 FiliP.Pflegekraft pflegekraft7(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[7,1], StartWochenEnde = PersonalDaten[7,2], DauerWochenEnde = PersonalDaten[7,3], IntervallWochenEnde = PersonalDaten[7,4], IntervallNichtWochenEnde = PersonalDaten[7,7], NichtWochenEnde = NichtWochenEnde[7], StartNichtWochenEnde = PersonalDaten[7,6], UrlaubStartTermine=UrlaubStart[7,:], UrlaubEndTermine=UrlaubEnde[7,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[7,:], SpringtEinInSchicht=SpringtEinInSchicht[7,:]) if AnzahlPersonal >6;
 FiliP.Pflegekraft pflegekraft8(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[8,1], StartWochenEnde = PersonalDaten[8,2], DauerWochenEnde = PersonalDaten[8,3], IntervallWochenEnde = PersonalDaten[8,4], IntervallNichtWochenEnde = PersonalDaten[8,7], NichtWochenEnde = NichtWochenEnde[8], StartNichtWochenEnde = PersonalDaten[8,6], UrlaubStartTermine=UrlaubStart[8,:], UrlaubEndTermine=UrlaubEnde[8,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[8,:], SpringtEinInSchicht=SpringtEinInSchicht[8,:]) if AnzahlPersonal >7;
//
 FiliP.Pflegekraft pflegekraft9(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[9,1], StartWochenEnde = PersonalDaten[9,2], DauerWochenEnde = PersonalDaten[9,3], IntervallWochenEnde = PersonalDaten[9,4], IntervallNichtWochenEnde = PersonalDaten[9,7], NichtWochenEnde = NichtWochenEnde[9], StartNichtWochenEnde = PersonalDaten[9,6], UrlaubStartTermine=UrlaubStart[9,:], UrlaubEndTermine=UrlaubEnde[9,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[9,:], SpringtEinInSchicht=SpringtEinInSchicht[9,:]) if AnzahlPersonal >8;
 FiliP.Pflegekraft pflegekraft10(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[10,1], StartWochenEnde = PersonalDaten[10,2], DauerWochenEnde = PersonalDaten[10,3], IntervallWochenEnde = PersonalDaten[10,4], IntervallNichtWochenEnde = PersonalDaten[10,7], NichtWochenEnde = NichtWochenEnde[10], StartNichtWochenEnde = PersonalDaten[10,6], UrlaubStartTermine=UrlaubStart[10,:], UrlaubEndTermine=UrlaubEnde[10,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[10,:], SpringtEinInSchicht=SpringtEinInSchicht[10,:]) if AnzahlPersonal >9;
 FiliP.Pflegekraft pflegekraft11(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[11,1], StartWochenEnde = PersonalDaten[11,2], DauerWochenEnde = PersonalDaten[11,3], IntervallWochenEnde = PersonalDaten[11,4], IntervallNichtWochenEnde = PersonalDaten[11,7], NichtWochenEnde = NichtWochenEnde[11], StartNichtWochenEnde = PersonalDaten[11,6], UrlaubStartTermine=UrlaubStart[11,:], UrlaubEndTermine=UrlaubEnde[11,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[11,:], SpringtEinInSchicht=SpringtEinInSchicht[11,:]) if AnzahlPersonal >10;
 FiliP.Pflegekraft pflegekraft12(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[12,1], StartWochenEnde = PersonalDaten[12,2], DauerWochenEnde = PersonalDaten[12,3], IntervallWochenEnde = PersonalDaten[12,4], IntervallNichtWochenEnde = PersonalDaten[12,7], NichtWochenEnde = NichtWochenEnde[12], StartNichtWochenEnde = PersonalDaten[12,6], UrlaubStartTermine=UrlaubStart[12,:], UrlaubEndTermine=UrlaubEnde[12,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[12,:], SpringtEinInSchicht=SpringtEinInSchicht[12,:]) if AnzahlPersonal >11;
 FiliP.Pflegekraft pflegekraft13(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[13,1], StartWochenEnde = PersonalDaten[13,2], DauerWochenEnde = PersonalDaten[13,3], IntervallWochenEnde = PersonalDaten[13,4], IntervallNichtWochenEnde = PersonalDaten[13,7], NichtWochenEnde = NichtWochenEnde[13], StartNichtWochenEnde = PersonalDaten[13,6], UrlaubStartTermine=UrlaubStart[13,:], UrlaubEndTermine=UrlaubEnde[13,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[13,:], SpringtEinInSchicht=SpringtEinInSchicht[13,:]) if AnzahlPersonal >12;
 FiliP.Pflegekraft pflegekraft14(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[14,1], StartWochenEnde = PersonalDaten[14,2], DauerWochenEnde = PersonalDaten[14,3], IntervallWochenEnde = PersonalDaten[14,4], IntervallNichtWochenEnde = PersonalDaten[14,7], NichtWochenEnde = NichtWochenEnde[14], StartNichtWochenEnde = PersonalDaten[14,6], UrlaubStartTermine=UrlaubStart[14,:], UrlaubEndTermine=UrlaubEnde[14,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[14,:], SpringtEinInSchicht=SpringtEinInSchicht[14,:]) if AnzahlPersonal >13;
 FiliP.Pflegekraft pflegekraft15(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[15,1], StartWochenEnde = PersonalDaten[15,2], DauerWochenEnde = PersonalDaten[15,3], IntervallWochenEnde = PersonalDaten[15,4], IntervallNichtWochenEnde = PersonalDaten[15,7], NichtWochenEnde = NichtWochenEnde[15], StartNichtWochenEnde = PersonalDaten[15,6], UrlaubStartTermine=UrlaubStart[15,:], UrlaubEndTermine=UrlaubEnde[15,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[15,:], SpringtEinInSchicht=SpringtEinInSchicht[15,:]) if AnzahlPersonal >14;
 FiliP.Pflegekraft pflegekraft16(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[16,1], StartWochenEnde = PersonalDaten[16,2], DauerWochenEnde = PersonalDaten[16,3], IntervallWochenEnde = PersonalDaten[16,4], IntervallNichtWochenEnde = PersonalDaten[16,7], NichtWochenEnde = NichtWochenEnde[16], StartNichtWochenEnde = PersonalDaten[16,6], UrlaubStartTermine=UrlaubStart[16,:], UrlaubEndTermine=UrlaubEnde[16,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[16,:], SpringtEinInSchicht=SpringtEinInSchicht[16,:]) if AnzahlPersonal >15;
//
 FiliP.Pflegekraft pflegekraft17(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[17,1], StartWochenEnde = PersonalDaten[17,2], DauerWochenEnde = PersonalDaten[17,3], IntervallWochenEnde = PersonalDaten[17,4], IntervallNichtWochenEnde = PersonalDaten[17,7], NichtWochenEnde = NichtWochenEnde[17], StartNichtWochenEnde = PersonalDaten[17,6], UrlaubStartTermine=UrlaubStart[17,:], UrlaubEndTermine=UrlaubEnde[17,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[17,:], SpringtEinInSchicht=SpringtEinInSchicht[17,:]) if AnzahlPersonal >16;
 FiliP.Pflegekraft pflegekraft18(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[18,1], StartWochenEnde = PersonalDaten[18,2], DauerWochenEnde = PersonalDaten[18,3], IntervallWochenEnde = PersonalDaten[18,4], IntervallNichtWochenEnde = PersonalDaten[18,7], NichtWochenEnde = NichtWochenEnde[18], StartNichtWochenEnde = PersonalDaten[18,6], UrlaubStartTermine=UrlaubStart[18,:], UrlaubEndTermine=UrlaubEnde[18,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[18,:], SpringtEinInSchicht=SpringtEinInSchicht[18,:]) if AnzahlPersonal >17;
 FiliP.Pflegekraft pflegekraft19(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[19,1], StartWochenEnde = PersonalDaten[19,2], DauerWochenEnde = PersonalDaten[19,3], IntervallWochenEnde = PersonalDaten[19,4], IntervallNichtWochenEnde = PersonalDaten[19,7], NichtWochenEnde = NichtWochenEnde[19], StartNichtWochenEnde = PersonalDaten[19,6], UrlaubStartTermine=UrlaubStart[19,:], UrlaubEndTermine=UrlaubEnde[19,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[19,:], SpringtEinInSchicht=SpringtEinInSchicht[19,:]) if AnzahlPersonal >18;
 FiliP.Pflegekraft pflegekraft20(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[20,1], StartWochenEnde = PersonalDaten[20,2], DauerWochenEnde = PersonalDaten[20,3], IntervallWochenEnde = PersonalDaten[20,4], IntervallNichtWochenEnde = PersonalDaten[20,7], NichtWochenEnde = NichtWochenEnde[20], StartNichtWochenEnde = PersonalDaten[20,6], UrlaubStartTermine=UrlaubStart[20,:], UrlaubEndTermine=UrlaubEnde[20,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[20,:], SpringtEinInSchicht=SpringtEinInSchicht[20,:]) if AnzahlPersonal >19;
 FiliP.Pflegekraft pflegekraft21(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[21,1], StartWochenEnde = PersonalDaten[21,2], DauerWochenEnde = PersonalDaten[21,3], IntervallWochenEnde = PersonalDaten[21,4], IntervallNichtWochenEnde = PersonalDaten[21,7], NichtWochenEnde = NichtWochenEnde[21], StartNichtWochenEnde = PersonalDaten[21,6], UrlaubStartTermine=UrlaubStart[21,:], UrlaubEndTermine=UrlaubEnde[21,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[21,:], SpringtEinInSchicht=SpringtEinInSchicht[21,:]) if AnzahlPersonal >20;
 FiliP.Pflegekraft pflegekraft22(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[22,1], StartWochenEnde = PersonalDaten[22,2], DauerWochenEnde = PersonalDaten[22,3], IntervallWochenEnde = PersonalDaten[22,4], IntervallNichtWochenEnde = PersonalDaten[22,7], NichtWochenEnde = NichtWochenEnde[22], StartNichtWochenEnde = PersonalDaten[22,6], UrlaubStartTermine=UrlaubStart[22,:], UrlaubEndTermine=UrlaubEnde[22,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[22,:], SpringtEinInSchicht=SpringtEinInSchicht[22,:]) if AnzahlPersonal >21;
 FiliP.Pflegekraft pflegekraft23(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[23,1], StartWochenEnde = PersonalDaten[23,2], DauerWochenEnde = PersonalDaten[23,3], IntervallWochenEnde = PersonalDaten[23,4], IntervallNichtWochenEnde = PersonalDaten[23,7], NichtWochenEnde = NichtWochenEnde[23], StartNichtWochenEnde = PersonalDaten[23,6], UrlaubStartTermine=UrlaubStart[23,:], UrlaubEndTermine=UrlaubEnde[23,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[23,:], SpringtEinInSchicht=SpringtEinInSchicht[23,:]) if AnzahlPersonal >22;
 FiliP.Pflegekraft pflegekraft24(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[24,1], StartWochenEnde = PersonalDaten[24,2], DauerWochenEnde = PersonalDaten[24,3], IntervallWochenEnde = PersonalDaten[24,4], IntervallNichtWochenEnde = PersonalDaten[24,7], NichtWochenEnde = NichtWochenEnde[24], StartNichtWochenEnde = PersonalDaten[24,6], UrlaubStartTermine=UrlaubStart[24,:], UrlaubEndTermine=UrlaubEnde[24,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[24,:], SpringtEinInSchicht=SpringtEinInSchicht[24,:]) if AnzahlPersonal >23;
 //
FiliP.Pflegekraft pflegekraft25(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[25,1], StartWochenEnde = PersonalDaten[25,2], DauerWochenEnde = PersonalDaten[25,3], IntervallWochenEnde = PersonalDaten[25,4], IntervallNichtWochenEnde = PersonalDaten[25,7], NichtWochenEnde = NichtWochenEnde[25], StartNichtWochenEnde = PersonalDaten[25,6], UrlaubStartTermine=UrlaubStart[25,:], UrlaubEndTermine=UrlaubEnde[25,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[25,:], SpringtEinInSchicht=SpringtEinInSchicht[25,:]) if AnzahlPersonal >24;
FiliP.Pflegekraft pflegekraft26(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[26,1], StartWochenEnde = PersonalDaten[26,2], DauerWochenEnde = PersonalDaten[26,3], IntervallWochenEnde = PersonalDaten[26,4], IntervallNichtWochenEnde = PersonalDaten[26,7], NichtWochenEnde = NichtWochenEnde[26], StartNichtWochenEnde = PersonalDaten[26,6], UrlaubStartTermine=UrlaubStart[26,:], UrlaubEndTermine=UrlaubEnde[26,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[26,:], SpringtEinInSchicht=SpringtEinInSchicht[26,:]) if AnzahlPersonal >25;
FiliP.Pflegekraft pflegekraft27(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[27,1], StartWochenEnde = PersonalDaten[27,2], DauerWochenEnde = PersonalDaten[27,3], IntervallWochenEnde = PersonalDaten[27,4], IntervallNichtWochenEnde = PersonalDaten[27,7], NichtWochenEnde = NichtWochenEnde[27], StartNichtWochenEnde = PersonalDaten[27,6], UrlaubStartTermine=UrlaubStart[27,:], UrlaubEndTermine=UrlaubEnde[27,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[27,:], SpringtEinInSchicht=SpringtEinInSchicht[27,:]) if AnzahlPersonal >26;
FiliP.Pflegekraft pflegekraft28(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[28,1], StartWochenEnde = PersonalDaten[28,2], DauerWochenEnde = PersonalDaten[28,3], IntervallWochenEnde = PersonalDaten[28,4], IntervallNichtWochenEnde = PersonalDaten[28,7], NichtWochenEnde = NichtWochenEnde[28], StartNichtWochenEnde = PersonalDaten[28,6], UrlaubStartTermine=UrlaubStart[28,:], UrlaubEndTermine=UrlaubEnde[28,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[28,:], SpringtEinInSchicht=SpringtEinInSchicht[28,:]) if AnzahlPersonal >27;
FiliP.Pflegekraft pflegekraft29(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[29,1], StartWochenEnde = PersonalDaten[29,2], DauerWochenEnde = PersonalDaten[29,3], IntervallWochenEnde = PersonalDaten[29,4], IntervallNichtWochenEnde = PersonalDaten[29,7], NichtWochenEnde = NichtWochenEnde[29], StartNichtWochenEnde = PersonalDaten[29,6], UrlaubStartTermine=UrlaubStart[29,:], UrlaubEndTermine=UrlaubEnde[29,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[29,:], SpringtEinInSchicht=SpringtEinInSchicht[29,:]) if AnzahlPersonal >28;
FiliP.Pflegekraft pflegekraft30(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[30,1], StartWochenEnde = PersonalDaten[30,2], DauerWochenEnde = PersonalDaten[30,3], IntervallWochenEnde = PersonalDaten[30,4], IntervallNichtWochenEnde = PersonalDaten[30,7], NichtWochenEnde = NichtWochenEnde[30], StartNichtWochenEnde = PersonalDaten[30,6], UrlaubStartTermine=UrlaubStart[30,:], UrlaubEndTermine=UrlaubEnde[30,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[30,:], SpringtEinInSchicht=SpringtEinInSchicht[30,:]) if AnzahlPersonal >29;
FiliP.Pflegekraft pflegekraft31(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[31,1], StartWochenEnde = PersonalDaten[31,2], DauerWochenEnde = PersonalDaten[31,3], IntervallWochenEnde = PersonalDaten[31,4], IntervallNichtWochenEnde = PersonalDaten[31,7], NichtWochenEnde = NichtWochenEnde[31], StartNichtWochenEnde = PersonalDaten[31,6], UrlaubStartTermine=UrlaubStart[31,:], UrlaubEndTermine=UrlaubEnde[31,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[31,:], SpringtEinInSchicht=SpringtEinInSchicht[31,:]) if AnzahlPersonal >30;
FiliP.Pflegekraft pflegekraft32(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[32,1], StartWochenEnde = PersonalDaten[32,2], DauerWochenEnde = PersonalDaten[32,3], IntervallWochenEnde = PersonalDaten[32,4], IntervallNichtWochenEnde = PersonalDaten[32,7], NichtWochenEnde = NichtWochenEnde[32], StartNichtWochenEnde = PersonalDaten[32,6], UrlaubStartTermine=UrlaubStart[32,:], UrlaubEndTermine=UrlaubEnde[32,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[32,:], SpringtEinInSchicht=SpringtEinInSchicht[32,:]) if AnzahlPersonal >31;
//
FiliP.Pflegekraft pflegekraft33(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[33,1], StartWochenEnde = PersonalDaten[33,2], DauerWochenEnde = PersonalDaten[33,3], IntervallWochenEnde = PersonalDaten[33,4], IntervallNichtWochenEnde = PersonalDaten[33,7], NichtWochenEnde = NichtWochenEnde[33], StartNichtWochenEnde = PersonalDaten[33,6], UrlaubStartTermine=UrlaubStart[33,:], UrlaubEndTermine=UrlaubEnde[33,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[33,:], SpringtEinInSchicht=SpringtEinInSchicht[33,:]) if AnzahlPersonal >32;
FiliP.Pflegekraft pflegekraft34(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[34,1], StartWochenEnde = PersonalDaten[34,2], DauerWochenEnde = PersonalDaten[34,3], IntervallWochenEnde = PersonalDaten[34,4], IntervallNichtWochenEnde = PersonalDaten[34,7], NichtWochenEnde = NichtWochenEnde[34], StartNichtWochenEnde = PersonalDaten[34,6], UrlaubStartTermine=UrlaubStart[34,:], UrlaubEndTermine=UrlaubEnde[34,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[34,:], SpringtEinInSchicht=SpringtEinInSchicht[34,:]) if AnzahlPersonal >33;
FiliP.Pflegekraft pflegekraft35(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[35,1], StartWochenEnde = PersonalDaten[35,2], DauerWochenEnde = PersonalDaten[35,3], IntervallWochenEnde = PersonalDaten[35,4], IntervallNichtWochenEnde = PersonalDaten[35,7], NichtWochenEnde = NichtWochenEnde[35], StartNichtWochenEnde = PersonalDaten[35,6], UrlaubStartTermine=UrlaubStart[35,:], UrlaubEndTermine=UrlaubEnde[35,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[35,:], SpringtEinInSchicht=SpringtEinInSchicht[35,:]) if AnzahlPersonal >34;
FiliP.Pflegekraft pflegekraft36(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[36,1], StartWochenEnde = PersonalDaten[36,2], DauerWochenEnde = PersonalDaten[36,3], IntervallWochenEnde = PersonalDaten[36,4], IntervallNichtWochenEnde = PersonalDaten[36,7], NichtWochenEnde = NichtWochenEnde[36], StartNichtWochenEnde = PersonalDaten[36,6], UrlaubStartTermine=UrlaubStart[36,:], UrlaubEndTermine=UrlaubEnde[36,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[36,:], SpringtEinInSchicht=SpringtEinInSchicht[36,:]) if AnzahlPersonal >35;
FiliP.Pflegekraft pflegekraft37(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[37,1], StartWochenEnde = PersonalDaten[37,2], DauerWochenEnde = PersonalDaten[37,3], IntervallWochenEnde = PersonalDaten[37,4], IntervallNichtWochenEnde = PersonalDaten[37,7], NichtWochenEnde = NichtWochenEnde[37], StartNichtWochenEnde = PersonalDaten[37,6], UrlaubStartTermine=UrlaubStart[37,:], UrlaubEndTermine=UrlaubEnde[37,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[37,:], SpringtEinInSchicht=SpringtEinInSchicht[37,:]) if AnzahlPersonal >36;
FiliP.Pflegekraft pflegekraft38(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[38,1], StartWochenEnde = PersonalDaten[38,2], DauerWochenEnde = PersonalDaten[38,3], IntervallWochenEnde = PersonalDaten[38,4], IntervallNichtWochenEnde = PersonalDaten[38,7], NichtWochenEnde = NichtWochenEnde[38], StartNichtWochenEnde = PersonalDaten[38,6], UrlaubStartTermine=UrlaubStart[38,:], UrlaubEndTermine=UrlaubEnde[38,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[38,:], SpringtEinInSchicht=SpringtEinInSchicht[38,:]) if AnzahlPersonal >37;
FiliP.Pflegekraft pflegekraft39(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[39,1], StartWochenEnde = PersonalDaten[39,2], DauerWochenEnde = PersonalDaten[39,3], IntervallWochenEnde = PersonalDaten[39,4], IntervallNichtWochenEnde = PersonalDaten[39,7], NichtWochenEnde = NichtWochenEnde[39], StartNichtWochenEnde = PersonalDaten[39,6], UrlaubStartTermine=UrlaubStart[39,:], UrlaubEndTermine=UrlaubEnde[39,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[39,:], SpringtEinInSchicht=SpringtEinInSchicht[39,:]) if AnzahlPersonal >38;
FiliP.Pflegekraft pflegekraft40(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[40,1], StartWochenEnde = PersonalDaten[40,2], DauerWochenEnde = PersonalDaten[40,3], IntervallWochenEnde = PersonalDaten[40,4], IntervallNichtWochenEnde = PersonalDaten[40,7], NichtWochenEnde = NichtWochenEnde[40], StartNichtWochenEnde = PersonalDaten[40,6], UrlaubStartTermine=UrlaubStart[40,:], UrlaubEndTermine=UrlaubEnde[40,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[40,:], SpringtEinInSchicht=SpringtEinInSchicht[40,:]) if AnzahlPersonal >39;
//
 FiliP.Pflegekraft pflegekraft41(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[41,1], StartWochenEnde = PersonalDaten[41,2], DauerWochenEnde = PersonalDaten[41,3], IntervallWochenEnde = PersonalDaten[41,4], IntervallNichtWochenEnde = PersonalDaten[41,7], NichtWochenEnde = NichtWochenEnde[41], StartNichtWochenEnde = PersonalDaten[41,6], UrlaubStartTermine=UrlaubStart[41,:], UrlaubEndTermine=UrlaubEnde[41,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[41,:], SpringtEinInSchicht=SpringtEinInSchicht[41,:]) if AnzahlPersonal >40;
 FiliP.Pflegekraft pflegekraft42(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[42,1], StartWochenEnde = PersonalDaten[42,2], DauerWochenEnde = PersonalDaten[42,3], IntervallWochenEnde = PersonalDaten[42,4], IntervallNichtWochenEnde = PersonalDaten[42,7], NichtWochenEnde = NichtWochenEnde[42], StartNichtWochenEnde = PersonalDaten[42,6], UrlaubStartTermine=UrlaubStart[42,:], UrlaubEndTermine=UrlaubEnde[42,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[42,:], SpringtEinInSchicht=SpringtEinInSchicht[42,:]) if AnzahlPersonal >41;
 FiliP.Pflegekraft pflegekraft43(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[43,1], StartWochenEnde = PersonalDaten[43,2], DauerWochenEnde = PersonalDaten[43,3], IntervallWochenEnde = PersonalDaten[43,4], IntervallNichtWochenEnde = PersonalDaten[43,7], NichtWochenEnde = NichtWochenEnde[43], StartNichtWochenEnde = PersonalDaten[43,6], UrlaubStartTermine=UrlaubStart[43,:], UrlaubEndTermine=UrlaubEnde[43,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[43,:], SpringtEinInSchicht=SpringtEinInSchicht[43,:]) if AnzahlPersonal >42;
 FiliP.Pflegekraft pflegekraft44(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[44,1], StartWochenEnde = PersonalDaten[44,2], DauerWochenEnde = PersonalDaten[44,3], IntervallWochenEnde = PersonalDaten[44,4], IntervallNichtWochenEnde = PersonalDaten[44,7], NichtWochenEnde = NichtWochenEnde[44], StartNichtWochenEnde = PersonalDaten[44,6], UrlaubStartTermine=UrlaubStart[44,:], UrlaubEndTermine=UrlaubEnde[44,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[44,:], SpringtEinInSchicht=SpringtEinInSchicht[44,:]) if AnzahlPersonal >43;
 FiliP.Pflegekraft pflegekraft45(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[45,1], StartWochenEnde = PersonalDaten[45,2], DauerWochenEnde = PersonalDaten[45,3], IntervallWochenEnde = PersonalDaten[45,4], IntervallNichtWochenEnde = PersonalDaten[45,7], NichtWochenEnde = NichtWochenEnde[45], StartNichtWochenEnde = PersonalDaten[45,6], UrlaubStartTermine=UrlaubStart[45,:], UrlaubEndTermine=UrlaubEnde[45,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[45,:], SpringtEinInSchicht=SpringtEinInSchicht[45,:]) if AnzahlPersonal >44;
 FiliP.Pflegekraft pflegekraft46(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[46,1], StartWochenEnde = PersonalDaten[46,2], DauerWochenEnde = PersonalDaten[46,3], IntervallWochenEnde = PersonalDaten[46,4], IntervallNichtWochenEnde = PersonalDaten[46,7], NichtWochenEnde = NichtWochenEnde[46], StartNichtWochenEnde = PersonalDaten[46,6], UrlaubStartTermine=UrlaubStart[46,:], UrlaubEndTermine=UrlaubEnde[46,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[46,:], SpringtEinInSchicht=SpringtEinInSchicht[46,:]) if AnzahlPersonal >45;
 FiliP.Pflegekraft pflegekraft47(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[47,1], StartWochenEnde = PersonalDaten[47,2], DauerWochenEnde = PersonalDaten[47,3], IntervallWochenEnde = PersonalDaten[47,4], IntervallNichtWochenEnde = PersonalDaten[47,7], NichtWochenEnde = NichtWochenEnde[47], StartNichtWochenEnde = PersonalDaten[47,6], UrlaubStartTermine=UrlaubStart[47,:], UrlaubEndTermine=UrlaubEnde[47,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[47,:], SpringtEinInSchicht=SpringtEinInSchicht[47,:]) if AnzahlPersonal >46;
 FiliP.Pflegekraft pflegekraft48(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[48,1], StartWochenEnde = PersonalDaten[48,2], DauerWochenEnde = PersonalDaten[48,3], IntervallWochenEnde = PersonalDaten[48,4], IntervallNichtWochenEnde = PersonalDaten[48,7], NichtWochenEnde = NichtWochenEnde[48], StartNichtWochenEnde = PersonalDaten[48,6], UrlaubStartTermine=UrlaubStart[48,:], UrlaubEndTermine=UrlaubEnde[48,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[48,:], SpringtEinInSchicht=SpringtEinInSchicht[48,:]) if AnzahlPersonal >47;
//
 FiliP.Pflegekraft pflegekraft49(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[49,1], StartWochenEnde = PersonalDaten[49,2], DauerWochenEnde = PersonalDaten[49,3], IntervallWochenEnde = PersonalDaten[49,4], IntervallNichtWochenEnde = PersonalDaten[49,7], NichtWochenEnde = NichtWochenEnde[49], StartNichtWochenEnde = PersonalDaten[49,6], UrlaubStartTermine=UrlaubStart[49,:], UrlaubEndTermine=UrlaubEnde[49,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[49,:], SpringtEinInSchicht=SpringtEinInSchicht[49,:]) if AnzahlPersonal >48;
 FiliP.Pflegekraft pflegekraft50(AnzahlSchichten=AnzahlSchichten, Schichtzeiten=Schichtzeiten, MessZeit=MessZeit[2],  VKstundenWoche=VKstundenWoche, Stelle=PersonalDaten[50,1], StartWochenEnde = PersonalDaten[50,2], DauerWochenEnde = PersonalDaten[50,3], IntervallWochenEnde = PersonalDaten[50,4], IntervallNichtWochenEnde = PersonalDaten[50,7], NichtWochenEnde = NichtWochenEnde[50], StartNichtWochenEnde = PersonalDaten[50,6], UrlaubStartTermine=UrlaubStart[50,:], UrlaubEndTermine=UrlaubEnde[50,:], WkeitKrankDauer=WkeitKrankDauer, KrankDauer=KrankDauer, WkeitKrank = WkeitKrank, KannInSchichtArbeiten=KannInSchichtArbeiten[50,:], SpringtEinInSchicht=SpringtEinInSchicht[50,:]) if AnzahlPersonal >49;







  equation
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
end for

//////////////////////////////////////////////////////////////////////////////
    annotation(
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-400, -400}, {400, 400}}, initialScale = 0.1)),
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}))/*,
    experiment(StartTime = 0, StopTime = 365, Tolerance = 1e-06)*/);
  end TestStation;
