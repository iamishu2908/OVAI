import 'dart:io';
import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pcod/main.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:pcod/thirdscreen.dart';
import 'package:animated_button_bar/animated_button_bar.dart';
import 'HomePage.dart';
import 'package:scroll_navigation/scroll_navigation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<ClassExerciseTemplate> exerciseDay1 = [];
List<ClassExerciseTemplate> exerciseDay2 = [];
List<ClassExerciseTemplate> exerciseDay3 = [];
List<ClassExerciseTemplate> exerciseDay4 = [];
List<ClassExerciseTemplate> exerciseDay5 = [];
List<ClassExerciseTemplate> exerciseDay6 = [];

getExerciseAPI() async {
  exerciseDay1 = [];
  exerciseDay2 = [];
  exerciseDay3 = [];
  exerciseDay4 = [];
  exerciseDay5 = [];
  exerciseDay6 = [];

  var exerciseDay1_url = Uri.parse(
      'https://gist.githubusercontent.com/MaddyDev-glitch/c710271651875ab7d2add938cdb6e2ba/raw/exercise_day1.json');
  var exerciseDay2_url = Uri.parse(
      'https://gist.githubusercontent.com/MaddyDev-glitch/c710271651875ab7d2add938cdb6e2ba/raw/exercise_day1.json');
  var exerciseDay3_url = Uri.parse(
      'https://gist.githubusercontent.com/MaddyDev-glitch/c710271651875ab7d2add938cdb6e2ba/raw/exercise_day1.json');
  var exerciseDay4_url = Uri.parse(
      'https://gist.githubusercontent.com/MaddyDev-glitch/c710271651875ab7d2add938cdb6e2ba/raw/exercise_day1.json');
  var exerciseDay5_url = Uri.parse(
      'https://gist.githubusercontent.com/MaddyDev-glitch/c710271651875ab7d2add938cdb6e2ba/raw/exercise_day1.json');
  var exerciseDay6_url = Uri.parse(
      'https://gist.githubusercontent.com/MaddyDev-glitch/c710271651875ab7d2add938cdb6e2ba/raw/exercise_day1.json');
  var exerciseDay1_response = await http.get(exerciseDay1_url);
  var exerciseDay2_response = await http.get(exerciseDay2_url);
  var exerciseDay3_response = await http.get(exerciseDay3_url);
  var exerciseDay4_response = await http.get(exerciseDay4_url);
  var exerciseDay5_response = await http.get(exerciseDay5_url);
  var exerciseDay6_response = await http.get(exerciseDay6_url);

  print('Response status: ${exerciseDay1_response.statusCode}');
  print('Response body: ${exerciseDay1_response.body}');

  final List<dynamic> exerciseDay1_data =
      await json.decode(exerciseDay1_response.body)['exercises'];

  if (exerciseDay1_response.statusCode == 200) {
    for (int i = 0; i < exerciseDay1_data.length; i++) {
      exerciseDay1.add(ClassExerciseTemplate(
          exerciseDay1_data[i]['title'],
          exerciseDay1_data[i]['image'],
          exerciseDay1_data[i]['instruction'],
          exerciseDay1_data[i]['video'],
          exerciseDay1_data[i]['isInfo']));
    }
    print("check ${exerciseDay1[0].title} ${exerciseDay1[0].imagepath}");
  }
  final List<dynamic> exerciseDay2_data =
      await json.decode(exerciseDay2_response.body)['exercises'];
  if (exerciseDay2_response.statusCode == 200) {
    for (int i = 0; i < exerciseDay2_data.length; i++) {
      exerciseDay2.add(ClassExerciseTemplate(
          exerciseDay2_data[i]['title'],
          exerciseDay2_data[i]['image'],
          exerciseDay2_data[i]['instruction'],
          exerciseDay2_data[i]['video'],
          exerciseDay2_data[i]['isInfo']));
    }
  }
  final List<dynamic> exerciseDay3_data =
      await json.decode(exerciseDay3_response.body)['exercises'];
  if (exerciseDay3_response.statusCode == 200) {
    for (int i = 0; i < exerciseDay3_data.length; i++) {
      exerciseDay3.add(ClassExerciseTemplate(
          exerciseDay3_data[i]['title'],
          exerciseDay3_data[i]['image'],
          exerciseDay3_data[i]['instruction'],
          exerciseDay3_data[i]['video'],
          exerciseDay3_data[i]['isInfo']));
    }
  }
  final List<dynamic> exerciseDay4_data =
      await json.decode(exerciseDay4_response.body)['exercises'];
  if (exerciseDay4_response.statusCode == 200) {
    for (int i = 0; i < exerciseDay4_data.length; i++) {
      exerciseDay4.add(ClassExerciseTemplate(
          exerciseDay4_data[i]['title'],
          exerciseDay4_data[i]['image'],
          exerciseDay4_data[i]['instruction'],
          exerciseDay4_data[i]['video'],
          exerciseDay4_data[i]['isInfo']));
    }
  }

  final List<dynamic> exerciseDay5_data =
      await json.decode(exerciseDay5_response.body)['exercises'];
  if (exerciseDay5_response.statusCode == 200) {
    for (int i = 0; i < exerciseDay5_data.length; i++) {
      exerciseDay5.add(ClassExerciseTemplate(
          exerciseDay5_data[i]['title'],
          exerciseDay5_data[i]['image'],
          exerciseDay5_data[i]['instruction'],
          exerciseDay5_data[i]['video'],
          exerciseDay5_data[i]['isInfo']));
    }
  }

  final List<dynamic> exerciseDay6_data =
      await json.decode(exerciseDay6_response.body)['exercises'];
  if (exerciseDay6_response.statusCode == 200) {
    for (int i = 0; i < exerciseDay6_data.length; i++) {
      exerciseDay6.add(ClassExerciseTemplate(
          exerciseDay6_data[i]['title'],
          exerciseDay6_data[i]['image'],
          exerciseDay6_data[i]['instruction'],
          exerciseDay6_data[i]['video'],
          exerciseDay6_data[i]['isInfo']));
    }
  }
}

