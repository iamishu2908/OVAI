import 'dart:io';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pcod/FaqPage.dart';
import 'package:pcod/ForumPage.dart';
import 'package:pcod/PredictPage.dart';
import 'package:pcod/ProfilePage.dart';
import 'package:pcod/RegisterPage.dart';
import 'package:pcod/StatsPage.dart';
import 'package:pcod/foodpage/foodPageHome.dart';
import 'package:pcod/main.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:pcod/periodinfo_registerpage.dart';
import 'package:pcod/workout_screen.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import 'foodpage/FoodPage.dart';
import 'exercise and yoga.dart';
import 'package:animations/animations.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

Box<dynamic> Hive_box_Homepage = Hive.box('myBox');
bool period_tracking_initialized = false;
List<DateTime> period_start = [];
List<DateTime> period_end = [];

AppState _state = AppState.DATA_NOT_FETCHED;
bool _permissiongranted = true;
int _homescreenpart = 1;
int _nofSteps = 10;
double _mgdl = 10.0;
String? name = '';
DateTime? dob_dt = DateTime.now();
String? height = '';
String? weight = '';
String? gender = '';
String? dob = '';
String? bloodgrp = '';
double bmi = 0.0;
Color pink1 = Color(0xFFF178B6);
Color pink2 = Color(0xFFFCDFEE);
Color bgcolor = Color(0xFFE6E6FA);
final iconList = <IconData>[
  Icons.home_filled,
  Icons.run_circle_outlined,
  Icons.bar_chart,
  Icons.account_circle_outlined,
];
var _bottomNavIndex = 0; //default index of a first screen

class HomePage extends StatefulWidget {
  late final Box<dynamic> box;

  HomePage(this.box);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  late CurvedAnimation curve;
  String body = "Home";
  int index = 0;

  /// Add some random health data.

  @override
  void initState() {
    Hive_box_Homepage = widget.box;
    if (Hive_box_Homepage.get('period_tracker_initialization') != null ||
        Hive_box_Homepage.get('period_tracker_initialization') != false) {
      // Hive_box_Homepage.get('period_tracker_initialization') !=
    }
    if (Hive_box_Homepage.get('calorie_value') != null) {
      List<double> val = Hive_box_Homepage.get('calorie_value');
      // List<String> day = Hive_box.get('calorie_day');
      for (int i = 0; i < val.length; i++) {
        calories_list_week[i] = CalorieData(day(i + 1), val[i]);
      }
    }
    if (Hive_box_Homepage.get('step_value') != null) {
      List<int> val = Hive_box_Homepage.get('step_value');
      for (int i = 0; i < val.length; i++) {
        step_list_month[i] = StepData(day(i + 1), val[i]);
      }
    }

    // TODO: implement initState
    double? height ;
    double? weight ;
    try {
      height = num.parse(Hive_box_Homepage.get('height')).toDouble();
      weight = num.parse(Hive_box_Homepage.get('weight')).toDouble();
    }
    catch(e){
      height =0.0;
       weight = 0.0;
    }
    // if(height !>0) height=0;
    // if(weight !>0) weight=0;
    // double? height =10.0;
    // double? weight =11.0;
    bmi = (weight / (height * height)) * 10000;
    print("bmi=$bmi");

    super.initState();
  }

  Future<bool> _onWillPop() async {
    return await true;
  }

  @override
  Widget build(BuildContext context) {
    name = Hive_box_Homepage.get('name');
    height = Hive_box_Homepage.get('height');
    weight = Hive_box_Homepage.get('weight');
    dob_dt = Hive_box_Homepage.get('dob');
    // dob_dt = DateTime.parse(dob);
    gender = Hive_box_Homepage.get('gender');
    bloodgrp = Hive_box_Homepage.get('blood');

    SizeConfig().init(context);
    return SafeArea(
      child: WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xFFED4B9E),
            child: Icon(Icons.search),
            onPressed: () {
              _bottomNavIndex = 4;
              setState(() {});
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            splashColor: Colors.pink,
            backgroundColor: Colors.white,
            icons: iconList,
            activeIndex: _bottomNavIndex,
            activeColor: Colors.pink,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.smoothEdge,
            onTap: (index) => setState(() {
              foodpagecontroller = 0;
              _homescreenpart = 1;
              _bottomNavIndex = index;
              print(_bottomNavIndex);
            }),
            //other params
          ),
          body: (_bottomNavIndex == 0)
              ? HomeScreenWidget()
              : (_bottomNavIndex == 1)
                  ? exerciseandyoga()
                  : (_bottomNavIndex == 2)
                      ? StatsPage()
                      : (_bottomNavIndex == 3)
                          ? ProfilePage()
                          : PredictPage(),
        ),
        onWillPop: () async {
          print("WILL POP SCOPE $_bottomNavIndex");
          if (_bottomNavIndex == 0) {
            print(_homescreenpart);
            if (_homescreenpart == 3) {
              print("done to 1");
              _homescreenpart = 1;
              setState(() {});
            } else {
              print("out");
              if (Platform.isAndroid) SystemNavigator.pop();
            }
          } else {
            print("here");
            _bottomNavIndex = 0;
            setState(() {});
            print("here $_bottomNavIndex");
          }

          return false;
        },
      ),
    );
  }
}

class HomeScreenWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenWidgetState();
  }
}

enum AppState {
  DATA_NOT_FETCHED,
  FETCHING_DATA,
  DATA_READY,
  NO_DATA,
  AUTH_NOT_GRANTED,
  DATA_ADDED,
  DATA_NOT_ADDED,
  STEPS_READY,
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  List<HealthDataPoint> _calorieDataList = [];
  List<HealthDataPoint> _sleepDataList = [];

  AppState _state = AppState.DATA_NOT_FETCHED;
  int _nofSteps = 10;
  double _mgdl = 10.0;

  // create a HealthFactory for use in the app
  HealthFactory health = HealthFactory();

  /// Fetch data points from the health plugin and show them in the app.
  Future fetchData() async {
    final types = [
      HealthDataType.STEPS,
      HealthDataType.ACTIVE_ENERGY_BURNED,
      HealthDataType.SLEEP_ASLEEP,
    ];

    // with coresponsing permissions
    final permissions = [
      HealthDataAccess.READ,
      HealthDataAccess.READ,
      HealthDataAccess.READ,
      // HealthDataAccess.READ,
    ];
    bool requested =
        await health.requestAuthorization(types, permissions: permissions);
    if (requested) {
      setState(() => _state = AppState.FETCHING_DATA);
      if (Platform.isAndroid) {
        var a = await Permission.activityRecognition.request().isGranted;
      }

      // get data within the last 24 hours
      // final now = DateTime.now();
      // final day_start = DateTime(now.year, now.month, now.day);
      // // DateTime.now().add(Duration(days: 6));
      // final day_end = DateTime.now();
      for (int i = 0; i < DateTime.now().weekday; i++) {
        var midnight = new DateTime.now();
        var endday = new DateTime.now();
        while (midnight.weekday != i + 1) {
          midnight = midnight.subtract(new Duration(days: 1));
        }
        String x = midnight.toString();
        String y = midnight.toString();
        x = x.replaceRange(11, 23, "00:00:00.000");
        y = y.replaceRange(11, 23, "23:59:59.000");
        midnight = DateTime.parse(x); //midnight
        endday = DateTime.parse(y);
        if (requested) {
          try {
            // fetch health data
            List<HealthDataPoint> calorieDataPoint = await health
                .getHealthDataFromTypes(
                    midnight,
                    (DateTime.now().weekday == midnight.weekday)
                        ? DateTime.now()
                        : endday,
                    [HealthDataType.ACTIVE_ENERGY_BURNED]);
            List<HealthDataPoint> sleepDataPoint = await health
                .getHealthDataFromTypes(
                    midnight, endday, [HealthDataType.SLEEP_ASLEEP]);
            print("health data on ${midnight.toString()}=$calorieDataPoint");
            // save all the new data points (only the first 100)
            _calorieDataList.clear();
            _sleepDataList.clear();
            _sleepDataList.addAll((sleepDataPoint.length < 100)
                ? sleepDataPoint
                : sleepDataPoint.sublist(0, 100));
            _calorieDataList.addAll((calorieDataPoint.length < 500)
                ? calorieDataPoint
                : calorieDataPoint.sublist(0, 500));
          } catch (error) {
            print("Exception in getHealthDataFromTypes: $error");
          }
          _calorieDataList = HealthFactory.removeDuplicates(_calorieDataList);
          // _sleepDataList = HealthFactory.removeDuplicates(_sleepDataList);
          _calorieDataList
              .forEach((x) => print("${x.dateFrom.weekday}\t ${x.value}"));
          print("sleep=$_sleepDataList");
          // update the UI to display the results
          setState(() {
            _state = _calorieDataList.isEmpty
                ? AppState.NO_DATA
                : AppState.DATA_READY;
          });
        } else {
          _permissiongranted = false;
          Hive_box_Homepage.put('permission', _permissiongranted);
          print("Authorization not granted");
          setState(() => _state = AppState.DATA_NOT_FETCHED);
        }
      }
      fetchStepData();
    } else {
      print("Authorization not granted");
      setState(() => _state = AppState.DATA_NOT_FETCHED);
      _permissiongranted = false;
      Hive_box_Homepage.put('permission', _permissiongranted);
    }
  }

