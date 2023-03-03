import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pcod/HomePage.dart';
import 'package:pcod/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'LoginPage.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

Box<dynamic> Hive_box = Hive.box('myBox');

List<String> periodListInString = ['', '', ''];
List<DateTime> periodList = [DateTime.now(), DateTime.now(), DateTime.now()];
bool isDateSelected = false;
bool isRegister = true;

class PeriodInfoRegister extends StatefulWidget {
  late final Box<dynamic> box;
  PeriodInfoRegister(this.box);
  @override
  State<PeriodInfoRegister> createState() => _PeriodInfoRegisterState();
}

class _PeriodInfoRegisterState extends State<PeriodInfoRegister> {
  @override
  void initState() {
    Hive_box = widget.box;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false, //new line

        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    BackButton(
                        color: Colors.grey,
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    Container(
                        alignment: Alignment.center,
                        child: Text(
                          'periodinfo_registerpage_title'.tr().toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        )),
                  ],
                ),
                SizedBox(height: 7),
                Container(
                    alignment: Alignment.center,
                    child: Text('periodinfo_registerpage_note'.tr().toString(),
                        //'This helps the app to calculate your personal recovery results and provide tailored experience',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF7B6F72),
                          fontSize: 12,
                        ))),
                SizedBox(height: 20),
                Container(
                  height: SizeConfig.screenHeight * 0.65,
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView(
                      children: [
                        SizedBox(height: 17),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                              'periodinfo_registerpage_box1'.tr().toString(),
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                                fontSize: 12,
                              )),
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              final datePick = await showDatePicker(
                                context: context,
                                selectableDayPredicate: (DateTime val) =>
                                    val.difference(DateTime.now()) <
                                            Duration(days: -40)
                                        ? false
                                        : true,
                                initialDate: periodList[0],
                                firstDate: new DateTime(1900),
                                lastDate: new DateTime.now(),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary:
                                            pink1, // header background color
                                        onPrimary:
                                            Colors.white, // header text color
                                        onSurface:
                                            Colors.black, // body text color
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          primary: pink1, // button text color
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (datePick != null &&
                                  datePick != periodList[0]) {
                                setState(() {
                                  periodList[0] = datePick;
                                  isDateSelected = true;
                                  // put it here
                                  periodListInString[0] =
                                      "${periodList[0].month}/${periodList[0].day}/${periodList[0].year}";
                                  print(periodListInString[0]); // 08/14/2019
                                });
                              }
                              setState(() {});
                            },
                            child: DateContainer(periodListInString[0]),
                          ),
                        ),
                        dateDifferenceViewer(
                            (periodList[0].difference(periodList[1]).inDays > 0)
                                ? periodList[0]
                                    .difference(periodList[1])
                                    .inDays
                                    .toString()
                                : "-"),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                              'periodinfo_registerpage_box2'.tr().toString(),
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                                fontSize: 12,
                              )),
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              final datePick = await showDatePicker(
                                context: context,
                                selectableDayPredicate: (DateTime val) =>
                                    val.difference(periodList[0]) <
                                            Duration(days: -40)
                                        ? false
                                        : true,
                                initialDate: periodList[0],
                                firstDate: new DateTime(1900),
                                lastDate: periodList[0],
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary:
                                            pink1, // header background color
                                        onPrimary:
                                            Colors.white, // header text color
                                        onSurface:
                                            Colors.black, // body text color
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          primary: pink1, // button text color
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (datePick != null &&
                                  datePick != periodList[1]) {
                                setState(() {
                                  periodList[1] = datePick;
                                  isDateSelected = true;
                                  // put it here
                                  periodListInString[1] =
                                      "${periodList[1].month}/${periodList[1].day}/${periodList[1].year}";
                                  print(periodListInString[1]); // 08/14/2019
                                });
                              }
                              setState(() {});
                            },
                            child: DateContainer(periodListInString[1]),
                          ),
                        ),
                        dateDifferenceViewer(
                            (periodList[1].difference(periodList[2]).inDays > 0)
                                ? periodList[1]
                                    .difference(periodList[2])
                                    .inDays
                                    .toString()
                                : "-"),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                              'periodinfo_registerpage_box3'.tr().toString(),
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                                fontSize: 12,
                              )),
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              final datePick = await showDatePicker(
                                context: context,
                                selectableDayPredicate: (DateTime val) =>
                                    val.difference(periodList[1]) <
                                            Duration(days: -40)
                                        ? false
                                        : true,
                                initialDate: periodList[1],
                                firstDate: new DateTime(1900),
                                lastDate: periodList[1],
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary:
                                            pink1, // header background color
                                        onPrimary:
                                            Colors.white, // header text color
                                        onSurface:
                                            Colors.black, // body text color
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          primary: pink1, // button text color
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (datePick != null &&
                                  datePick != periodList[2]) {
                                setState(() {
                                  periodList[2] = datePick;
                                  isDateSelected = true;
                                  // put it here
                                  periodListInString[2] =
                                      "${periodList[2].month}/${periodList[2].day}/${periodList[2].year}";
                                  print(periodListInString[2]); // 08/14/2019
                                });
                              }
                              setState(() {});
                            },
                            child: DateContainer(periodListInString[2]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                ///bottom button overflow fixed
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      // color: Colors.pink,
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
                                  borderRadius: new BorderRadius.circular(25.0),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              child: Text(
                                (isRegister)
                                    ? 'periodinfo_registerpage_next'
                                        .tr()
                                        .toString()
                                    : 'periodinfo_registerpage_save'
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
                              int errorcode = 0;
                              if (periodListInString[0] != '')
                                Hive_box.put('period_1', periodList[0]);
                              else
                                errorcode = 1;

                              if (periodListInString[1] != '')
                                Hive_box.put('period_2', periodList[1]);
                              else
                                errorcode = 2;

                              if (periodListInString[2] != '')
                                Hive_box.put('period_3', periodList[2]);
                              else
                                errorcode = 3;

                              if (errorcode == 0) {
                                Prefsetsignin();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return HomePage(Hive_box);
                                    },
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
          ),
        ),
      ),
    );
  }
}

class dateDifferenceViewer extends StatelessWidget {
  String number = '';
  dateDifferenceViewer(this.number);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 100,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Container(
                height: 25,
                width: 2,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration:
                      BoxDecoration(color: pink1, shape: BoxShape.circle),
                  child: Text("$number",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 20,
                      )),
                ),
                Text("periodinfo_registerpage_days".tr().toString(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 15,
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Container(
                height: 25,
                width: 2,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DateContainer extends StatelessWidget {
  String datedisplay = '';
  DateContainer(this.datedisplay);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.075,
        width: SizeConfig.screenWidth * 0.9,
        decoration: new BoxDecoration(
          color: Color(0xFFF7F8F8),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(14.0)),
        ),
        child: Row(
          children: [
            SizedBox(width: 20),
            Icon(
              Icons.calendar_month_sharp,
              color: Color(0xFF7b6f72),
              size: 30,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.035),
            (datedisplay != '')
                ? Text(
                    datedisplay,
                    style: TextStyle(color: Colors.black38),
                  )
                : Text(
                    "periodinfo_registerpage_last".tr().toString(),
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.normal,
                      color: Color(0xFFada4a5),
                      fontSize: 15,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