class ClassExerciseTemplate {
  String title, imagepath, instruction, videopath;
  String isInfo;
  ClassExerciseTemplate(this.title, this.imagepath, this.instruction,
      this.videopath, this.isInfo);
}

List<String> dailyyogaposes = [
  'Samisthithi',
  'Uttanasana',
  'Phalakasana',
  'Adho Mukha Svanasana',
  'Veerbhadrasana 1',
  'Eka Pada Adho Mukha Svanasana',
  'Veerabhadrasana 2',
  'Veerabhadrasana 3',
  'Utkatasana',
  'Bhujagasana',
  'Bidalasana',
  'Bitilasana',
  'Ustrasana',
  'Setubandhasana',
  'Catur Svanasana',
  'Salabhasana',
];
List<String> FullBodyPoses = [
  'Eka Pada Padangusthasana',
  'Trikonasana',
  'Vrikshasana',
  'Utthita ashwa sanchalanasana',
  'Parsvakonasana',
  'Utthita Parsvakonasana',
  'Urdhva Virabhadrasana',
  'Parivrtta Anjaneyasana',
  'Garudasana',
  'Prasarita Padottanasana',
  'Paschimottanasana',
  'Marichhasana C',
  'Malasana',
  'Baddhakonasana',
  'Eka Pada Rajakapotasana',
  'Sarvangasana',
];
List<String> PosesForRepair = [
  'Parivrtta Sukhasana',
  'Upavishtakonasana',
  'Marichhasana A',
  'Shasangasana',
  'Gomukhasana',
  'Janushirshasana',
  'Balasana',
  'Salambh Bhujagasana',
  'Uttana Shishosana',
  'Bharmanasana',
  'Utthan Pristhasana',
  'Urdhva Mukha Pasasana',
  'Supta Matsyendrasana',
  'Supta Baddha Konasana',
  'Supta padagushtasana',
  'Anand Balasana',
];

bool workoutswitcher = true;
int exercisepagecontroller = 1;

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

Color lightpink = Color(0xFFFCDDEC);

class exerciseandyoga extends StatefulWidget {
  const exerciseandyoga({Key? key}) : super(key: key);

  @override
  State<exerciseandyoga> createState() => _exerciseandyogaState();
}