  /// Add some random health data.

  /// Fetch steps from the health plugin and show them in the app.
  Future fetchStepData() async {
    bool requested = await health.requestAuthorization([HealthDataType.STEPS]);
    if (requested) {
      int? steps;
      List<int> temp = [0, 0, 0, 0, 0, 0, 0];
      for (int i = 0; i < DateTime.now().weekday; i++) {
        var midnight = new DateTime.now();
        var endday = new DateTime.now();
        while (midnight.weekday != i + 1) {
          midnight = midnight.subtract(new Duration(days: 1));
        }
        String x = midnight.toString();
        String y = midnight.toString();
        x = x.replaceRange(11, 23, "00:00:00.000");
        y = y.replaceRange(11, 23, "23:59:59.000");
        midnight = DateTime.parse(x); //midnight
        endday = DateTime.parse(y);
        bool requested =
            await health.requestAuthorization([HealthDataType.STEPS]);
        if (requested) {
          try {
            steps = await health.getTotalStepsInInterval(midnight, endday);
          } catch (error) {
            print("Caught exception in getTotalStepsInInterval: $error");
          }

          print(
              'Total number of steps from ${midnight.toString()} to ${endday.toString()} : $steps ');
          int index = midnight.weekday;
          temp[index - 1] = (steps == null) ? 0 : steps;
          Hive_box_Homepage.put('step_value', temp);
          step_list_month[index - 1] = StepData(day(index), temp[index - 1]);
          print("steps=${step_list_month}");
          setState(() {
            _nofSteps = (steps == null) ? 0 : steps;
            _state = (steps == null) ? AppState.NO_DATA : AppState.STEPS_READY;
          });
        } else {
          print("Authorization not granted");
          setState(() => _state = AppState.DATA_NOT_FETCHED);
        }
      }
    } else {
      print("Authorization not granted");
      setState(() => _state = AppState.DATA_NOT_FETCHED);
    }
  }

