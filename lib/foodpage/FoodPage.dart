import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pcod/HomePage.dart';
import 'package:pcod/RegisterPage.dart';
import 'package:pcod/exercise%20and%20yoga.dart';
import 'package:pcod/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'foodPageHome.dart';
import 'package:pcod/foodpage/foodPageHome.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ScrollConfiguration(behavior: MyBehavior(), child: foodPage1()
          // _foodPage1(),
          ),
    );
  }
}

class foodCategory extends StatelessWidget {
  String imagepath;
  foodCategory(this.imagepath);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      offset: Offset(1, 2), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(imagepath),
              )),
        ],
      ),
    );
  }
}

class FoodCard extends StatefulWidget {
  String imagepath, name, desc = "", cal = "", time = "";
  FoodCard(this.name, this.imagepath, this.desc, this.cal, this.time);
  @override
  State<FoodCard> createState() => _FoodCard();
}

class _FoodCard extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(1, 2), // changes position of shadow
            ),
          ],
        ),
        height: 300,
        width: 300,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: 300, width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                ),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Image(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/loadingImage.png'),
                  ),
                  placeholder: (context, url) => const Image(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/loadingImage.png'),
                  ),
                  imageUrl: widget.imagepath,
                ),

                // Image(
                //   height: 60,
                //   image: NetworkImage(widget.image_path),
                // ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.imagepath),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                widget.name,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: SizeConfig.screenWidth * 0.037,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "${widget.cal}",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "${widget.time}",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

List<String> food_category_list = [
  "assets/images/snacks.png",
  "assets/images/breakfast1.png",
  "assets/images/lunch1.png",
  "assets/images/dinner1.png"
];
