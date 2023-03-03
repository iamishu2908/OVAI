import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health/health.dart';
import 'package:pcod/main.dart';
import 'package:pcod/pulseratepredict.dart';
import 'package:pcod/respirationpredict.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'HomePage.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:http/http.dart' as http;
import 'respirationpredict.dart';
import 'pulseratepredict.dart';
import 'models/predict_pcod_class.dart';
import 'package:easy_localization/easy_localization.dart';

TextEditingController pulseratecontroller = TextEditingController();
TextEditingController respirationratecontroller = TextEditingController();
TextEditingController cycleLenghtcontroller = TextEditingController();
TextEditingController marriageStatuscontroller = TextEditingController();
TextEditingController hipSizecontroller = TextEditingController();
TextEditingController waistSizecontroller = TextEditingController();
TextEditingController abortioncontroller = TextEditingController();
TextEditingController cycleRI = TextEditingController();
bool fast_food = true;
bool pregnant = true;
bool weight_gain = true;
bool hair_growth = true;
bool hair_fall = true;
bool pimples = true;
bool exercise = true;
bool darkening_skin = true;
bool showHistory = false;
AppState _state = AppState.DATA_NOT_FETCHED;
int predict_part = 1;
bool predict_PCOD = false;
String status_code = "";
Map<String, String> requestHeaders = {
  'Content-type': 'application/json',
};

// class ClassPredictPcod {
//   bool fast_food;
//   bool pregnant;
//   bool weight_gain;
//   bool hair_growth;
//   bool hair_fall;
//   bool pimples;
//   bool exercise;
//   bool darkening_skin;
//   bool predict_PCOD;
//   int pulse;
//   int respiration;
//   int cycle_length;
//   int marriage;
//   int hipsize;
//   int waistsize;
//   int cycleRI;
//   int abortion;
//   ClassPredictPcod(
//       this.fast_food,
//       this.pregnant,
//       this.weight_gain,
//       this.hair_growth,
//       this.hair_fall,
//       this.pimples,
//       this.exercise,
//       this.darkening_skin,
//       this.pulse,
//       this.respiration,
//       this.cycle_length,
//       this.marriage,
//       this.hipsize,
//       this.waistsize,
//       this.cycleRI,
//       this.abortion,
//       this.predict_PCOD);
// }

List<ClassPredictPcod> pcodhistory = [];