  Widget _contentFetchingData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            height: 10,
            width: 10,
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(
              color: pink2,
              strokeWidth: 10,
            )),
      ],
    );
  }

  Widget _contentDataReady() {
    List<double> temp = [0, 0, 0, 0, 0, 0, 0];
    double cal = 0;
    for (int i = 0; i < _calorieDataList.length; i++) {
      HealthDataPoint p = _calorieDataList[i];
      print("debug: ${p.dateFrom.weekday}");
      cal = cal + double.parse(p.value.toString());
      int index = p.dateFrom.weekday;
      calories_list_week[index - 1] = CalorieData(day(index), cal);
      print("length: ${calories_list_week.length}");
    }
    for (int i = 0; i < 7; i++) {
      temp[i] = calories_list_week[i].value;
    }
    int todayindex = DateTime.now().weekday;
    calories_today =
        double.parse(calories_list_week[todayindex - 1].value.toString());

    sleepdata = 0;
    for (int i = 0; i < _sleepDataList.length; i++) {
      HealthDataPoint p = _sleepDataList[i];
      print("debug: $_sleepDataList");
      sleepdata = sleepdata + double.parse(p.value.toString()).toInt();
    }
    // temp[4]=0;
    Hive_box_Homepage.put('calorie_value', temp);
    print("SUPER:$temp");

    return SizedBox.shrink();
  }

  Widget _contentNoData() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        'Looks like you haven\'t walked today.\nLets go for a walk!',
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          color: Color(0xFFADA4A5),
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _contentNotFetched() {
    return Column(
      children: [
        // Text('Press the download button to fetch data.'),
        // Text('Press the plus button to insert some random data.'),
        // Text('Press the walking button to get total step count.'),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Widget _authorizationNotGranted() {
    return Text('Authorization not given.');
  }

  Widget _dataAdded() {
    return Text('');
  }

  Widget _stepsFetched() {
    return Text('$_nofSteps');
  }

  Widget _dataNotAdded() {
    return Text('Failed to add data');
  }

  Widget _content() {
    if (_state == AppState.DATA_READY)
      return _contentDataReady();
    else if (_state == AppState.NO_DATA)
      return _contentNoData();
    else if (_state == AppState.FETCHING_DATA)
      return _contentFetchingData();
    else if (_state == AppState.AUTH_NOT_GRANTED)
      return _authorizationNotGranted();
    // else if (_state == AppState.DATA_ADDED)
    //   return _dataAdded();
    // else if (_state == AppState.STEPS_READY)
    //   return _stepsFetched();
    // else if (_state == AppState.DATA_NOT_ADDED) return _dataNotAdded();

    return _contentNotFetched();
  }

  @override
  void initState() {
    try {
      if (_permissiongranted == true) fetchData();
      // if(_permissiongranted==true)fetchStepData();
    } catch (e) {
      print("PERMISSION NOT GRANTED");
      _state = AppState.AUTH_NOT_GRANTED;
    }
    print("debug: $calories_list_week");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _homescreenpart=1;
    print("debug: $calories_list_week");

    return (_homescreenpart == 1)
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView(
                children: [
                  //ADD HOMESCREEN WIDGETS HERE
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                          top: 20, left: 10, right: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'HomePage_greeting'.tr().toString(),
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFFADA4A5),
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '$name',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          GestureDetector(
                            onTap: () {
                              _homescreenpart = 2;
                              setState(() {});
                            },
                            child: Container(
                              alignment: Alignment.topRight,
                              child: Image(
                                alignment: Alignment.topRight,
                                image: AssetImage('assets/images/Chat.png'),
                              ),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: SizeConfig.screenWidth * 0.8,
                      height: 130,
                      decoration: BoxDecoration(
                          color: pink1,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 20, bottom: 7),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'HomePage_BMIbox_text'.tr().toString(),
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                Text(
                                      (bmi < 18.5)
                                          ? 'HomePage_BMIbox_weight1'.tr().toString()
                                          : (bmi < 24.9)
                                              ? 'HomePage_BMIbox_weight2'.tr().toString()
                                              : (bmi < 29.9)
                                                  ? 'HomePage_BMIbox_weight3'.tr().toString()
                                                  : 'HomePage_BMIbox_weight4'.tr().toString(),
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: Container(
                                        height: 35,
                                        width: 94,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Center(
                                          child: Text(
                                            'HomePage_BMIbox_button'.tr().toString(),
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          ///todo:top padding to provide stack overlay issue
                          Padding(
                            padding: const EdgeInsets.only(right: 15,top: 50),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                height: 100,
                                width: 130,
                                child: Text(
                                  '$bmi',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 62,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      _homescreenpart = 3;
                      setState(() {});
                    },
                    child: Container(
                        width: SizeConfig.screenWidth * 0.8,
                        height: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/food_cover.png"),
                                fit: BoxFit.cover),
                            color: pink2,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                            child: Container(
                              color: Colors.black.withOpacity(0.3),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 15, bottom: 7),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'HomePage_dietbutton'.tr().toString(),
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        // ClipRRect( // make sure we apply clip it properly
                                        //   child: BackdropFilter(
                                        //     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                        //     child: Container(
                                        //       alignment: Alignment.center,
                                        //       color: Colors.grey.withOpacity(0.1),
                                        //       child:
                                        //     ),
                                        //   ),
                                        // ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       right: 19, bottom: 9),
                                  //   child: Align(
                                  //     alignment: Alignment.bottomRight,
                                  //     child: TextButton(
                                  //         onPressed: () {
                                  //           _homescreenpart = 3;
                                  //           setState(() {});
                                  //         },
                                  //         child: Container(
                                  //           height: 35,
                                  //           width: 94,
                                  //           decoration: BoxDecoration(
                                  //               color: pink1,
                                  //               borderRadius: BorderRadius.all(
                                  //                   Radius.circular(20))),
                                  //           child: Center(
                                  //             child: Text(
                                  //               'Check',
                                  //               textAlign: TextAlign.left,
                                  //               style: GoogleFonts.poppins(
                                  //                 fontWeight: FontWeight.w500,
                                  //                 color: Colors.white,
                                  //                 fontSize: 12,
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         )),
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                      width: SizeConfig.screenWidth * 0.8,
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Container(
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 20, bottom: 7),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                    'HomePage_periodbox_text'.tr().toString(),
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 13,
                                      ),
                                    ),
                                    // ClipRRect( // make sure we apply clip it properly
                                    //   child: BackdropFilter(
                                    //     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                    //     child: Container(
                                    //       alignment: Alignment.center,
                                    //       color: Colors.grey.withOpacity(0.1),
                                    //       child:
                                    //     ),
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 19, bottom: 9),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return PeriodInfoRegister(
                                                Hive_box_Homepage);
                                          },
                                        ),
                                      );
                                      // _homescreenpart = 5;
                                      // setState(() {});
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 94,
                                      decoration: BoxDecoration(
                                          color: pink1,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Center(
                                        child: Text(
                                          ///check
                                          'HomePage_periodbox_button'.tr().toString(),
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 15,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:[
                      TextButton(
                          onPressed: (){
                        setState(() {
                          context.locale = Locale('en','US');
                        });
            },
                          child: Text(
                            'English'
                          ),
                      ),
                      TextButton(
                        onPressed: (){
                          setState(() {
                            context.locale = Locale('ta','IN');
                          });
                        },
                        child: Text(
                            'Tamil'
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'HomePage_Activities'.tr().toString(),
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                          onPressed: () async {
                            fetchData();
                            setState(() {});
                          },
                          child: Icon(
                            Icons.refresh_rounded,
                            color: Colors.black54,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  (_permissiongranted == false)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'HomePage_Activities'.tr().toString(),
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  _permissiongranted = true;
                                  Hive_box_Homepage.put(
                                      'permission', _permissiongranted);
                                  fetchData();
                                },
                                child: Container(
                                  height: 35,
                                  width: 94,
                                  decoration: BoxDecoration(
                                      color: pink1,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Center(
                                    child: Text(
                                      'HomePage_link'.tr().toString(),
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        )
                      : Container(
                          width: SizeConfig.screenWidth * 0.8,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                  child: Container(
                                      height: (_state == AppState.DATA_READY)
                                          ? 1
                                          : (_state == AppState.FETCHING_DATA)
                                              ? 12
                                              : (_state ==
                                                          AppState
                                                              .AUTH_NOT_GRANTED ||
                                                      _state ==
                                                          AppState
                                                              .DATA_NOT_FETCHED)
                                                  ? 12
                                                  : 1,
                                      child: _content())),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 15, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // Text(
                                    //   'Calories Burnt',
                                    //   textAlign: TextAlign.left,
                                    //   style: GoogleFonts.poppins(
                                    //     fontWeight: FontWeight.w600,
                                    //     color: Colors.black,
                                    //     fontSize: 16,
                                    //   ),
                                    // ),
                                    // TextButton(
                                    //     onPressed: () async {
                                    //       fetchData();
                                    //       setState(() {});
                                    //     },
                                    //     child: Icon(
                                    //       Icons.refresh_rounded,
                                    //       color: Colors.black54,
                                    //     )),
                                  ],
                                ),
                              ),
                              // TextButton(
                              //     onPressed: () async {
                              //       fetchData();
                              //       setState(() {
                              //       });
                              //     },
                              //     child: Text("download")),
                              // TextButton(
                              //     onPressed: () {
                              //       fetchStepData();
                              //     },
                              //     child: Text("walk")),
                              // Container(height: 200, child: _content()),
                              // Container(
                              //     height: 200,
                              //     child: SfCartesianChart(
                              //         palette: <Color>[
                              //           pink1,
                              //         ],
                              //         primaryXAxis: CategoryAxis(),
                              //         tooltipBehavior: TooltipBehavior(
                              //           enable: true,
                              //         ),
                              //         series: <SplineSeries<CalorieData, String>>[
                              //           SplineSeries(
                              //               name: "Calories",
                              //               // isVisible: true,
                              //               cardinalSplineTension: 0,
                              //               emptyPointSettings:
                              //                   EmptyPointSettings(color: Colors.black),
                              //               yAxisName: "Calories burnt",
                              //               markerSettings: MarkerSettings(
                              //                   isVisible: true,
                              //                   height: 4,
                              //                   width: 4,
                              //                   shape: DataMarkerType.circle,
                              //                   borderWidth: 3,
                              //                   borderColor: pink1),
                              //               dataSource: calories_list,
                              //               xValueMapper: (CalorieData sales, _) => sales.day,
                              //               yValueMapper: (CalorieData sales, _) =>
                              //                   sales.value),
                              //         ])),
                              // SizedBox(
                              //   height: 15,
                              // ),
                              Container(
                                height: 170,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 1,
                                              blurRadius: 7,
                                              offset: Offset(1,
                                                  2), // changes position of shadow
                                            ),
                                          ],
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Stack(
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'HomePage_Activity1'.tr().toString(),
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12, top: 20),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: (_state ==
                                                            AppState
                                                                .AUTH_NOT_GRANTED ||
                                                        _state ==
                                                            AppState
                                                                .DATA_NOT_FETCHED)
                                                    ? Text(
                                                  'HomePage_Activity1'.tr().toString(),
                                                        textAlign:
                                                            TextAlign.left,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: pink1,
                                                          fontSize: 16,
                                                        ),
                                                      )
                                                    : Text(
                                                        durationToString(sleepdata)+" "+"HomePage_Activity1_hours".tr().toString() ,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: pink1,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                height: 80,
                                                width: 150,
                                                child: Image(
                                                  image: AssetImage(
                                                      'assets/images/Sleep-Graph.png'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 1,
                                              blurRadius: 7,
                                              offset: Offset(1,
                                                  2), // changes position of shadow
                                            ),
                                          ],
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15, left: 15, bottom: 10),
                                            child: Text(
                                              'HomePage_Activity2'.tr().toString(),
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: (_state ==
                                                        AppState
                                                            .AUTH_NOT_GRANTED ||
                                                    _state ==
                                                        AppState
                                                            .DATA_NOT_FETCHED)
                                                ? Text(
                                              'HomePage_nildata'.tr().toString(),
                                                    textAlign: TextAlign.left,
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: pink1,
                                                      fontSize: 40,
                                                    ),
                                                  )
                                                : Text(
                                                    '${calories_today.toStringAsFixed(0)}',
                                                    textAlign: TextAlign.left,
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: pink1,
                                                      fontSize: 35,
                                                    ),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 170,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 1,
                                              blurRadius: 7,
                                              offset: Offset(1,
                                                  2), // changes position of shadow
                                            ),
                                          ],
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Stack(
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'HomePage_Activity3'.tr().toString(),
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12, top: 20),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: (_state ==
                                                            AppState
                                                                .AUTH_NOT_GRANTED ||
                                                        _state ==
                                                            AppState
                                                                .DATA_NOT_FETCHED)
                                                    ? Text(
                                                        'HomePage_nildata'.tr().toString(),
                                                        textAlign:
                                                            TextAlign.left,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: pink1,
                                                          fontSize: 16,
                                                        ),
                                                      )
                                                    : Text(
                                                        '${_nofSteps}',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: pink1,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                height: 80,
                                                width: 150,
                                                child: Image(
                                                  image: AssetImage(
                                                      'assets/images/Sleep-Graph (1).png'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // OpenContainer(
                                    //   // colour just to identify
                                    //   closedElevation: 10.0,
                                    //   openElevation: 15.0,
                                    //   closedShape: const RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.all(
                                    //         Radius.circular(20.0)),
                                    //   ),
                                    //   transitionType:
                                    //       ContainerTransitionType.fade,
                                    //   transitionDuration:
                                    //       const Duration(milliseconds: 200),
                                    //   openBuilder: (context, action) {
                                    //     return FaqPage();
                                    //   },
                                    //   closedBuilder: (context, action) {
                                    //     return Container(
                                    //       height: 150,
                                    //       width: 150,
                                    //       decoration: BoxDecoration(
                                    //           boxShadow: [
                                    //             BoxShadow(
                                    //               color: Colors.grey
                                    //                   .withOpacity(0.3),
                                    //               spreadRadius: 1,
                                    //               blurRadius: 7,
                                    //               offset: Offset(1,
                                    //                   2), // changes position of shadow
                                    //             ),
                                    //           ],
                                    //           color: Colors.white,
                                    //           borderRadius: BorderRadius.all(
                                    //               Radius.circular(20))),
                                    //       child: Column(
                                    //         crossAxisAlignment:
                                    //             CrossAxisAlignment.start,
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.start,
                                    //         children: [
                                    //           Padding(
                                    //             padding: const EdgeInsets.only(
                                    //                 top: 15,
                                    //                 left: 15,
                                    //                 bottom: 10),
                                    //             child: Text(
                                    //               'FAQ Page',
                                    //               textAlign: TextAlign.left,
                                    //               style: GoogleFonts.poppins(
                                    //                 fontWeight: FontWeight.w500,
                                    //                 color: Colors.black,
                                    //                 fontSize: 12,
                                    //               ),
                                    //             ),
                                    //           ),
                                    //           Center(
                                    //             child: Icon(
                                    //               Icons.question_mark_sharp,
                                    //               color: pink1,
                                    //               size: 70,
                                    //             ),
                                    //           )
                                    //         ],
                                    //       ),
                                    //     );
                                    //   },
                                    // ),
                                    TextButton(
                                      onPressed: () {
                                        _homescreenpart = 4;
                                        print("FAQ page");
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                                spreadRadius: 1,
                                                blurRadius: 7,
                                                offset: Offset(1,
                                                    2), // changes position of shadow
                                              ),
                                            ],
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15,
                                                  left: 15,
                                                  bottom: 10),
                                              child: Text(
                                                'HomePage_Activity4'.tr().toString(),
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Icon(
                                                Icons.question_mark_sharp,
                                                color: pink1,
                                                size: 70,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(top: 10, left: 15, bottom: 10),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Text(
                              //         'Steps',
                              //         textAlign: TextAlign.left,
                              //         style: GoogleFonts.poppins(
                              //           fontWeight: FontWeight.w600,
                              //           color: Colors.black,
                              //           fontSize: 16,
                              //         ),
                              //       ),
                              //       TextButton(
                              //           onPressed: () async {
                              //             fetchData();
                              //             setState(() {});
                              //           },
                              //           child: Icon(
                              //             Icons.refresh_rounded,
                              //             color: Colors.black54,
                              //           )),
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //     height: 200,
                              //     child: SfCartesianChart(
                              //         palette: <Color>[
                              //           pink1,
                              //         ],
                              //         primaryXAxis: CategoryAxis(),
                              //         tooltipBehavior: TooltipBehavior(
                              //           enable: true,
                              //         ),
                              //         series: <SplineSeries<StepData, String>>[
                              //           SplineSeries(
                              //               name: "Steps",
                              //               // isVisible: true,
                              //               cardinalSplineTension: 0,
                              //               emptyPointSettings:
                              //               EmptyPointSettings(color: Colors.black),
                              //               yAxisName: "Steps",
                              //               markerSettings: MarkerSettings(
                              //                   isVisible: true,
                              //                   height: 4,
                              //                   width: 4,
                              //                   shape: DataMarkerType.circle,
                              //                   borderWidth: 3,
                              //                   borderColor: pink1),
                              //               dataSource: step_list,
                              //               xValueMapper: (StepData sales, _) => sales.day,
                              //               yValueMapper: (StepData sales, _) =>
                              //               sales.value),
                              //         ])),
                            ],
                          ),
                        ),
                  SizedBox(
                    height: 35,
                  )
                ],
              ),
            ),
          )
        : (_homescreenpart == 2)
            ? ForumPage()
            : (_homescreenpart == 3)
                ? FoodPage()
                : FaqPage();
  }
}

class CalorieData {
  CalorieData(this.day, this.value);

  final String day;
  final double value;
}

class StepData {
  StepData(this.day, this.value);

  final String day;
  final int value;
}

String day(int x) {
  if (x == 1)
    return "Mon";
  else if (x == 2)
    return "Tue";
  else if (x == 3)
    return "Wed";
  else if (x == 4)
    return "Thu";
  else if (x == 5)
    return "Fri";
  else if (x == 6)
    return "Sat";
  else if (x == 7)
    return "Sun";
  else
    return "IDK";
}

List<CalorieData> calories_list_week = [
  CalorieData(day(1), 0),
  CalorieData(day(2), 0),
  CalorieData(day(3), 0),
  CalorieData(day(4), 0),
  CalorieData(day(5), 0),
  CalorieData(day(6), 0),
  CalorieData(day(7), 0),
];
List<StepData> step_list_month = [
  StepData(day(1), 0),
  StepData(day(2), 0),
  StepData(day(3), 0),
  StepData(day(4), 0),
  StepData(day(5), 0),
  StepData(day(6), 0),
  StepData(day(7), 0),
];
int sleepdata = 0;
double calories_today = 0;

String durationToString(int minutes) {
  var d = Duration(minutes: minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
}