class _exerciseandyogaState extends State<exerciseandyoga> {
  void initState() {
    getExerciseAPI();
    super.initState();
  }
  // Widget workout_animated_widget = yogapage();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
          child: (exercisepagecontroller == 1)
              ? DefaultTabController(
                  length: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 30, left: 5, right: 10,bottom: 15),
                    child: Container(
                      height: SizeConfig.screenHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 19),
                            child: Text(
                              //'Exercises and Yoga',
                              'exerciseandyoga_pagetitle'.tr().toString(),
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ///todo:bottom pixel overflow fixed
                          Container(
                            height: SizeConfig.screenHeight - MediaQuery.of(context).size.height*0.25,
                            child: TitleScrollNavigation(
                              identiferStyle:
                                  NavigationIdentiferStyle(color: pink1),
                              barStyle: TitleNavigationBarStyle(
                                deactiveColor: Colors.black,
                                elevation: 0,
                                activeColor: pink1,
                                background: Colors.white,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40.0, vertical: 10),
                                spaceBetween: 150,
                              ),
                              titles: [
                                'exerciseandyoga_tab1'.tr().toString(),
                                'exerciseandyoga_tab2'.tr().toString(),
                              ],
                              pages: [
                                exercisepage(),
                                yogapage(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  initialIndex: 0,
                )
              : (exercisepagecontroller == 2)
                  ? workoutGallery(false, "Daily Yoga Poses", "16 Yogas", "")
                  : (exercisepagecontroller == 3)
                      ? workoutGallery(false, "Full Body Poses", "16 Yogas", "")
                      : (exercisepagecontroller == 4)
                          ? workoutGallery(
                              false, "Poses for Repair", "16 Yogas", " ")
                          : (exercisepagecontroller == 5)
                              ? workoutGallery(
                                  true, "Day 1", "9 Exercise | 15 mins", " ")
                              : (exercisepagecontroller == 6)
                                  ? workoutGallery(true, "Day 2",
                                      "9 Exercise | 15 mins", " ")
                                  : (exercisepagecontroller == 7)
                                      ? workoutGallery(true, "Day 3",
                                          "9 Exercise | 15 mins", " ")
                                      : (exercisepagecontroller == 8)
                                          ? workoutGallery(true, "Day 4",
                                              "9 Exercise | 15 mins", " ")
                                          : (exercisepagecontroller == 9)
                                              ? workoutGallery(true, "Day 5",
                                                  "9 Exercise | 15 mins", " ")
                                              : workoutGallery(true, "Day 6",
                                                  "9 Exercise | 15 mins", " ")
          // : workoutGallery(false, "Poses for Repair", "16 Yogas", ""),
          ),
    );
  }

