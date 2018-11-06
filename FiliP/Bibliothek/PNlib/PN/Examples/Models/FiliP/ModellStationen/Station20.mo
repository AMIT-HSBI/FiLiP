within PNlib.PN.Examples.Models.FiliP.ModellStationen;
model Station20
  extends Modelica.Icons.Example;
  extends PNlib.PN.Examples.Models.FiliP.AllgemeineParameter;
    PNlib.PN.Examples.Models.FiliP.Station station(nP = 20, APFD = 4, APSD = 3, APND = 1) annotation(
      Placement(visible = true, transformation(extent = {{-48, 268}, {-8, 308}}, rotation = 0)));
  inner PNlib.PN.Components.Settings settings annotation(
    Placement(visible = true, transformation(origin = {306, 290}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

    PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft1(Stelle = 0.75) annotation(
      Placement(visible = true, transformation(extent = {{-324, 54}, {-264, 114}}, rotation = 0)));
    PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft2(Stelle = 0.9) annotation(
      Placement(visible = true, transformation(extent = {{-322, -50}, {-262, 10}}, rotation = 0)));
    PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft3(Stelle = 0.51) annotation(
      Placement(visible = true, transformation(extent = {{-322, -146}, {-262, -86}}, rotation = 0)));
    PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft4(Stelle = 0.5, WEF = 2) annotation(
      Placement(visible = true, transformation(extent = {{-316, -244}, {-256, -184}}, rotation = 0)));
    PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft5(Stelle = 1, WEF = 2) annotation(
      Placement(visible = true, transformation(extent = {{-182, 64}, {-122, 124}}, rotation = 0)));
    PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft6(Stelle = 0.41) annotation(
      Placement(visible = true, transformation(extent = {{-182, -36}, {-122, 24}}, rotation = 0)));
    PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft7(Stelle = 0.35, WEF = 2) annotation(
      Placement(visible = true, transformation(extent = {{-182, -132}, {-122, -72}}, rotation = 0)));
    PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft8(Stelle = 0.5) annotation(
      Placement(visible = true, transformation(extent = {{-176, -230}, {-116, -170}}, rotation = 0)));
    PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft9(Stelle = 0.5) annotation(
      Placement(visible = true, transformation(extent = {{-48, 58}, {12, 118}}, rotation = 0)));
    PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft10(Stelle = 1, WEF = 2) annotation(
      Placement(visible = true, transformation(extent = {{-46, -42}, {14, 18}}, rotation = 0)));
    PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft11(Stelle = 0.8) annotation(
      Placement(visible = true, transformation(extent = {{-46, -138}, {14, -78}}, rotation = 0)));
    PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft12(Stelle = 0.75, WEF = 2) annotation(
      Placement(visible = true, transformation(extent = {{-40, -236}, {20, -176}}, rotation = 0)));
    PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft13(Stelle = 1, WEF = 2) annotation(
      Placement(visible = true, transformation(extent = {{100, 50}, {160, 110}}, rotation = 0)));
    PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft14(Stelle = 0.5) annotation(
      Placement(visible = true, transformation(extent = {{102, -50}, {162, 10}}, rotation = 0)));
    PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft15(Stelle = 0.35) annotation(
      Placement(visible = true, transformation(extent = {{102, -146}, {162, -86}}, rotation = 0)));
    PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft16(Stelle = 0.75) annotation(
      Placement(visible = true, transformation(extent = {{108, -244}, {168, -184}}, rotation = 0)));
    PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft17(Stelle = 1, WEF = 2) annotation(
      Placement(visible = true, transformation(extent = {{284, 44}, {344, 104}}, rotation = 0)));
    PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft18(Stelle = 1) annotation(
      Placement(visible = true, transformation(extent = {{286, -56}, {346, 4}}, rotation = 0)));
    PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft19(Stelle = 1, WEF = 2) annotation(
      Placement(visible = true, transformation(extent = {{286, -152}, {346, -92}}, rotation = 0)));
    PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft20(Stelle = 1, WEF = 2) annotation(
      Placement(visible = true, transformation(extent = {{292, -252}, {352, -192}}, rotation = 0)));
  equation

    connect(station.placeInDis[60], pflegekraft20.transitionOutDis[3]);
    connect(station.placeInDis[59], pflegekraft20.transitionOutDis[2]);
    connect(station.placeInDis[58], pflegekraft20.transitionOutDis[1]);
    connect(station.placeInDis[57], pflegekraft19.transitionOutDis[3]);
    connect(station.placeInDis[56], pflegekraft19.transitionOutDis[2]);
    connect(station.placeInDis[55], pflegekraft19.transitionOutDis[1]);
    connect(station.placeInDis[54], pflegekraft18.transitionOutDis[3]);
    connect(station.placeInDis[53], pflegekraft18.transitionOutDis[2]);
    connect(station.placeInDis[52], pflegekraft18.transitionOutDis[1]);
    connect(station.placeInDis[51], pflegekraft17.transitionOutDis[3]);
    connect(station.placeInDis[50], pflegekraft17.transitionOutDis[2]);
    connect(station.placeInDis[49], pflegekraft17.transitionOutDis[1]);
    connect(station.placeInDis[48], pflegekraft16.transitionOutDis[3]);
    connect(station.placeInDis[47], pflegekraft16.transitionOutDis[2]);
    connect(station.placeInDis[46], pflegekraft16.transitionOutDis[1]);
    connect(station.placeInDis[45], pflegekraft15.transitionOutDis[3]);
    connect(station.placeInDis[44], pflegekraft15.transitionOutDis[2]);
    connect(station.placeInDis[43], pflegekraft15.transitionOutDis[1]);
    connect(station.placeInDis[42], pflegekraft14.transitionOutDis[3]);
    connect(station.placeInDis[41], pflegekraft14.transitionOutDis[2]);
    connect(station.placeInDis[40], pflegekraft14.transitionOutDis[1]);
    connect(station.placeInDis[39], pflegekraft13.transitionOutDis[3]);
    connect(station.placeInDis[38], pflegekraft13.transitionOutDis[2]);
    connect(station.placeInDis[37], pflegekraft13.transitionOutDis[1]);
    connect(station.placeInDis[36], pflegekraft12.transitionOutDis[3]);
    connect(station.placeInDis[35], pflegekraft12.transitionOutDis[2]);
    connect(station.placeInDis[34], pflegekraft12.transitionOutDis[1]);
    connect(station.placeInDis[33], pflegekraft11.transitionOutDis[3]);
    connect(station.placeInDis[32], pflegekraft11.transitionOutDis[2]);
    connect(station.placeInDis[31], pflegekraft11.transitionOutDis[1]);
    connect(station.placeInDis[30], pflegekraft10.transitionOutDis[3]);
    connect(station.placeInDis[29], pflegekraft10.transitionOutDis[2]);
    connect(station.placeInDis[28], pflegekraft10.transitionOutDis[1]);
    connect(station.placeInDis[27], pflegekraft9.transitionOutDis[3]);
    connect(station.placeInDis[26], pflegekraft9.transitionOutDis[2]);
    connect(station.placeInDis[25], pflegekraft9.transitionOutDis[1]);
    connect(station.placeInDis[24], pflegekraft8.transitionOutDis[3]);
    connect(station.placeInDis[23], pflegekraft8.transitionOutDis[2]);
    connect(station.placeInDis[22], pflegekraft8.transitionOutDis[1]);
    connect(station.placeInDis[21], pflegekraft7.transitionOutDis[3]);
    connect(station.placeInDis[20], pflegekraft7.transitionOutDis[2]);
    connect(station.placeInDis[19], pflegekraft7.transitionOutDis[1]);
    connect(station.placeInDis[18], pflegekraft6.transitionOutDis[3]);
    connect(station.placeInDis[17], pflegekraft6.transitionOutDis[2]);
    connect(station.placeInDis[16], pflegekraft6.transitionOutDis[1]);
    connect(station.placeInDis[15], pflegekraft5.transitionOutDis[3]);
    connect(station.placeInDis[14], pflegekraft5.transitionOutDis[2]);
    connect(station.placeInDis[13], pflegekraft5.transitionOutDis[1]);
    connect(station.placeInDis[12], pflegekraft4.transitionOutDis[3]);
    connect(station.placeInDis[11], pflegekraft4.transitionOutDis[2]);
    connect(station.placeInDis[10], pflegekraft4.transitionOutDis[1]);
    connect(station.placeInDis[9], pflegekraft3.transitionOutDis[3]);
    connect(station.placeInDis[8], pflegekraft3.transitionOutDis[2]);
    connect(station.placeInDis[7], pflegekraft3.transitionOutDis[1]);
    connect(station.placeInDis[6], pflegekraft2.transitionOutDis[3]);
    connect(station.placeInDis[5], pflegekraft2.transitionOutDis[2]);
    connect(station.placeInDis[4], pflegekraft2.transitionOutDis[1]);
    connect(station.placeInDis[3], pflegekraft1.transitionOutDis[3]);
    connect(station.placeInDis[2], pflegekraft1.transitionOutDis[2]);
    connect(station.placeInDis[1], pflegekraft1.transitionOutDis[1]);



    connect(station.placeOutDis[60], pflegekraft20.transitionInDis[3]);
    connect(station.placeOutDis[59], pflegekraft20.transitionInDis[2]);
    connect(station.placeOutDis[58], pflegekraft20.transitionInDis[1]);
    connect(station.placeOutDis[57], pflegekraft19.transitionInDis[3]);
    connect(station.placeOutDis[56], pflegekraft19.transitionInDis[2]);
    connect(station.placeOutDis[55], pflegekraft19.transitionInDis[1]);
    connect(station.placeOutDis[54], pflegekraft18.transitionInDis[3]);
    connect(station.placeOutDis[53], pflegekraft18.transitionInDis[2]);
    connect(station.placeOutDis[52], pflegekraft18.transitionInDis[1]);
    connect(station.placeOutDis[51], pflegekraft17.transitionInDis[3]);
    connect(station.placeOutDis[50], pflegekraft17.transitionInDis[2]);
    connect(station.placeOutDis[49], pflegekraft17.transitionInDis[1]);
    connect(station.placeOutDis[48], pflegekraft16.transitionInDis[3]);
    connect(station.placeOutDis[47], pflegekraft16.transitionInDis[2]);
    connect(station.placeOutDis[46], pflegekraft16.transitionInDis[1]);
    connect(station.placeOutDis[45], pflegekraft15.transitionInDis[3]);
    connect(station.placeOutDis[44], pflegekraft15.transitionInDis[2]);
    connect(station.placeOutDis[43], pflegekraft15.transitionInDis[1]);
    connect(station.placeOutDis[42], pflegekraft14.transitionInDis[3]);
    connect(station.placeOutDis[41], pflegekraft14.transitionInDis[2]);
    connect(station.placeOutDis[40], pflegekraft14.transitionInDis[1]);
    connect(station.placeOutDis[39], pflegekraft13.transitionInDis[3]);
    connect(station.placeOutDis[38], pflegekraft13.transitionInDis[2]);
    connect(station.placeOutDis[37], pflegekraft13.transitionInDis[1]);
    connect(station.placeOutDis[36], pflegekraft12.transitionInDis[3]);
    connect(station.placeOutDis[35], pflegekraft12.transitionInDis[2]);
    connect(station.placeOutDis[34], pflegekraft12.transitionInDis[1]);
    connect(station.placeOutDis[33], pflegekraft11.transitionInDis[3]);
    connect(station.placeOutDis[32], pflegekraft11.transitionInDis[2]);
    connect(station.placeOutDis[31], pflegekraft11.transitionInDis[1]);
    connect(station.placeOutDis[30], pflegekraft10.transitionInDis[3]);
    connect(station.placeOutDis[29], pflegekraft10.transitionInDis[2]);
    connect(station.placeOutDis[28], pflegekraft10.transitionInDis[1]);
    connect(station.placeOutDis[27], pflegekraft9.transitionInDis[3]);
    connect(station.placeOutDis[26], pflegekraft9.transitionInDis[2]);
    connect(station.placeOutDis[25], pflegekraft9.transitionInDis[1]);
    connect(station.placeOutDis[24], pflegekraft8.transitionInDis[3]);
    connect(station.placeOutDis[23], pflegekraft8.transitionInDis[2]);
    connect(station.placeOutDis[22], pflegekraft8.transitionInDis[1]);
    connect(station.placeOutDis[21], pflegekraft7.transitionInDis[3]);
    connect(station.placeOutDis[20], pflegekraft7.transitionInDis[2]);
    connect(station.placeOutDis[19], pflegekraft7.transitionInDis[1]);
    connect(station.placeOutDis[18], pflegekraft6.transitionInDis[3]);
    connect(station.placeOutDis[17], pflegekraft6.transitionInDis[2]);
    connect(station.placeOutDis[16], pflegekraft6.transitionInDis[1]);
    connect(station.placeOutDis[15], pflegekraft5.transitionInDis[3]);
    connect(station.placeOutDis[14], pflegekraft5.transitionInDis[2]);
    connect(station.placeOutDis[13], pflegekraft5.transitionInDis[1]);
    connect(station.placeOutDis[12], pflegekraft4.transitionInDis[3]);
    connect(station.placeOutDis[11], pflegekraft4.transitionInDis[2]);
    connect(station.placeOutDis[10], pflegekraft4.transitionInDis[1]);
    connect(station.placeOutDis[9], pflegekraft3.transitionInDis[3]);
    connect(station.placeOutDis[8], pflegekraft3.transitionInDis[2]);
    connect(station.placeOutDis[7], pflegekraft3.transitionInDis[1]);
    connect(station.placeOutDis[6], pflegekraft2.transitionInDis[3]);
    connect(station.placeOutDis[5], pflegekraft2.transitionInDis[2]);
    connect(station.placeOutDis[4], pflegekraft2.transitionInDis[1]);
    connect(station.placeOutDis[3], pflegekraft1.transitionInDis[3]);
    connect(station.placeOutDis[2], pflegekraft1.transitionInDis[2]);
    connect(station.placeOutDis[1], pflegekraft1.transitionInDis[1]);

//////////////////////////////////////////////////////////////////////////////
    annotation(
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-400, -400}, {400, 400}}, initialScale = 0.1)),
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}))/*,
    experiment(StartTime = 0, StopTime = 365, Tolerance = 1e-06)*/);
  end Station20;