Future<Object?> PredictAPI() async {
  var url = Uri.parse('https://pcod-ai.herokuapp.com/predict/lite');
  var response = await http.post(
    url,
    body: jsonEncode({
      // "Age (yrs)": "28",
      // "BMI": "19.3",
      // "Blood Group": "15",
      // "Pulse rate(bpm)": "78",
      // "RR (breaths/min)": "22",
      // "Cycle(R/I)": "2",
      // "Cycle length(days)": "3",
      // "Marraige Status (Yrs)": "0",
      // "Pregnant(Y/N)": "0",
      // "No. of aborptions": "0",
      // "Hip(inch)": "36",
      // "Waist(inch)": "30",
      // "Weight gain(Y/N)": "1",
      // "hair growth(Y/N)": "0",
      // "Skin darkening (Y/N)": "0",
      // "Hair loss(Y/N)": "0",
      // "Pimples(Y/N)": "0",
      // "Fast food (Y/N)": "1",
      // "Reg.Exercise(Y/N)": "1"
      "Age (yrs)": "28",
      "BMI": bmi.toString(),
      "Blood Group": "15",
      "Pulse rate(bpm)": pulseratecontroller.text,
      "RR (breaths/min)": respirationratecontroller.text,
      "Cycle(R/I)": "2",
      "Cycle length(days)": cycleLenghtcontroller.text,
      "Marraige Status (Yrs)": marriageStatuscontroller.text,
      "Pregnant(Y/N)": (pregnant) ? "1" : "0",
      "No. of aborptions": abortioncontroller.text,
      "Hip(inch)": hipSizecontroller.text,
      "Waist(inch)": waistSizecontroller.text,
      "Weight gain(Y/N)": (weight_gain) ? "1" : "0",
      "hair growth(Y/N)": (hair_growth) ? "1" : "0",
      "Skin darkening (Y/N)": (darkening_skin) ? "1" : "0",
      "Hair loss(Y/N)": (hair_fall) ? "1" : "0",
      "Pimples(Y/N)": (pimples) ? "1" : "0",
      "Fast food (Y/N)": (fast_food) ? "1" : "0",
      "Reg.Exercise(Y/N)": (exercise) ? "1" : "0"
    }),
    headers: {
      'Content-type': 'application/json',
    },
  );
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  final Map<String, dynamic> data = await json.decode(response.body);
  if (response.statusCode == 200) {
    String temp = await data['PCOD'];
    predict_PCOD = ((temp == "0.0") ? false : true);
    return true;
  } else {
    String temp = await data['PCOD'];
    status_code = "Server not running";
    return false;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

Color lightpink = Color(0xFFFCDDEC);

class PredictPage extends StatefulWidget {
  const PredictPage({Key? key}) : super(key: key);

  @override
  _PredictPageState createState() => _PredictPageState();
}

class _PredictPageState extends State<PredictPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: (predict_part == 1)
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Container(
                    height: SizeConfig.screenHeight,
                    width: SizeConfig.screenWidth,
                    child: Column(children: [
                      Container(
                        // color: Colors.purpleAccent,
                        height: SizeConfig.screenHeight - 220,
                        child: ListView(
                          children: [
                            Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(top: 15),
                                child: Text(
                                  "predictpage_title".tr().toString(),
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 24,
                                  ),
                                )),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'predictpage_1'.tr().toString(),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'predictpage_2'.tr().toString(),
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              // color: Colors.purpleAccent,
                              height: 200,
                              // width: 20,
                              child: Image(
                                alignment: Alignment.topCenter,
                                colorBlendMode: BlendMode.darken,
                                image: AssetImage('assets/images/OVAI1.png'),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'predictpage_3'.tr().toString(),
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'predictpage_4'.tr().toString(),
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            Container(
                              // color: Colors.pink,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 0, top: 5),
                                child: Align(
                                  alignment: FractionalOffset.bottomCenter,
                                  child: Container(
                                    // width: SizeConfig.screenWidth * 0.8,
                                    decoration: new BoxDecoration(),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Color(0xFFEF5DA8),
                                          onPrimary: pink2,
                                          elevation: 5,
                                          shadowColor: Colors.pinkAccent,
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                            new BorderRadius.circular(15.0),
                                          )),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Text(
                                          'View previous prediction results',
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        predict_part = 5;
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "predictpage_5".tr().toString(),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Container(
                            // color: Colors.pink,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 0, top: 5),
                              child: Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: Container(
                                  width: SizeConfig.screenWidth * 0.8,
                                  decoration: new BoxDecoration(),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0xFFEF5DA8),
                                        onPrimary: Colors.pink,
                                        elevation: 5,
                                        shadowColor: Colors.pinkAccent,
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(25.0),
                                        )),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 18),
                                      child: Text(
                                        'predictpage_6'.tr().toString(),
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      predict_part = 2;
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                )
              : (predict_part == 2)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Container(
                        height: SizeConfig.screenHeight,
                        width: SizeConfig.screenWidth,
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'predcitpage_q_title'.tr().toString(),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Container(
                            // color: Colors.purpleAccent,
                            height: SizeConfig.screenHeight - 300,
                            child: ListView(
                              children: [
                                Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "predictpage_q1"
                                                    .tr()
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black54,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: ToggleSwitch(
                                          activeBgColor: [pink1],
                                          inactiveBgColor: pink2,
                                          minWidth: 65,
                                          initialLabelIndex: 0,
                                          totalSwitches: 2,
                                          labels: [
                                            'Yes',
                                            'No',
                                          ],
                                          onToggle: (index) {
                                            fast_food = !fast_food;
                                            print('switched to: $fast_food');
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "predictpage_q2"
                                                    .tr()
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black54,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: ToggleSwitch(
                                          activeBgColor: [pink1],
                                          inactiveBgColor: pink2,
                                          minWidth: 65,
                                          initialLabelIndex: 0,
                                          totalSwitches: 2,
                                          labels: [
                                            'Yes',
                                            'No',
                                          ],
                                          onToggle: (index) {
                                            pregnant = !pregnant;
                                            print('switched to: $index');
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "predictpage_q3"
                                                    .tr()
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black54,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: ToggleSwitch(
                                          activeBgColor: [pink1],
                                          inactiveBgColor: pink2,
                                          minWidth: 65,
                                          initialLabelIndex: 0,
                                          totalSwitches: 2,
                                          labels: [
                                            'Yes',
                                            'No',
                                          ],
                                          onToggle: (index) {
                                            weight_gain = !weight_gain;
                                            print('switched to: $index');
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "predictpage_q4"
                                                    .tr()
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black54,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: ToggleSwitch(
                                          activeBgColor: [pink1],
                                          inactiveBgColor: pink2,
                                          minWidth: 65,
                                          initialLabelIndex: 0,
                                          totalSwitches: 2,
                                          labels: [
                                            'Yes',
                                            'No',
                                          ],
                                          onToggle: (index) {
                                            hair_growth = !hair_growth;
                                            print('switched to: $index');
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "predictpage_q5"
                                                    .tr()
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black54,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: ToggleSwitch(
                                          activeBgColor: [pink1],
                                          inactiveBgColor: pink2,
                                          minWidth: 65,
                                          initialLabelIndex: 0,
                                          totalSwitches: 2,
                                          labels: [
                                            'Yes',
                                            'No',
                                          ],
                                          onToggle: (index) {
                                            hair_fall = !hair_fall;
                                            print('switched to: $index');
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                'predictpage_q6'
                                                    .tr()
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black54,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: ToggleSwitch(
                                          activeBgColor: [pink1],
                                          inactiveBgColor: pink2,
                                          minWidth: 65,
                                          initialLabelIndex: 0,
                                          totalSwitches: 2,
                                          labels: [
                                            'Yes',
                                            'No',
                                          ],
                                          onToggle: (index) {
                                            pimples = !pimples;
                                            print('switched to: $index');
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "predictpage_q7"
                                                    .tr()
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black54,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: ToggleSwitch(
                                          activeBgColor: [pink1],
                                          inactiveBgColor: pink2,
                                          minWidth: 65,
                                          initialLabelIndex: 0,
                                          totalSwitches: 2,
                                          labels: [
                                            'Yes',
                                            'No',
                                          ],
                                          onToggle: (index) {
                                            exercise = !exercise;
                                            print('switched to: $index');
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "predictpage_q8"
                                                    .tr()
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black54,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: ToggleSwitch(
                                          activeBgColor: [pink1],
                                          inactiveBgColor: pink2,
                                          minWidth: 65,
                                          initialLabelIndex: 0,
                                          totalSwitches: 2,
                                          labels: [
                                            'Yes',
                                            'No',
                                          ],
                                          onToggle: (index) {
                                            darkening_skin = !darkening_skin;
                                            print('switched to: $index');
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex:2,
                                    child: TextButton(
                                        onPressed: () {
                                          predict_part = 1;
                                          setState(() {});
                                        },
                                        child: Container(
                                          height: 63,
                                          width: 63,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: pink1),
                                          child: Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                          ),
                                        )),
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 0, top: 0),
                                        child: Align(
                                          alignment:
                                              FractionalOffset.bottomCenter,
                                          child: Container(
                                            width: SizeConfig.screenWidth * 0.8,
                                            decoration: new BoxDecoration(),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Color(0xFFEF5DA8),
                                                  onPrimary: Colors.pink,
                                                  elevation: 5,
                                                  shadowColor:
                                                      Colors.pinkAccent,
                                                  shape:
                                                      new RoundedRectangleBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(25.0),
                                                  )),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 18),
                                                child: Text(
                                                  'predictpage_next'
                                                      .tr()
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                predict_part = 3;
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ]),
                      ),
                    )
                  : (predict_part == 3)
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            height: SizeConfig.screenHeight,
                            width: SizeConfig.screenWidth,
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'predictpage_update'.tr().toString(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: Container(
                                  // color: Colors.purpleAccent,
                                  height: SizeConfig.screenHeight - 270,
                                  child: ListView(
                                    children: [
                                      Center(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 65,
                                              width:
                                                  SizeConfig.screenWidth * 0.85,
                                              decoration: new BoxDecoration(
                                                color: Color(0xFFF7F8F8),
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(14.0)),
                                              ),
                                              child: Stack(children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Container(
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            0.18,
                                                    height:
                                                        SizeConfig.screenWidth *
                                                            0.18,
                                                    decoration: BoxDecoration(
                                                      color: pink1,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  14.0)),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "BPM",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 20),
                                                  child: TextField(
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        textBaseline:
                                                            TextBaseline
                                                                .alphabetic),
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textAlign: TextAlign.left,
                                                    cursorColor: Colors.grey,
                                                    controller:
                                                        pulseratecontroller,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      disabledBorder:
                                                          InputBorder.none,
                                                      hintText:
                                                          'predictpage_hint1'
                                                              .tr()
                                                              .toString(),
                                                      labelStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            (pulseratecontroller
                                                                        .text ==
                                                                    '')
                                                                ? Color(
                                                                    0xFFada4a5)
                                                                : Colors
                                                                    .transparent,
                                                        fontSize: 15,
                                                      ),
                                                      icon: Icon(
                                                        Icons
                                                            .monitor_weight_outlined,
                                                        color:
                                                            Color(0xFF7b6f72),
                                                        size: 30,
                                                      ),
                                                      hintStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            (pulseratecontroller
                                                                        .text ==
                                                                    '')
                                                                ? Color(
                                                                    0xFFada4a5)
                                                                : Colors
                                                                    .transparent,
                                                        fontSize: 15,
                                                      ),
                                                      fillColor: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10 +
                                                          SizeConfig
                                                                  .screenWidth *
                                                              0.18),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) {
                                                            return PulseRate();
                                                          },
                                                        ),
                                                      );
                                                    },
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Container(
                                                        width: SizeConfig
                                                                .screenWidth *
                                                            0.18,
                                                        height: SizeConfig
                                                                .screenWidth *
                                                            0.18,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: pink1,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          14.0)),
                                                        ),
                                                        child: Center(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons.speed,
                                                                color: Colors
                                                                    .white,
                                                                size: 30,
                                                              ),
                                                              Text(
                                                                "predictpage_measure"
                                                                    .tr()
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 17),
                                      Center(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 65,
                                              width:
                                                  SizeConfig.screenWidth * 0.85,
                                              decoration: new BoxDecoration(
                                                color: Color(0xFFF7F8F8),
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(14.0)),
                                              ),
                                              child: Stack(children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Container(
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            0.18,
                                                    height:
                                                        SizeConfig.screenWidth *
                                                            0.18,
                                                    decoration: BoxDecoration(
                                                      color: pink1,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  14.0)),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "RR",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 20),
                                                  child: TextField(
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        textBaseline:
                                                            TextBaseline
                                                                .alphabetic),
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textAlign: TextAlign.left,
                                                    cursorColor: Colors.grey,
                                                    controller:
                                                        respirationratecontroller,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      disabledBorder:
                                                          InputBorder.none,
                                                      hintText:
                                                          'predictpage_hint2'
                                                              .tr()
                                                              .toString(),
                                                      hintStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            (respirationratecontroller
                                                                        .text ==
                                                                    '')
                                                                ? Color(
                                                                    0xFFada4a5)
                                                                : Colors
                                                                    .transparent,
                                                        fontSize: 15,
                                                      ),
                                                      icon: Icon(
                                                        Icons
                                                            .monitor_weight_outlined,
                                                        color:
                                                            Color(0xFF7b6f72),
                                                        size: 30,
                                                      ),
                                                      fillColor: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10 +
                                                          SizeConfig
                                                                  .screenWidth *
                                                              0.18),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) {
                                                            return RespirationRate();
                                                          },
                                                        ),
                                                      );
                                                      setState(() =>
                                                          respirationratecontroller
                                                              .text = "");
                                                      setState(
                                                          () => isDone = 0);
                                                      setState(
                                                          () => isNext = true);
                                                    },
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Container(
                                                        width: SizeConfig
                                                                .screenWidth *
                                                            0.18,
                                                        height: SizeConfig
                                                                .screenWidth *
                                                            0.18,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: pink1,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          14.0)),
                                                        ),
                                                        child: Center(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons.speed,
                                                                color: Colors
                                                                    .white,
                                                                size: 30,
                                                              ),
                                                              Text(
                                                                "predictpage_measure"
                                                                    .tr()
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 17),
                                      Center(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 65,
                                              width:
                                                  SizeConfig.screenWidth * 0.85,
                                              decoration: new BoxDecoration(
                                                color: Color(0xFFF7F8F8),
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(14.0)),
                                              ),
                                              child: Stack(children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Container(
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            0.18,
                                                    height:
                                                        SizeConfig.screenWidth *
                                                            0.18,
                                                    decoration: BoxDecoration(
                                                      color: pink1,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  14.0)),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Days",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 20),
                                                  child: TextField(
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        textBaseline:
                                                            TextBaseline
                                                                .alphabetic),
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textAlign: TextAlign.left,
                                                    cursorColor: Colors.grey,
                                                    controller:
                                                        cycleLenghtcontroller,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      disabledBorder:
                                                          InputBorder.none,
                                                      hintText:
                                                          'predictpage_hint3'
                                                              .tr()
                                                              .toString(),
                                                      hintStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            (cycleLenghtcontroller
                                                                        .text ==
                                                                    '')
                                                                ? Color(
                                                                    0xFFada4a5)
                                                                : Colors
                                                                    .transparent,
                                                        fontSize: 15,
                                                      ),
                                                      icon: Icon(
                                                        Icons
                                                            .monitor_weight_outlined,
                                                        color:
                                                            Color(0xFF7b6f72),
                                                        size: 30,
                                                      ),
                                                      fillColor: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 17),
                                      Center(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 65,
                                              width:
                                                  SizeConfig.screenWidth * 0.85,
                                              decoration: new BoxDecoration(
                                                color: Color(0xFFF7F8F8),
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(14.0)),
                                              ),
                                              child: Stack(children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Container(
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            0.18,
                                                    height:
                                                        SizeConfig.screenWidth *
                                                            0.18,
                                                    decoration: BoxDecoration(
                                                      color: pink1,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  14.0)),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Yrs",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 20),
                                                  child: TextField(
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        textBaseline:
                                                            TextBaseline
                                                                .alphabetic),
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textAlign: TextAlign.left,
                                                    cursorColor: Colors.grey,
                                                    controller:
                                                        marriageStatuscontroller,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      disabledBorder:
                                                          InputBorder.none,
                                                      hintText:
                                                          'predictpage_hint4'
                                                              .tr()
                                                              .toString(),
                                                      hintStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            (marriageStatuscontroller
                                                                        .text ==
                                                                    '')
                                                                ? Color(
                                                                    0xFFada4a5)
                                                                : Colors
                                                                    .transparent,
                                                        fontSize: 15,
                                                      ),
                                                      icon: Icon(
                                                        Icons
                                                            .monitor_weight_outlined,
                                                        color:
                                                            Color(0xFF7b6f72),
                                                        size: 30,
                                                      ),
                                                      fillColor: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 17),
                                      Center(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 65,
                                              width:
                                                  SizeConfig.screenWidth * 0.85,
                                              decoration: new BoxDecoration(
                                                color: Color(0xFFF7F8F8),
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(14.0)),
                                              ),
                                              child: Stack(children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Container(
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            0.18,
                                                    height:
                                                        SizeConfig.screenWidth *
                                                            0.18,
                                                    decoration: BoxDecoration(
                                                      color: pink1,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  14.0)),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "cms",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 20),
                                                  child: TextField(
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        textBaseline:
                                                            TextBaseline
                                                                .alphabetic),
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textAlign: TextAlign.left,
                                                    cursorColor: Colors.grey,
                                                    controller:
                                                        hipSizecontroller,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      disabledBorder:
                                                          InputBorder.none,
                                                      hintText:
                                                          'predictpage_hint5'
                                                              .tr()
                                                              .toString(),
                                                      hintStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: (hipSizecontroller
                                                                    .text ==
                                                                '')
                                                            ? Color(0xFFada4a5)
                                                            : Colors
                                                                .transparent,
                                                        fontSize: 15,
                                                      ),
                                                      icon: Icon(
                                                        Icons
                                                            .monitor_weight_outlined,
                                                        color:
                                                            Color(0xFF7b6f72),
                                                        size: 30,
                                                      ),
                                                      fillColor: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 17),
                                      Center(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 65,
                                              width:
                                                  SizeConfig.screenWidth * 0.85,
                                              decoration: new BoxDecoration(
                                                color: Color(0xFFF7F8F8),
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(14.0)),
                                              ),
                                              child: Stack(children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Container(
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            0.18,
                                                    height:
                                                        SizeConfig.screenWidth *
                                                            0.18,
                                                    decoration: BoxDecoration(
                                                      color: pink1,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  14.0)),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "cms",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 20),
                                                  child: TextField(
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        textBaseline:
                                                            TextBaseline
                                                                .alphabetic),
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textAlign: TextAlign.left,
                                                    cursorColor: Colors.grey,
                                                    controller:
                                                        waistSizecontroller,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      disabledBorder:
                                                          InputBorder.none,
                                                      hintText:
                                                          'predictpage_hint6'
                                                              .tr()
                                                              .toString(),
                                                      hintStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            (waistSizecontroller
                                                                        .text ==
                                                                    '')
                                                                ? Color(
                                                                    0xFFada4a5)
                                                                : Colors
                                                                    .transparent,
                                                        fontSize: 15,
                                                      ),
                                                      icon: Icon(
                                                        Icons
                                                            .monitor_weight_outlined,
                                                        color:
                                                            Color(0xFF7b6f72),
                                                        size: 30,
                                                      ),
                                                      fillColor: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 17),
                                      Center(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 65,
                                              width:
                                                  SizeConfig.screenWidth * 0.85,
                                              decoration: new BoxDecoration(
                                                color: Color(0xFFF7F8F8),
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(14.0)),
                                              ),
                                              child: Stack(children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Container(
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            0.18,
                                                    height:
                                                        SizeConfig.screenWidth *
                                                            0.18,
                                                    decoration: BoxDecoration(
                                                      color: pink1,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  14.0)),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "R/I",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 20),
                                                  child: TextField(
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        textBaseline:
                                                            TextBaseline
                                                                .alphabetic),
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textAlign: TextAlign.left,
                                                    cursorColor: Colors.grey,
                                                    controller: cycleRI,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      disabledBorder:
                                                          InputBorder.none,
                                                      hintText:
                                                          'predictpage_hint7'
                                                                  .tr()
                                                                  .toString() +
                                                              ' (R/I)',
                                                      hintStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: (cycleRI.text ==
                                                                '')
                                                            ? Color(0xFFada4a5)
                                                            : Colors
                                                                .transparent,
                                                        fontSize: 15,
                                                      ),
                                                      icon: Icon(
                                                        Icons
                                                            .monitor_weight_outlined,
                                                        color:
                                                            Color(0xFF7b6f72),
                                                        size: 30,
                                                      ),
                                                      fillColor: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 17),
                                      Center(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 65,
                                              width:
                                                  SizeConfig.screenWidth * 0.85,
                                              decoration: new BoxDecoration(
                                                color: Color(0xFFF7F8F8),
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(14.0)),
                                              ),
                                              child: Stack(children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 20),
                                                  child: TextField(
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        textBaseline:
                                                            TextBaseline
                                                                .alphabetic),
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textAlign: TextAlign.left,
                                                    cursorColor: Colors.grey,
                                                    controller:
                                                        abortioncontroller,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      disabledBorder:
                                                          InputBorder.none,
                                                      hintText:
                                                          'predictpage_hint8'
                                                              .tr()
                                                              .toString(),
                                                      hintStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            (abortioncontroller
                                                                        .text ==
                                                                    '')
                                                                ? Color(
                                                                    0xFFada4a5)
                                                                : Colors
                                                                    .transparent,
                                                        fontSize: 15,
                                                      ),
                                                      icon: Icon(
                                                        Icons
                                                            .monitor_weight_outlined,
                                                        color:
                                                            Color(0xFF7b6f72),
                                                        size: 30,
                                                      ),
                                                      fillColor: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex:2,
                                        child: TextButton(
                                            onPressed: () {
                                              predict_part = 2;
                                              setState(() {});
                                            },
                                            child: Container(
                                              height: 63,
                                              width: 63,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: pink1),
                                              child: Icon(
                                                Icons.arrow_back,
                                                color: Colors.white,
                                              ),
                                            )),
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: Container(
                                          // color: Colors.pink,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 0, top: 0),
                                            child: Align(
                                              alignment:
                                                  FractionalOffset.bottomCenter,
                                              child: Container(
                                                width: SizeConfig.screenWidth *
                                                    0.8,
                                                decoration: new BoxDecoration(),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Color(0xFFEF5DA8),
                                                          onPrimary:
                                                              Colors.pink,
                                                          elevation: 5,
                                                          shadowColor:
                                                              Colors.pinkAccent,
                                                          shape:
                                                              new RoundedRectangleBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    25.0),
                                                          )),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 18),
                                                    child: Text(
                                                      'predictpage_predict'
                                                          .tr()
                                                          .toString(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    int errorcode = 0;
                                                    if (pulseratecontroller
                                                            .text ==
                                                        '') errorcode = 1;
                                                    if (respirationratecontroller
                                                            .text ==
                                                        '') errorcode = 1;
                                                    if (cycleLenghtcontroller
                                                            .text ==
                                                        '') errorcode = 2;
                                                    if (marriageStatuscontroller
                                                            .text ==
                                                        '') errorcode = 3;
                                                    if (abortioncontroller
                                                            .text ==
                                                        '') errorcode = 4;
                                                    if (hipSizecontroller
                                                            .text ==
                                                        '') errorcode = 5;
                                                    if (waistSizecontroller
                                                            .text ==
                                                        '') errorcode = 6;
                                                    if (errorcode == 0) {
                                                      print("all okay");
                                                      await PredictAPI();
                                                      if (Hive_box_Homepage.get(
                                                              'predict_pcod_history') !=
                                                          null) {
                                                        List<ClassPredictPcod>
                                                            temppredicthistorylist =
                                                            Hive_box_Homepage.get(
                                                                'predict_pcod_history');
                                                        temppredicthistorylist.add(ClassPredictPcod(
                                                            fast_food,
                                                            pregnant,
                                                            weight_gain,
                                                            hair_growth,
                                                            hair_fall,
                                                            pimples,
                                                            exercise,
                                                            darkening_skin,
                                                            int.parse(
                                                                pulseratecontroller
                                                                    .text),
                                                            int.parse(
                                                                respirationratecontroller
                                                                    .text),
                                                            int.parse(
                                                                cycleLenghtcontroller
                                                                    .text),
                                                            int.parse(
                                                                marriageStatuscontroller
                                                                    .text),
                                                            int.parse(
                                                                hipSizecontroller
                                                                    .text),
                                                            int.parse(
                                                                waistSizecontroller
                                                                    .text),
                                                            2,
                                                            int.parse(
                                                                abortioncontroller
                                                                    .text),
                                                            predict_PCOD,DateTime.now(),bmi));
                                                        Hive_box_Homepage.put(
                                                            'predict_pcod_history',
                                                            temppredicthistorylist);
                                                        print("DONE 1");
                                                        print(Hive_box_Homepage.get(
                                                            'predict_pcod_history'));
                                                      } else {
                                                        List<ClassPredictPcod>
                                                            temppredicthistorylist =
                                                            [];
                                                        temppredicthistorylist.add(ClassPredictPcod(
                                                            fast_food,
                                                            pregnant,
                                                            weight_gain,
                                                            hair_growth,
                                                            hair_fall,
                                                            pimples,
                                                            exercise,
                                                            darkening_skin,
                                                            int.parse(
                                                                pulseratecontroller
                                                                    .text),
                                                            int.parse(
                                                                respirationratecontroller
                                                                    .text),
                                                            int.parse(
                                                                cycleLenghtcontroller
                                                                    .text),
                                                            int.parse(
                                                                marriageStatuscontroller
                                                                    .text),
                                                            int.parse(
                                                                hipSizecontroller
                                                                    .text),
                                                            int.parse(
                                                                waistSizecontroller
                                                                    .text),
                                                            2,
                                                            int.parse(
                                                                abortioncontroller
                                                                    .text),
                                                            predict_PCOD,DateTime.now(),bmi));
                                                        Hive_box_Homepage.put(
                                                            'predict_pcod_history',
                                                            temppredicthistorylist);
                                                        print("DONE");
                                                        print(Hive_box_Homepage.get(
                                                            'predict_pcod_history'));
                                                      }
                                                      predict_part = 4;

                                                      setState(() {});
                                                    } else {
                                                      showTopSnackBar(
                                                        context,
                                                        ///todo:to change snackbar icon position change iconpoistionleft to 5
                                                        Container(
                                                          height: 50,
                                                          child: CustomSnackBar
                                                              .success(
                                                            iconRotationAngle:
                                                                0,
                                                            iconPositionTop:
                                                                -21,
                                                            iconPositionLeft:
                                                                5.0,
                                                            icon: Icon(
                                                              Icons.info,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            backgroundColor:
                                                                Colors.red
                                                                    .shade400,
                                                            message:
                                                                "predictpage_errormsg"
                                                                    .tr()
                                                                    .toString(),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        )
                      : Container(
                          // color: Colors.purpleAccent,
                          height: SizeConfig.screenHeight - MediaQuery.of(context).size.height*0.005,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    // color: Colors.pink,
                                    child: Container(
                                      width: SizeConfig.screenWidth * 0.8,
                                      decoration: new BoxDecoration(),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Color(0xFFEF5DA8),
                                            onPrimary: Colors.pink,
                                            elevation: 5,
                                            shadowColor: Colors.pinkAccent,
                                            shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      25.0),
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20,bottom: 10),
                                          child: Text(
                                            'pulse_3'.tr().toString(),
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        onPressed: () async {
                                          predict_part = 1;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 100),
                                child: ListView(
                                  children: [
                                    Container(
                                        alignment: Alignment.topLeft,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: Text(
                                            'result_title'.tr().toString(),
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 24,
                                            ),
                                          ),
                                        )),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    (predict_part!=5)?Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 28),
                                      child: Container(
                                        height: 150,
                                        width: SizeConfig.screenWidth * 0.8,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                spreadRadius: 2,
                                                blurRadius: 2,
                                                offset: Offset(2,
                                                    2), // changes position of shadow
                                              ),
                                            ],
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      'result1'.tr().toString(),
                                                      textAlign: TextAlign.left,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      'result2'.tr().toString(),
                                                      textAlign: TextAlign.left,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black54,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      ((predict_PCOD == true)
                                                          ? "resulthigh"
                                                              .tr()
                                                              .toString()
                                                          : "resultlow"
                                                              .tr()
                                                              .toString()),
                                                      textAlign: TextAlign.left,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: pink1,
                                                        fontSize: 45,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                // color: Colors.purpleAccent,
                                                height: 200,
                                                // width: 20,
                                                child: Image(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  colorBlendMode:
                                                      BlendMode.darken,
                                                  image: AssetImage(
                                                      'assets/images/OVAI1.png'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ):SizedBox(height: 0,),
                                    (predict_part!=5)?Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 28, vertical: 10),
                                      child: Text(
                                        'result_note'.tr().toString(),
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ):SizedBox(height: 0,),
                                    (predict_part!=5)?SizedBox(
                                      height: 8,
                                    ):SizedBox(height: 0,),
                                    (predict_part!=5)?Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 28),
                                      child: Text(
                                        'result3'.tr().toString(),
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ):SizedBox(height: 0,),
                                    (predict_part!=5)?SizedBox(
                                      height: 8,
                                    ):SizedBox(height: 0,),
                                    (predict_part!=5)?Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 28),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            minHeight: 20, maxHeight: 150),
                                        width: SizeConfig.screenWidth * 0.8,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                spreadRadius: 2,
                                                blurRadius: 2,
                                                offset: Offset(2,
                                                    2), // changes position of shadow
                                              ),
                                            ],
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              (fast_food == true)
                                                  ? Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        'result4'
                                                            .tr()
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.left,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black54,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox(
                                                      height: 0,
                                                    ),
                                              (exercise == false)
                                                  ? Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        'result5'
                                                            .tr()
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.left,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black54,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    )
                                                  : Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        'result6'
                                                            .tr()
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.left,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black54,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ):SizedBox(height: 0,),
                                    (predict_part!=5)?SizedBox(
                                      height: 15,
                                    ):SizedBox(height: 0,),
                                    (predict_part!=5)?SizedBox(
                                      height: 15,
                                    ):SizedBox(height: 0,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 28),
                                      child: GestureDetector(
                                        onTap: () {
                                          showHistory = !showHistory;
                                          print("history"+showHistory.toString());
                                          if (Hive_box_Homepage.get(
                                                  'predict_pcod_history') !=
                                              null) {
                                            pcodhistory = Hive_box_Homepage.get(
                                                'predict_pcod_history');
                                            for(int i=0;i<pcodhistory.length;i++){
                                              if(pcodhistory[i].date == null)
                                                pcodhistory[i].date = DateTime.now();
                                              if(pcodhistory[i].bmi == null)
                                                pcodhistory[i].bmi = 0.0;
                                            }
                                            print("history, ${pcodhistory[0].predict_PCOD}");
                                          } else {
                                            print(Hive_box_Homepage.get(
                                                'predict_pcod_history'));
                                          }
                                          print(pcodhistory.length);
                                          setState(() {

                                          });
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                              minHeight: 20, maxHeight: 150),
                                          width: SizeConfig.screenWidth * 0.8,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  spreadRadius: 2,
                                                  blurRadius: 2,
                                                  offset: Offset(2,
                                                      2), // changes position of shadow
                                                ),
                                              ],
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'result7'.tr().toString(),
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Colors.grey,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    (showHistory)?Container(
                                      // color: Colors.amber,
                                      height: 400,
                                      child: (pcodhistory.length>0)?Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                                        child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: pcodhistory.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return pcod_history_box(pcodhistory[index].date!, pcodhistory[index].predict_PCOD,pcodhistory[index].bmi);
                                            }),
                                      ):Text(
                                          'No records found :(',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            fontSize: 15,
                                          )
                                      ),
                                    ):SizedBox(height:0),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
        ),
      ),
    );
  }
}

class pcod_history_box extends StatelessWidget {
  DateTime date;
  bool predict_pcod;
  double _bmi;
  pcod_history_box(this.date, this.predict_pcod,this._bmi);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          height: 100,
          // color: pink1,
          decoration: BoxDecoration(
            color: pink1,
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, pink2]),
              borderRadius: BorderRadius.all(Radius.circular(20))
          ), child:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                          "Date: ${date.day.toString()}-${date.month.toString()}-${date.year.toString()} ",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 12,
                          ),
                      ),
                        ),
                        Flexible(
                          child: Text(
                            "BMI: ${_bmi.toStringAsFixed(2).toString()} ",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),],
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    width:2,
                    child: Container(color: Colors.black12,),
                  ),
                  Flexible(
                    flex:1,
                    child: Column(
                      children: [Flexible(
                        child: Text(
                          "Risk of PCOD: ${predict_pcod.toString()}",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),],
                    ),
                  ),
                ],
        ),
            ),
          ),


        ));
  }
}
