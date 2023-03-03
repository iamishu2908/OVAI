import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcod/main.dart';
import 'package:art_sweetalert/art_sweetalert.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

Color lightpink = Color(0xFFFCDDEC);
Widget workoutpage() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 19),
    child: ScrollConfiguration(
      behavior: MyBehavior(),
      child: ListView(children: [
        Container(
            alignment: Alignment.center,
            padding:
                const EdgeInsets.only(top: 26, left: 10, right: 10, bottom: 10),
            child: Text(
              'Which level of workout would you like to do?',
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 18,
              ),
            )),
        SizedBox(
          height: 8,
        ),
        WorkoutCard("Beginner", "5 Exercies | 15 mins",
            "assets/images/beginner_image.png"),
        SizedBox(
          height: 20,
        ),
        WorkoutCard("Intermediate", "12 Exercises | 40mins",
            "assets/images/intermediate_image.png"),
        SizedBox(
          height: 20,
        ),
        WorkoutCard("Advanced", "14 Exercises | 20mins",
            "assets/images/advanced_image.png"),
        SizedBox(
          height: 17,
        ),
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  'Yoga Asanas to balance hormones',
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
                  'Sit on a yoga mat, breathe in slowly and deeply through your nose, allowing your chest and belly to expand as air fills your lungs. Then exhale slowly through your nose. Repeat',
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
        Container(
          height: 5 * 180,
          child: GridView.count(
            physics: new NeverScrollableScrollPhysics(),
            primary: true,
            padding: const EdgeInsets.all(0),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              YogaBox("assets/images/y1.png"),
              YogaBox("assets/images/1_2 1.png"),
              YogaBox("assets/images/1_4 2.png"),
              YogaBox("assets/images/3_3 1.png"),
              YogaBox("assets/images/1_1 1.png"),
              YogaBox("assets/images/2_1 1.png"),
              YogaBox("assets/images/2_3 1.png"),
              YogaBox("assets/images/3_1 1.png"),
              YogaBox("assets/images/2_4 1.png"),
              YogaBox("assets/images/1_3 1.png"),
            ],
          ),
        ),
      ]),
    ),
  );
}

class YogaBox extends StatelessWidget {
  String image_path;
  YogaBox(this.image_path);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: lightpink,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: TextButton(
              onPressed: () {
                ArtSweetAlert.show(
                    context: context,
                    artDialogArgs: ArtDialogArgs(
                        getTitleSize: 25,
                        dialogDecoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.9),
                              Colors.white.withOpacity(0.95),
                            ],
                            begin: AlignmentDirectional.topStart,
                            end: AlignmentDirectional.bottomEnd,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        confirmButtonText: "",
                        confirmButtonColor: Colors.transparent,
                        title: "Yoga Asana 1",
                        text: "Modal with a custom image.",
                        customColumns: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Image(
                              image: AssetImage('$image_path'),
                            ),
                          )
                        ]));
              },
              child: Image(
                image: AssetImage('$image_path'),
              ),
            ),
          ),
          Container(
            child: Text('Name'),
          )
        ],
      ),
    );
  }
}

class WorkoutCard extends StatelessWidget {
  String diff_level, info, image_path;
  WorkoutCard(this.diff_level, this.info, this.image_path);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: SizeConfig.screenWidth * 0.8,
        height: 130,
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
                    TextButton(
                        onPressed: () {},
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
                        ))
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
