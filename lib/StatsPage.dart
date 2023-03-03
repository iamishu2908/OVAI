import 'dart:io';
import 'package:pcod/HomePage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health/health.dart';
import 'package:pcod/LoginPage.dart';
import 'package:pcod/main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'HomePage.dart';
import 'package:animated_button_bar/animated_button_bar.dart';

AppState _state = AppState.DATA_NOT_FETCHED;
bool _permissiongranted = true;
bool show_week = true;

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

Color lightpink = Color(0xFFFCDDEC);

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  List<HealthDataPoint> _calorieDataList = [];
  List<HealthDataPoint> _sleepDataList = [];

  AppState _state = AppState.DATA_NOT_FETCHED;
  int _nofSteps = 10;
  double _mgdl = 10.0;

  // create a HealthFactory for use in the app
  HealthFactory health = HealthFactory();

  /// Fetch data points from the health plugin and show them in the app.
  Future fetchData() async {
    setState(() => _state = AppState.FETCHING_DATA);
    if (Platform.isAndroid) {
      var a = await Permission.activityRecognition.request().isGranted;
    }
    // define the types to get
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

    // get data within the last 24 hours
    // final now = DateTime.now();
    // final day_start = DateTime(now.year, now.month, now.day);
    // // DateTime.now().add(Duration(days: 6));
    // final day_end = DateTime.now();
    bool requested =
        await health.requestAuthorization(types, permissions: permissions);

    if (show_week == false) {
      for (int i = 0; i < DateTime.now().day; i++) {
        var midnight = new DateTime.now();
        var endday = new DateTime.now();
        while (midnight.day != i + 1) {
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
                    (DateTime.now().day == midnight.day)
                        ? DateTime.now()
                        : endday,
                    [HealthDataType.ACTIVE_ENERGY_BURNED]);
            List<HealthDataPoint> sleepDataPoint = await health
                .getHealthDataFromTypes(
                    midnight, endday, [HealthDataType.SLEEP_ASLEEP]);
            // print("health data on ${midnight.toString()}=$calorieDataPoint");
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
          // print("sleep=$_sleepDataList");
          // update the UI to display the results
          setState(() {
            _state = _calorieDataList.isEmpty
                ? AppState.NO_DATA
                : AppState.DATA_READY;
          });
        } else {
          print("Authorization not granted");
          setState(() => _state = AppState.DATA_NOT_FETCHED);
        }
      }
      fetchStepData();
    } else {
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
            // print("health data on ${midnight.toString()}=$calorieDataPoint");
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
          // print("sleep=$_sleepDataList");
          // update the UI to display the results
          setState(() {
            _state = _calorieDataList.isEmpty
                ? AppState.NO_DATA
                : AppState.DATA_READY;
          });
          // fetchStepData();

        } else {
          print("Authorization not granted");
          setState(() => _state = AppState.DATA_NOT_FETCHED);
        }
      }
      fetchStepData();
    }
  }

  /// Fetch steps from the health plugin and show them in the app.
  Future fetchStepData() async {
    if (show_week == false) {
      int? steps;
      List<int> temp = [for (int i = 0; i < 30; i++) 0];
      for (int i = 0; i < DateTime.now().day; i++) {
        var midnight = new DateTime.now();
        var endday = new DateTime.now();
        while (midnight.day != i + 1) {
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
          // print(
          //     'Total number of steps from ${midnight.toString()} to ${endday.toString()} : $steps ');
          int index = midnight.day;
          temp[index - 1] = (steps == null) ? 0 : steps;
          Hive_box_Homepage.put('step_value_month', temp);
          step_list_month[index - 1] =
              StepData(index.toString(), temp[index - 1]);
          // print("steps=${step_list_month}");
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
          // print(
          // 'Total number of steps from ${midnight.toString()} to ${endday.toString()} : $steps ');
          int index = midnight.weekday;
          temp[index - 1] = (steps == null) ? 0 : steps;
          Hive_box_Homepage.put('step_value', temp);
          step_list_week[index - 1] = StepData(day(index), temp[index - 1]);
          // print("steps=${step_list_week}");
          setState(() {
            _nofSteps = (steps == null) ? 0 : steps;
            _state = (steps == null) ? AppState.NO_DATA : AppState.STEPS_READY;
          });
        } else {
          print("Authorization not granted");
          setState(() => _state = AppState.DATA_NOT_FETCHED);
        }
      }
    }
  }

  Widget _contentFetchingData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            height: 20,
            width: 20,
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(
              color: pink2,
              strokeWidth: 10,
            )),
      ],
    );
  }

  Widget _contentDataReady() {
    if (show_week == false) {
      List<double> temp = [for (int i = 0; i < 30; i++) 0];
      double cal = 0;
      int index = 0;
      for (int i = 0; i < _calorieDataList.length; i++) {
        HealthDataPoint p = _calorieDataList[i];
        // print("debug: ${p.dateFrom.day}");
        cal = cal + double.parse(p.value.toString());
        index = p.dateFrom.day;
        calories_list_month[index - 1] = CalorieData(index.toString(), cal);
        // print("length: ${calories_list_month.length}");
      }
      for (int i = 0; i < index; i++) {
        temp[i] = calories_list_month[i].value;
      }
      int todayindex = DateTime.now().day;
      calories_today =
          double.parse(calories_list_month[todayindex - 1].value.toString());

      sleepdata = 0;
      for (int i = 0; i < _sleepDataList.length; i++) {
        HealthDataPoint p = _sleepDataList[i];
        // print("debug: $_sleepDataList");
        sleepdata = sleepdata + double.parse(p.value.toString()).toInt();
      }
      // temp[4]=0;
      Hive_box_Homepage.put('calorie_value_month', temp);
      // print("SUPER:$temp");

      return SizedBox.shrink();
    } else {
      List<double> temp = [0, 0, 0, 0, 0, 0, 0];
      double cal = 0;
      int index = 0;
      for (int i = 0; i < _calorieDataList.length; i++) {
        HealthDataPoint p = _calorieDataList[i];
        // print("debug: ${p.dateFrom.weekday}");
        cal = cal + double.parse(p.value.toString());
        index = p.dateFrom.weekday;
        calories_list_week[index - 1] = CalorieData(day(index), cal);
        // print("length: ${calories_list_week.length}");
      }
      for (int i = 0; i < index; i++) {
        temp[i] = calories_list_week[i].value;
      }
      int todayindex = DateTime.now().weekday;
      calories_today =
          double.parse(calories_list_week[todayindex - 1].value.toString());

      sleepdata = 0;
      for (int i = 0; i < _sleepDataList.length; i++) {
        HealthDataPoint p = _sleepDataList[i];
        // print("debug: $_sleepDataList");
        sleepdata = sleepdata + double.parse(p.value.toString()).toInt();
      }
      // temp[4]=0;
      Hive_box_Homepage.put('calorie_value', temp);
      // print("SUPER:$temp");

      return SizedBox.shrink();
    }
  }

  Widget _contentNoData() {
    return Text(
      'StatsPage_weektab_nodata'.tr().toString(),
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
    _permissiongranted = (Hive_box.get('permission') == null)
        ? true
        : Hive_box.get('permission');
    if (_permissiongranted == true) fetchData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19),
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView(children: [
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(
                  top: 26, left: 5, right: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'StatsPage_title'.tr().toString(),
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 24,
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
              )),
          // SizedBox(
          //   height: 8,
          // ),
          Container(
            height: 50,
            width: 150,
            child: AnimatedButtonBar(
              foregroundColor: pink1,
              backgroundColor: Colors.white,
              radius: 8.0,
              padding: const EdgeInsets.all(5.0),
              invertedSelection: true,
              children: [
                ButtonBarEntry(
                    onTap: () {
                      show_week = true;
                      setState(() {});
                    },
                    child: Text(
                      //'Week',
                      'StatsPage_weektab_title'.tr().toString(),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    )),
                ButtonBarEntry(
                    onTap: () {
                      show_week = false;
                      setState(() {});
                    },
                    child: Text(
                      // 'Month',
                      'StatsPage_month'.tr().toString(),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    )),
              ],
            ),
          ),
          // Text(
          //   'Activity Status',
          //   textAlign: TextAlign.left,
          //   style: GoogleFonts.poppins(
          //     fontWeight: FontWeight.w600,
          //     color: Colors.black,
          //     fontSize: 16,
          //   ),
          // ),
          // SizedBox(
          //   height: 15,
          // ),
          (_permissiongranted == true)
              ? Container(
                  // height: 600,
                  width: SizeConfig.screenWidth * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Container(
                              height: (_state == AppState.DATA_READY)
                                  ? 30
                                  : (_state == AppState.FETCHING_DATA)
                                      ? 30
                                      : (_state == AppState.AUTH_NOT_GRANTED ||
                                              _state ==
                                                  AppState.DATA_NOT_FETCHED)
                                          ? 30
                                          : 30,
                              child: _content())),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 15, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'StatsPage_weektab_calorieschart'.tr().toString(),
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
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

                      Container(
                        height: 200,
                        child: Stack(children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: 11,
                                  left: 49 +
                                      (40 *
                                          double.parse(
                                              (DateTime.now().weekday - 1)
                                                  .toString()))),
                              child: Container(
                                height: 16,
                                width: (show_week == true) ? 33 : 16,
                                decoration: BoxDecoration(
                                    color: pink2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                          ),
                          Container(
                              height: 200,
                              child: SfCartesianChart(
                                  enableAxisAnimation: true,
                                  palette: <Color>[
                                    pink1,
                                  ],
                                  primaryXAxis: CategoryAxis(),
                                  tooltipBehavior: TooltipBehavior(
                                    enable: true,
                                  ),
                                  series: <SplineSeries<CalorieData, String>>[
                                    SplineSeries(
                                        name: 'StatsPage_weektab_calories'
                                            .tr()
                                            .toString(),
                                        // isVisible: true,
                                        cardinalSplineTension: 0,
                                        emptyPointSettings: EmptyPointSettings(
                                            color: Colors.black),
                                        yAxisName:
                                            //"Calories burnt",
                                            'StatsPage_weektab_calorieschart'
                                                .tr()
                                                .toString(),
                                        markerSettings: MarkerSettings(
                                            isVisible: true,
                                            height: 4,
                                            width: 4,
                                            shape: DataMarkerType.circle,
                                            borderWidth: 3,
                                            borderColor: pink1),
                                        dataSource: (show_week == true)
                                            ? calories_list_week
                                            : calories_list_month,
                                        xValueMapper: (CalorieData sales, _) =>
                                            sales.day,
                                        yValueMapper: (CalorieData sales, _) =>
                                            sales.value),
                                  ])),
                        ]),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 170,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(
                                          1, 2), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Stack(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        //'Duration slept today',
                                        'StatsPage_weektab_hoursslept_title'
                                            .tr()
                                            .toString(),
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
                                          left: 12, top: 32),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: (_state ==
                                                    AppState.AUTH_NOT_GRANTED ||
                                                _state ==
                                                    AppState.DATA_NOT_FETCHED)
                                            ? Text(
                                                'StatsPage_weektab_notavailable'
                                                    .tr()
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w700,
                                                  color: pink1,
                                                  fontSize: 16,
                                                ),
                                              )
                                            : Text(
                                                durationToString(sleepdata) +
                                                    " " +
                                                    'StatsPage_weektab_hoursslept'
                                                        .tr()
                                                        .toString(),
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w700,
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
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(
                                          1, 2), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 15, bottom: 10),
                                    child: Text(
                                      // 'Calories burnt\ntoday',
                                      'StatsPage_weektab_caloriesburnt'
                                          .tr()
                                          .toString(),
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
                                                AppState.AUTH_NOT_GRANTED ||
                                            _state == AppState.DATA_NOT_FETCHED)
                                        ? Text(
                                            'StatsPage_weektab_notavailable'
                                                .tr()
                                                .toString(),
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: pink1,
                                              fontSize: 40,
                                            ),
                                          )
                                        : Text(
                                            '${calories_today.toStringAsFixed(0)}',
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
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
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 15, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'StatsPage_weektab_stepsshart'.tr().toString(),
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
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
                      Container(
                        height: 200,
                        child: Stack(children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: 11,
                                  left: 41 +
                                      (40 *
                                          double.parse(
                                              (DateTime.now().weekday - 1)
                                                  .toString()))),
                              child: Container(
                                height: 16,
                                width: (show_week == true) ? 33 : 16,
                                decoration: BoxDecoration(
                                    color: pink2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                          ),
                          Container(
                              height: 200,
                              child: SfCartesianChart(
                                  palette: <Color>[
                                    pink1,
                                  ],
                                  primaryXAxis: CategoryAxis(),
                                  tooltipBehavior: TooltipBehavior(
                                    enable: true,
                                  ),
                                  series: <SplineSeries<StepData, String>>[
                                    SplineSeries(
                                        name: 'StatsPage_weektab_stepsshart'
                                            .tr()
                                            .toString(),
                                        cardinalSplineTension: 0,
                                        emptyPointSettings: EmptyPointSettings(
                                            color: Colors.black),
                                        yAxisName: "StatsPage_weektab_stepswalk"
                                            .tr()
                                            .toString(),
                                        markerSettings: MarkerSettings(
                                            isVisible: true,
                                            height: 4,
                                            width: 4,
                                            shape: DataMarkerType.circle,
                                            borderWidth: 3,
                                            borderColor: pink1),
                                        dataSource: (show_week == true)
                                            ? step_list_week
                                            : step_list_month,
                                        xValueMapper: (StepData sales, _) =>
                                            sales.day,
                                        yValueMapper: (StepData sales, _) =>
                                            sales.value),
                                  ])),
                        ]),
                      ),
                    ],
                  ),
                )
              : Text(
                  'StatsPage_linkgooglefit'.tr().toString(),
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),

          SizedBox(
            height: 50,
          )
        ]),
      ),
    );
  }
}

List<CalorieData> calories_list_month = [
  for (int i = 1; i < 32; i++) CalorieData("$i", 0),
];
List<CalorieData> calories_list_week = [
  CalorieData(day(1), 0),
  CalorieData(day(2), 0),
  CalorieData(day(3), 0),
  CalorieData(day(4), 0),
  CalorieData(day(5), 0),
  CalorieData(day(6), 0),
  CalorieData(day(7), 0),
];

List<StepData> step_list_week = [
  StepData(day(1), 0),
  StepData(day(2), 0),
  StepData(day(3), 0),
  StepData(day(4), 0),
  StepData(day(5), 0),
  StepData(day(6), 0),
  StepData(day(7), 0),
];

List<StepData> step_list_month = [
  for (int i = 1; i < 32; i++) StepData("$i", 0),
];