  Widget exercisepage() {
    return Padding(
      key: ValueKey<int>(0),
      padding: const EdgeInsets.symmetric(
        horizontal: 19,
      ),
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              'exerciseandyoga_exercise_note'.tr().toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                color: Colors.black54,
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                exercisepagecontroller = 5;
                setState(() {
                  print("setstate $exercisepagecontroller");
                });
              },
              child: WorkoutCard(true, "Day 1", "9 Exercies | 15 mins",
                  "assets/images/beginner_image.png"),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                exercisepagecontroller = 6;
                setState(() {
                  print("setstate $exercisepagecontroller");
                });
              },
              child: WorkoutCard(true, "Day 2", "12 Exercises | 40mins",
                  "assets/images/intermediate_image.png"),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                exercisepagecontroller = 7;
                setState(() {
                  print("setstate $exercisepagecontroller");
                });
              },
              child: WorkoutCard(true, "Day 3", "14 Exercises | 20mins",
                  "assets/images/advanced_image.png"),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                exercisepagecontroller = 8;
                setState(() {
                  print("setstate $exercisepagecontroller");
                });
              },
              child: WorkoutCard(true, "Day 4", "9 Exercies | 15 mins",
                  "assets/images/beginner_image.png"),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                exercisepagecontroller = 9;
                setState(() {
                  print("setstate $exercisepagecontroller");
                });
              },
              child: WorkoutCard(true, "Day 5", "9 Exercies | 15 mins",
                  "assets/images/beginner_image.png"),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                exercisepagecontroller = 10;
                setState(() {
                  print("setstate $exercisepagecontroller");
                });
              },
              child: WorkoutCard(true, "Day 6", "9 Exercies | 15 mins",
                  "assets/images/beginner_image.png"),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget yogapage() {
    return Padding(
      key: ValueKey<int>(1),
      padding: const EdgeInsets.symmetric(horizontal: 19),
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView(children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'exerciseandyoga_yoganote'.tr().toString(),
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              color: Colors.black54,
              fontSize: 12,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            onPressed: () {
              exercisepagecontroller = 2;
              setState(() {
                print("setstate $exercisepagecontroller");
              });
            },
            child: WorkoutCard(false, "Daily Yoga Poses", "12 Yogas",
                "assets/images/yogaicon1.png"),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            onPressed: () {
              exercisepagecontroller = 3;
              setState(() {
                print("setstate $exercisepagecontroller");
              });
            },
            child: WorkoutCard(false, "Full Body Poses", "12 Yogas ",
                "assets/images/yogaicon2.png"),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            onPressed: () {
              exercisepagecontroller = 4;
              setState(() {
                print("setstate $exercisepagecontroller");
              });
            },
            child: WorkoutCard(false, "Poses for Repair", "12 Yogas ",
                "assets/images/yogaicon3.png"),
          ),
          SizedBox(
            height: 17,
          ),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    'exerciseandyoga_yoganote2'.tr().toString(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'exerciseandyoga_yoganote3'.tr().toString(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              )),
        ]),
      ),
    );
  }

  ///second screen
  Widget workoutGallery(
      bool exercise, String level, String count, String comments) {
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: ListView(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          // color: Colors.amber,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size(50, 80),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  alignment: Alignment.center),
                              onPressed: () {
                                exercisepagecontroller = 1;
                                setState(() {
                                  print("DONE");
                                });
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 19),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (exercise == true) ? "Exercises" : "Yoga",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 24,
                                ),
                              ),
                              Text(
                                '${level}',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${count}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                // Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 19),
                //     child: (exercise == true)
                //         ? Container(
                //             height: 53,
                //             width: 150,
                //             child: AnimatedButtonBar(
                //               foregroundColor: pink1,
                //               backgroundColor: Colors.white,
                //               radius: 8.0,
                //               padding: const EdgeInsets.all(5.0),
                //               invertedSelection: true,
                //               children: [
                //                 ButtonBarEntry(
                //                     onTap: () {
                //                       setState(() {});
                //                     },
                //                     child: Text(
                //                       'Beginner',
                //                       style: GoogleFonts.poppins(
                //                         fontWeight: FontWeight.w600,
                //                         color: Colors.black,
                //                         fontSize: 12,
                //                       ),
                //                     )),
                //                 ButtonBarEntry(
                //                     onTap: () {
                //                       setState(() {});
                //                     },
                //                     child: Text(
                //                       'Intermediate',
                //                       style: GoogleFonts.poppins(
                //                         fontWeight: FontWeight.w600,
                //                         color: Colors.black,
                //                         fontSize: 12,
                //                       ),
                //                     )),
                //                 ButtonBarEntry(
                //                     onTap: () {
                //                       setState(() {});
                //                     },
                //                     child: Text(
                //                       'Advanced',
                //                       style: GoogleFonts.poppins(
                //                         fontWeight: FontWeight.w600,
                //                         color: Colors.black,
                //                         fontSize: 12,
                //                       ),
                //                     )),
                //               ],
                //             ),
                //           )
                //         : Container()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: (exercise == false && level == "Daily Yoga Poses")
                      ? Container(
                          height: 8 * 185,
                          child: GridView.count(
                            physics: new NeverScrollableScrollPhysics(),
                            primary: true,
                            padding: const EdgeInsets.all(0),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            children: <Widget>[
                              for (int i = 1; i < 17; i++)
                                YogaBox("assets/images/yoga2/$i.png",
                                    dailyyogaposes[i - 1], i - 1),
                            ],
                          ),
                        )
                      : (exercise == false && level == "Full Body Poses")
                          ? Container(
                              height: 8 * 185,
                              child: GridView.count(
                                physics: new NeverScrollableScrollPhysics(),
                                primary: true,
                                padding: const EdgeInsets.all(0),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 2,
                                children: <Widget>[
                                  for (int i = 1; i < 17; i++)
                                    YogaBox("assets/images/yoga1/$i.png",
                                        FullBodyPoses[i - 1], i - 1),
                                ],
                              ),
                            )
                          : (exercise == false && level == "Poses for Repair")
                              ? Container(
                                  height: 8 * 185,
                                  child: GridView.count(
                                    physics: new NeverScrollableScrollPhysics(),
                                    primary: true,
                                    padding: const EdgeInsets.all(0),
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 2,
                                    children: <Widget>[
                                      for (int i = 1; i < 17; i++)
                                        YogaBox("assets/images/yoga3/$i.png",
                                            PosesForRepair[i - 1], i - 1),
                                    ],
                                  ),
                                )
                              : (exercise == true && level == "Day 1")
                                  ? Container(
                                      height: 8 * 115,
                                      child: ListView(
                                        physics:
                                            new NeverScrollableScrollPhysics(),
                                        children: [
                                          for (int i = 0;
                                              i < exerciseDay1.length;
                                              i++)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: ExerciseBox(
                                                  exerciseDay1[i].imagepath,
                                                  exerciseDay1[i].title,
                                                  i.toString(),
                                                  exerciseDay1[i].instruction,
                                                  exerciseDay1[i].isInfo),
                                            ),
                                        ],
                                      ),
                                    )
                                  : (exercise == true && level == "Day 2")
                                      ? Container(
                                          height: 8 * 115,
                                          child: ListView(
                                            physics:
                                                new NeverScrollableScrollPhysics(),
                                            children: [
                                              for (int i = 0;
                                                  i < exerciseDay2.length;
                                                  i++)
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: ExerciseBox(
                                                      exerciseDay2[i].imagepath,
                                                      exerciseDay2[i].title,
                                                      i.toString(),
                                                      exerciseDay2[i]
                                                          .instruction,
                                                      exerciseDay2[i].isInfo),
                                                ),
                                            ],
                                          ),
                                        )
                                      : (exercise == true && level == "Day 3")
                                          ? Container(
                                              height: 8 * 115,
                                              child: ListView(
                                                physics:
                                                    new NeverScrollableScrollPhysics(),
                                                children: [
                                                  for (int i = 0;
                                                      i < exerciseDay3.length;
                                                      i++)
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10),
                                                      child: ExerciseBox(
                                                          exerciseDay3[i]
                                                              .imagepath,
                                                          exerciseDay3[i].title,
                                                          i.toString(),
                                                          exerciseDay3[i]
                                                              .instruction,
                                                          exerciseDay3[i]
                                                              .isInfo),
                                                    ),
                                                ],
                                              ),
                                            )
                                          : (exercise == true &&
                                                  level == "Day 4")
                                              ? Container(
                                                  height: 8 * 115,
                                                  child: ListView(
                                                    physics:
                                                        new NeverScrollableScrollPhysics(),
                                                    children: [
                                                      for (int i = 0;
                                                          i <
                                                              exerciseDay4
                                                                  .length;
                                                          i++)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10),
                                                          child: ExerciseBox(
                                                              exerciseDay4[i]
                                                                  .imagepath,
                                                              exerciseDay4[i]
                                                                  .title,
                                                              i.toString(),
                                                              exerciseDay4[i]
                                                                  .instruction,
                                                              exerciseDay4[i]
                                                                  .isInfo),
                                                        ),
                                                    ],
                                                  ),
                                                )
                                              : (exercise == true &&
                                                      level == "Day 5")
                                                  ? Container(
                                                      height: 8 * 115,
                                                      child: ListView(
                                                        physics:
                                                            new NeverScrollableScrollPhysics(),
                                                        children: [
                                                          for (int i = 0;
                                                              i <
                                                                  exerciseDay5
                                                                      .length;
                                                              i++)
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          10),
                                                              child: ExerciseBox(
                                                                  exerciseDay5[
                                                                          i]
                                                                      .imagepath,
                                                                  exerciseDay5[
                                                                          i]
                                                                      .title,
                                                                  i.toString(),
                                                                  exerciseDay5[
                                                                          i]
                                                                      .instruction,
                                                                  exerciseDay5[
                                                                          i]
                                                                      .isInfo),
                                                            ),
                                                        ],
                                                      ),
                                                    )
                                                  : (exercise == true &&
                                                          level == "Day 6")
                                                      ? Container(
                                                          height: 8 * 115,
                                                          child: ListView(
                                                            physics:
                                                                new NeverScrollableScrollPhysics(),
                                                            children: [
                                                              for (int i = 0;
                                                                  i <
                                                                      exerciseDay6
                                                                          .length;
                                                                  i++)
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          10),
                                                                  child: ExerciseBox(
                                                                      exerciseDay6[
                                                                              i]
                                                                          .imagepath,
                                                                      exerciseDay6[
                                                                              i]
                                                                          .title,
                                                                      i
                                                                          .toString(),
                                                                      exerciseDay6[
                                                                              i]
                                                                          .instruction,
                                                                      exerciseDay6[
                                                                              i]
                                                                          .isInfo),
                                                                ),
                                                            ],
                                                          ),
                                                        )
                                                      : Container(
                                                          height: 16 * 115,
                                                          child: ListView(
                                                            physics:
                                                                new NeverScrollableScrollPhysics(),
                                                            children: [
                                                              for (int i = 1;
                                                                  i < 17;
                                                                  i++)
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          10),
                                                                  child: ExerciseBox(
                                                                      "assets/images/yoga1/$i.png",
                                                                      "DUMMY DATA ",
                                                                      "DELETE",
                                                                      exerciseDay1[
                                                                              i]
                                                                          .instruction,
                                                                      exerciseDay1[
                                                                              i]
                                                                          .isInfo),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WorkoutCard extends StatelessWidget {
  String diff_level, info, image_path;
  bool exercises;
  WorkoutCard(this.exercises, this.diff_level, this.info, this.image_path);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: SizeConfig.screenWidth * 0.9,
        height: 140,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0x44EF5DA8),
                Color(0x33EEA4CE),
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 7),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$diff_level',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '$info',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 35,
                        width: 94,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFFEF5DA8),
                                Color(0xFFEEA4CE),
                              ],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: Text(
                            'View More',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 100,
                  width: 92,
                  child: Image(
                    image: AssetImage('$image_path'),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class YogaBox extends StatelessWidget {
  String image_path, name = "name";
  int indexpressed;
  YogaBox(this.image_path, this.name, this.indexpressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [pink1, pink2]),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: GestureDetector(
          onTap: () => showDialog<String>(
      context: context,
      builder: (BuildContext context) => Container(
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content:Container(
            height: MediaQuery.of(context).size.height*0.5,
            child: Column(
                children: [
            Padding(
            padding:
            const EdgeInsets.only(top: 0, left: 5, right: 10, bottom: 10),
            child: Container(
              child: Flexible(
                child: Text(
                  "${name}",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                  },
                  icon: Icon(
                    Icons.chevron_left_rounded,
                    color: Colors.black,
                  )),
              Container(
                width: SizeConfig.screenWidth * 0.5,
                child: Image.asset(
                  "${image_path}",
                  fit: BoxFit.cover,
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.black,
                  ))
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Text(
                "Hold the position for 30 seconds",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          ],
            ),
          ),
    ),
      ),
          ),
           child:Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.02),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(1, 2), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(20))),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Image(
                    height: 90,
                    image: AssetImage('$image_path'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    '$name',
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      );
  }
}

class ExerciseBox extends StatefulWidget {
  String image_path, name = "name", reps = "15", isInfo, inst = 'instructions';
  ExerciseBox(this.image_path, this.name, this.reps, this.inst, this.isInfo);

  @override
  State<ExerciseBox> createState() => _ExerciseBoxState();
}

class _ExerciseBoxState extends State<ExerciseBox> {
  bool expand = false;

  @override
  Widget build(BuildContext context) {
    print(widget.image_path);
    return (widget.isInfo == "0")
        ? Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [pink1, pink2]),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: GestureDetector(
                onTap: () {
                  expand = !expand;
                  setState(() {});
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.02),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(1, 2), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: const EdgeInsets.all(12),
                    child: (expand == false)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      const Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/loadingImage.png'),
                                  ),
                                  placeholder: (context, url) => const Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/loadingImage.png'),
                                  ),
                                  imageUrl: widget.image_path,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Flexible(
                                child: Text(
                                  '${widget.name}',
                                  // overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Flexible(
                                child: Text(
                                  '${widget.reps}',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: pink1,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      const Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/loadingImage.png'),
                                  ),
                                  placeholder: (context, url) => const Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/loadingImage.png'),
                                  ),
                                  imageUrl: widget.image_path,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${widget.name}',
                                  // overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${widget.inst}',
                                // overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          )),
              ),
            ),
          )
        : Container(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    '${widget.name}',
                    // overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

class tags extends StatelessWidget {
  String name;
  tags(this.name);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: 20.0,
          maxWidth: 100.0,
          minHeight: 20.0,
          minWidth: 30.0,
        ),
        decoration: BoxDecoration(
            color: Color(0xEC9D0649),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 2, bottom: 2, right: 8),
          child: Text(
            '$name',
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }
}