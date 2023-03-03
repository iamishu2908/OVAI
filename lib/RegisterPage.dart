import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pcod/HomePage.dart';
import 'package:pcod/main.dart';
import 'package:pcod/periodinfo_registerpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

Box<dynamic> Hive_box = Hive.box('myBox');
String birthDateInString = '';
DateTime birthDate = DateTime.now();
bool isDateSelected = false;
bool isRegister = true;

class RegisterPage extends StatefulWidget {
  late final Box<dynamic> box;
  bool isRegister;
  RegisterPage(this.box, this.isRegister);
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController weightValue = TextEditingController();
  TextEditingController dobValue = TextEditingController();

  TextEditingController heightValue = TextEditingController();

  String genderValue = 'Registerpage_female'.tr().toString();
  var items = [
    'Registerpage_female'.tr().toString(),
    'Registerpage_others'.tr().toString()
  ];

  String relationshipValue = 'Registerpage_married'.tr().toString();
  var items1 = [
    'Registerpage_married'.tr().toString(),
    'Registerpage_single'.tr().toString()
  ];
  String bloodValue = 'A+';
  var items2 = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"];
  String pastPcodValue = 'Registerpage_pcod3'.tr().toString();
  var items3 = [
    'Registerpage_pcod1'.tr().toString(),
    'Registerpage_pcod2'.tr().toString(),
    'Registerpage_pcod3'.tr().toString()
  ];
  @override
  void initState() {
    Hive_box = widget.box;
    if (Hive_box.get('name') != null && Hive_box.get('height') != null) {
      genderValue = Hive_box.get('gender');
      bloodValue = Hive_box.get('blood');
      pastPcodValue = Hive_box.get('past_pcod');
      weightValue.text = Hive_box.get('weight');
      heightValue.text = Hive_box.get('height');
      birthDate = Hive_box.get('dob');
      birthDateInString = birthDate.toString().substring(0, 10);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isRegister = widget.isRegister;

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
                Container(
                    alignment: Alignment.center,
                    child: Text(
                      (isRegister)
                          ? 'Registerpage_title'.tr().toString()
                          : 'Registerpage_edit'.tr().toString(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    )),
                SizedBox(height: 7),
                Container(
                    alignment: Alignment.center,
                    child: Text('Registerpage_note'.tr().toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF7B6F72),
                          fontSize: 12,
                        ))),
                SizedBox(height: 20),
                Container(
                  height: SizeConfig.screenHeight * 0.65,
                  //child: GlowingOverscrollIndicator(
                  //axisDirection: AxisDirection.down,
                  //color: Color(0xFFEF5DA8),
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView(
                      children: [
                        Center(
                          child: Container(
                            height: 65,
                            //height: SizeConfig. screenHeight * 0.1,
                            width: SizeConfig.screenWidth * 0.9,
                            decoration: new BoxDecoration(
                              color: Color(0xFFF7F8F8),
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14.0)),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 20),
                                    Container(
                                        child: Icon(
                                      Icons.person_outline_rounded,
                                      color: Color(0xFF7b6f72),
                                      size: 30,
                                    )),
                                    new DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Color(0xFF7b6f72),
                                          size: 20.09,
                                        ),
                                        alignment: Alignment.center,
                                        dropdownColor: Colors.white,
                                        hint: Text("Choose Gender"),
                                        value: genderValue,
                                        items: items.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
                                          );
                                        }).toList(),
                                        // After selecting the desired option,it will
                                        // change button value to selected value
                                        onChanged: (String? newValue) {
                                          print(newValue);
                                          setState(() {
                                            genderValue = newValue!;
                                          });
                                        },
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFFada4a5),
                                          fontSize: 15,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 17),
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              final datePick = await showDatePicker(
                                context: context,
                                initialDate: birthDate,
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
                              if (datePick != null && datePick != birthDate) {
                                setState(() {
                                  birthDate = datePick;
                                  isDateSelected = true;

                                  // put it here
                                  birthDateInString =
                                      "${birthDate.month}/${birthDate.day}/${birthDate.year}";
                                  print(birthDateInString); // 08/14/2019
                                });
                              }
                              setState(() {});
                            },
                            child: Container(
                              height: 65,
                              width: SizeConfig.screenWidth * 0.9,
                              decoration: new BoxDecoration(
                                color: Color(0xFFF7F8F8),
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0)),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 20),
                                  Icon(
                                    Icons.calendar_month_sharp,
                                    color: Color(0xFF7b6f72),
                                    size: 30,
                                  ),
                                  SizedBox(width: 30),
                                  (birthDateInString != '')
                                      ? Text(
                                          birthDateInString,
                                          style:
                                              TextStyle(color: Colors.black38),
                                        )
                                      : Text(
                                          'Registerpage_dob'.tr().toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xFFada4a5),
                                            fontSize: 15,
                                          ),
                                        )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 17),
                        Center(
                          child: Row(
                            children: [
                              Container(
                                height: 65,
                                width: SizeConfig.screenWidth * 0.9,
                                decoration: new BoxDecoration(
                                  color: Color(0xFFF7F8F8),
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14.0)),
                                ),
                                child: Stack(children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      width: 70,
                                      height: 65,
                                      decoration: BoxDecoration(
                                        color: pink1,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14.0)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Kg',
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20),
                                    child: TextField(
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFFada4a5),
                                          fontSize: 15),
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.left,
                                      cursorColor: Colors.grey,
                                      controller: weightValue,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        hintText: 'Registerpage_weight'
                                            .tr()
                                            .toString(),
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFFada4a5),
                                          fontSize: 15,
                                        ),
                                        icon: Icon(
                                          Icons.monitor_weight_outlined,
                                          color: Color(0xFF7b6f72),
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
                          child: Container(
                            height: 65,
                            width: SizeConfig.screenWidth * 0.9,
                            decoration: new BoxDecoration(
                              color: Color(0xFFF7F8F8),
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14.0)),
                            ),
                            child: Stack(children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: 70,
                                  height: 65,
                                  decoration: BoxDecoration(
                                    color: pink1,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14.0)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "cm",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                child: TextField(
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFFada4a5),
                                      fontSize: 15),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.left,
                                  cursorColor: Colors.grey,
                                  controller: heightValue,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    // hintText: "Your Height",
                                    hintText:
                                        'Registerpage_height'.tr().toString(),
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFFada4a5),
                                      fontSize: 15,
                                    ),
                                    icon: Icon(
                                      Icons.height_sharp,
                                      color: Color(0xFF7b6f72),
                                      size: 30,
                                    ),
                                    fillColor: Colors.grey,
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                        SizedBox(height: 17),
                        Center(
                          child: Container(
                            height: 65,
                            width: SizeConfig.screenWidth * 0.9,
                            decoration: new BoxDecoration(
                              color: Color(0xFFF7F8F8),
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14.0)),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 20),

                                    Container(
                                      child: Icon(
                                        Icons.people,
                                        color: Color(0xFF7b6f72),
                                        size: 30,
                                      ),
                                    ),
                                     SizedBox(width: 10),
                                    new DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Color(0xFF7b6f72),
                                          size: 20.09,
                                        ),
                                        alignment: Alignment.center,
                                        dropdownColor: Colors.white,
                                        hint: Text("Registerpage_relationship"
                                            .tr()
                                            .toString()),
                                        value: relationshipValue,
                                        items: items1.map((String items1) {
                                          return DropdownMenuItem(
                                            value: items1,
                                            child: Text(items1),
                                          );
                                        }).toList(),
                                        // After selecting the desired option,it will
                                        // change button value to selected value
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            relationshipValue = newValue!;
                                          });
                                          print(relationshipValue);
                                        },
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFFada4a5),
                                          fontSize: 15,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 17),
                        Center(
                          child: Container(
                            height: 65,
                            width: SizeConfig.screenWidth * 0.9,
                            decoration: new BoxDecoration(
                              color: Color(0xFFF7F8F8),
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14.0)),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Container(
                                      child: Icon(
                                        Icons.water_drop,
                                        color: Color(0xFF7b6f72),
                                        size: 30,
                                      ),
                                    ),
                                    // SizedBox(width: 30),
                                    new DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Color(0xFF7b6f72),
                                          size: 20.09,
                                        ),
                                        alignment: Alignment.center,
                                        dropdownColor: Colors.white,
                                        hint: Text("Registerpage_blood"
                                            .tr()
                                            .toString()),
                                        value: bloodValue,
                                        items: items2.map((String items2) {
                                          return DropdownMenuItem(
                                            value: items2,
                                            child: Text(items2),
                                          );
                                        }).toList(),
                                        // After selecting the desired option,it will
                                        // change button value to selected value
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            bloodValue = newValue!;
                                            print(bloodValue);
                                          });
                                        },
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFFada4a5),
                                          fontSize: 15,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 17),
                        Center(
                          child: Container(
                            height: 65,
                            //height: SizeConfig. screenHeight * 0.1,
                            width: SizeConfig.screenWidth * 0.9,
                            decoration: new BoxDecoration(
                              color: Color(0xFFF7F8F8),
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14.0)),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Container(
                                      child: Icon(
                                        Icons.health_and_safety_rounded,
                                        color: Color(0xFF7b6f72),
                                        size: 30,
                                      ),
                                    ),
                                    SizedBox(width: 30),
                                    new DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Color(0xFF7b6f72),
                                          size: 20.09,
                                        ),
                                        alignment: Alignment.centerLeft,
                                        dropdownColor: Colors.white,
                                        value: pastPcodValue,
                                        hint: Text(
                                          "Registerpage_diagnose"
                                              .tr()
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xFFada4a5),
                                            fontSize: 15,
                                          ),
                                        ),
                                        items: items3.map((String items3) {
                                          return DropdownMenuItem(
                                            value: items3,
                                            child: Text(items3),
                                          );
                                        }).toList(),
                                        // After selecting the desired option,it will
                                        // change button value to selected value
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            pastPcodValue = newValue!;
                                            print(pastPcodValue);
                                          });
                                        },
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFFada4a5),
                                          fontSize: 15,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    // color: Colors.pink,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30, top: 0),
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Container(

                          width: SizeConfig.screenWidth * 0.8,
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            gradient: (birthDateInString.length>0&&heightValue.text.length>0&&weightValue.text.length>0)
                                ? LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Color(0xFFEF5DA8), Color(0xFFEF5DA8)],
                            )
                                : LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Colors.grey.shade400, Colors.grey.shade400],
                            ),
                          ),
                          child: MaterialButton(
                                elevation: 5,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              child: Text(
                                (isRegister)
                                    ? "Registerpage_next".tr().toString() : "Registerpage_save".tr().toString(),
                               // ? "Next":"Save",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            onPressed: () {
                              int errorcode = 0;
                              print(weightValue.text);
                              if (genderValue ==
                                      "Registerpage_female".tr().toString() ||
                                  genderValue ==
                                      "Registerpage_others".tr().toString())
                                Hive_box.put('gender', genderValue);
                              else
                                errorcode = 1;
                              print(errorcode);
                              if (birthDateInString != '')
                                Hive_box.put('dob', birthDate);
                              else
                                errorcode = 2;
                              print(errorcode);
                              if (weightValue.text != ''
                                  && int.parse(weightValue.text) > 0
                              )
                                Hive_box.put('weight', weightValue.text);
                              else
                                errorcode = 3;
                              print(errorcode);
                              if (heightValue.text != ''
                                  && int.parse(heightValue.text) > 0
                              )
                                Hive_box.put('height', heightValue.text);
                              else
                                errorcode = 4;
                              print(errorcode);
                              //'Registerpage_married'.tr().toString(),
                              //     'Registerpage_single'.tr().toString()
                              if (relationshipValue == 'Registerpage_married'.tr().toString()||
                                  relationshipValue == 'Registerpage_single'.tr().toString())
                                Hive_box.put('relationship', relationshipValue);
                              else
                                errorcode = 5;
                              print(errorcode);
                              if (bloodValue != '')
                                Hive_box.put('blood', bloodValue);
                              else
                                errorcode = 6;
                              print(errorcode);
                              if (pastPcodValue != '')
                                Hive_box.put('past_pcod', pastPcodValue);
                              else
                                errorcode = 7;
                              print(errorcode);
                              if (errorcode == 0)
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (context) {
                                //       return HomePage(Hive_box);
                                //     },
                                //   ),
                                // );
                                (isRegister)
                                    ? Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return PeriodInfoRegister(Hive_box);
                                          },
                                        ),
                                      )
                                    : Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return HomePage(Hive_box);
                                          },
                                        ),
                                      );
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
