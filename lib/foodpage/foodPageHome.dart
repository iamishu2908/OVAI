import 'dart:convert';
import 'dart:ui';
import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pcod/HomePage.dart';
import 'package:pcod/RegisterPage.dart';
import 'package:pcod/foodpage/Category%20Gallery.dart';
import 'package:pcod/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bulleted_list/bulleted_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'FoodPage.dart';

int foodpagecontroller = 0;
List<ClassFood> snack_list = [];
List<ClassFood> breakfast_list = [];
List<ClassFood> lunch_list = [];
List<ClassFood> dinner_list = [];

int vegNonvegFilter = 0; // 0: all , 1: veg , 2: non veg
getRecipeAPI() async {
  snack_list = [];
  breakfast_list = [];
  lunch_list = [];
  dinner_list = [];

  var snacks_url = Uri.parse(
      'https://gist.githubusercontent.com/MaddyDev-glitch/0f401b0a97d5d4020b908438c1468460/raw/food_snacks.json');
  var breakfast_url = Uri.parse(
      'https://gist.githubusercontent.com/MaddyDev-glitch/3804c72757fb0472792f5db0812751e6/raw/food_breakfast.json');
  var lunch_url = Uri.parse(
      'https://gist.githubusercontent.com/MaddyDev-glitch/647745b368a4edc73eed59052011ec11/raw/food_lunch.json');
  var dinner_url = Uri.parse(
      'https://gist.githubusercontent.com/MaddyDev-glitch/741f0708c8842a55af2718a6e4d248f7/raw/food_dinner.json');
  var snacks_response = await http.get(snacks_url);
  var breakfast_response = await http.get(breakfast_url);
  var lunch_response = await http.get(lunch_url);
  var dinner_response = await http.get(dinner_url);

  print('Response status: ${breakfast_response.statusCode}');
  print('Response body: ${breakfast_response.body}');

  final List<dynamic> snacks_data = await json.decode(snacks_response.body);
  if (snacks_response.statusCode == 200) {
    for (int i = 0; i < snacks_data.length; i++) {
      snack_list.add(ClassFood(
        snacks_data[i]['name'],
        snacks_data[i]['image_path'],
        snacks_data[i]['itemsreq'],
        snacks_data[i]['method'],
        snacks_data[i]['cals'],
        snacks_data[i]['time'],
        snacks_data[i]['isveg'],
      ));
    }
  }
  final List<dynamic> breakfast_data =
      await json.decode(breakfast_response.body);

  if (breakfast_response.statusCode == 200) {
    for (int i = 0; i < breakfast_data.length; i++) {
      breakfast_list.add(ClassFood(
        breakfast_data[i]['name'],
        breakfast_data[i]['image_path'],
        breakfast_data[i]['itemsreq'],
        breakfast_data[i]['method'],
        breakfast_data[i]['cals'],
        breakfast_data[i]['time'],
        breakfast_data[i]['isveg'],
      ));
    }
  }
  final List<dynamic> lunch_data = await json.decode(lunch_response.body);

  if (lunch_response.statusCode == 200) {
    for (int i = 0; i < lunch_data.length; i++) {
      lunch_list.add(ClassFood(
        lunch_data[i]['name'],
        lunch_data[i]['image_path'],
        lunch_data[i]['itemsreq'],
        lunch_data[i]['method'],
        lunch_data[i]['cals'],
        lunch_data[i]['time'],
        lunch_data[i]['isveg'],
      ));
    }
  }
  final List<dynamic> dinner_data = await json.decode(dinner_response.body);

  if (dinner_response.statusCode == 200) {
    for (int i = 0; i < dinner_data.length; i++) {
      dinner_list.add(ClassFood(
          dinner_data[i]['name'],
          dinner_data[i]['image_path'],
          dinner_data[i]['itemsreq'],
          dinner_data[i]['method'],
          dinner_data[i]['cals'],
          dinner_data[i]['time'],
          dinner_data[i]['isveg']));
    }
  }
}

class ClassFood {
  String name, imagepath, cals, time;
  List<dynamic> itemsreq, method;
  String isveg;
  ClassFood(this.name, this.imagepath, this.itemsreq, this.method, this.cals,
      this.time, this.isveg);
}

class foodPage1 extends StatefulWidget {
  const foodPage1({Key? key}) : super(key: key);
  @override
  State<foodPage1> createState() => _foodPage1State();
}

class _foodPage1State extends State<foodPage1> {
  void initState() {
    getRecipeAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (foodpagecontroller == 0) //Homepage
        ? ListView(
            key: ValueKey<int>(1),
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // height: 50,
                        width: SizeConfig.screenWidth - 50,
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                'foodPageHome_title'.tr().toString(),
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.02),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(1, 2), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                constraints: BoxConstraints(
                  maxHeight: 300,
                  maxWidth: SizeConfig.screenWidth,
                  minHeight: 100.0,
                  minWidth: 100.0,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'foodPageHome_note'.tr().toString(),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'foodPageHome_avoid'.tr().toString(),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        color: Colors.red.shade300,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              child: Image(
                                image: AssetImage('assets/images/nodairy.jpg'),
                              ),
                            ),
                            Text(
                              'foodPageHome_avoid1'.tr().toString(),
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              child: Image(
                                image: AssetImage('assets/images/nosugar.jpg'),
                              ),
                            ),
                            Text(
                              'foodPageHome_avoid2'.tr().toString(),
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              child: Image(
                                image: AssetImage('assets/images/nofat.jpg'),
                              ),
                            ),
                            Text(
                              'foodPageHome_avoid3'.tr().toString(),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'foodPageHome_inc'.tr().toString(),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        color: Colors.green.shade300,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              child: Image(
                                image: AssetImage('assets/images/nondiary.jpg'),
                              ),
                            ),
                            Text(
                              'foodPageHome_inc1'.tr().toString(),
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              child: Image(
                                image: AssetImage('assets/images/fruits.jpg'),
                              ),
                            ),
                            Text(
                              'foodPageHome_inc2'.tr().toString(),
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              child: Image(
                                image:
                                    AssetImage('assets/images/leafygreen.jpg'),
                              ),
                            ),
                            Text(
                              'foodPageHome_inc3'.tr().toString(),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Text(
                'foodPageHome_categories'.tr().toString(),
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Container(
                height: 400,
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            childAspectRatio: 1 / 1,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0),
                    itemCount: 4,
                    itemBuilder: (BuildContext ctx, index) {
                      return TextButton(
                          onPressed: () {
                            // String t = "";
                            // if (index == 0)
                            //   t = "Snacks";
                            // else if (index == 1)
                            //   t = "Breakfast";
                            // else if (index == 2)
                            //   t = "Lunch";
                            // else
                            //   t = "Dinner";
                            foodpagecontroller = index + 1;
                            setState(() {});
                          },
                          child: foodCategory(food_category_list[index]));
                    }),
              ),
              Container(
                height: 250,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.02),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(1, 2), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              'foodPageHome_tips'.tr().toString(),
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Text(
                          'foodPageHome_tips1'.tr().toString(),
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'foodPageHome_tips2'.tr().toString(),
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'foodPageHome_tips3'.tr().toString(),
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          )
        : (foodpagecontroller == 1) //Snackspage
            ? ListView(
                key: ValueKey<int>(2),
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.,
                        children: [
                          Container(
                            // color: Colors.amber,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size(50, 50),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    alignment: Alignment.center),
                                onPressed: () {
                                  foodpagecontroller = 0;
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                )),
                          ),
                          Container(
                            // height: 50,
                            width: SizeConfig.screenWidth - 150,
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    'foodPageHome_snacks'.tr().toString(),
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Text(
                      'foodPageHome_featured'.tr().toString(),
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    height: 300,
                    width: SizeConfig.screenWidth - 50,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snack_list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return FoodCard(
                              snack_list[index].name,
                              snack_list[index].imagepath,
                              " ",
                              snack_list[index].cals,
                              snack_list[index].time);
                        }),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'foodPageHome_recipies'.tr().toString(),
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'foodPageHome_filter1'.tr().toString(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF7B6F72),
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    //constraints: BoxConstraints(minHeight: 40, maxHeight: 70),
                    // width: 150,
                    child: AnimatedButtonBar(
                      foregroundColor: pink1,
                      padding: EdgeInsets.all(5.0),
                      backgroundColor: Colors.white,
                      radius: 8.0,
                      invertedSelection: true,
                      children: [
                        ButtonBarEntry(
                            onTap: () {
                              vegNonvegFilter = 0;
                              setState(() {});
                            },
                            child: Wraptext(
                              text: Text(
                                //'All',
                                'foodPageHome_filter2'.tr().toString(),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            )),
                        ButtonBarEntry(
                            onTap: () {
                              vegNonvegFilter = 1;
                              setState(() {});
                            },
                            child: Wraptext(
                              text: Text(
                                //'Only Veg',
                                'foodPageHome_filter3'.tr().toString(),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            )),
                        ButtonBarEntry(
                            onTap: () {
                              vegNonvegFilter = 2;

                              setState(() {});
                            },
                            child: Wraptext(
                              text: Text(
                                //'Only Non Veg',
                                'foodPageHome_filter4'.tr().toString(),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    // height: 300,
                    // width: SizeConfig.screenWidth - 50,
                    // constraints: BoxConstraints(
                    //   maxHeight: SizeConfig.screenHeight-180,
                    //   maxWidth: SizeConfig.screenWidth,
                    //   minHeight: 100.0,
                    //   minWidth: 100.0,
                    // ),
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snack_list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return (vegNonvegFilter == 0)
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: RecipeBox(
                                      index,
                                      snack_list[index].name,
                                      snack_list[index].imagepath,
                                      snack_list[index].itemsreq,
                                      snack_list[index].method,
                                      snack_list[index].cals,
                                      snack_list[index].time,
                                      snack_list[index].isveg),
                                )
                              : (vegNonvegFilter == 1 &&
                                      snack_list[index].isveg == '1')
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: RecipeBox(
                                          index,
                                          snack_list[index].name,
                                          snack_list[index].imagepath,
                                          snack_list[index].itemsreq,
                                          snack_list[index].method,
                                          snack_list[index].cals,
                                          snack_list[index].time,
                                          snack_list[index].isveg),
                                    )
                                  : (vegNonvegFilter == 2 &&
                                          snack_list[index].isveg == '0')
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: RecipeBox(
                                              index,
                                              snack_list[index].name,
                                              snack_list[index].imagepath,
                                              snack_list[index].itemsreq,
                                              snack_list[index].method,
                                              snack_list[index].cals,
                                              snack_list[index].time,
                                              snack_list[index].isveg),
                                        )
                                      : SizedBox(
                                          height: 0,
                                        );
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    ///todo: smiley emoji not carrying to json - to be fixed
                    //'That\'s all folks ! 😉  \n More Recipies coming soon . . .',
                    'foodPageHome_more_recipes'.tr().toString(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              )
            : (foodpagecontroller == 2) //Breakfast
                ? ListView(
                    key: ValueKey<int>(1),
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.,
                            children: [
                              Container(
                                // color: Colors.amber,
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size(50, 50),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        alignment: Alignment.center),
                                    onPressed: () {
                                      foodpagecontroller = 0;
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.black,
                                    )),
                              ),
                              Container(
                                // height: 50,
                                width: SizeConfig.screenWidth - 150,
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        'foodPageHome_breakfast'.tr().toString(),
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Text(
                          'foodPageHome_featured'.tr().toString(),
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        height: 300,
                        width: SizeConfig.screenWidth - 50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: breakfast_list.length,
                            itemBuilder: (BuildContext context, int index) {
                              return FoodCard(
                                  breakfast_list[index].name,
                                  breakfast_list[index].imagepath,
                                  " ",
                                  breakfast_list[index].cals,
                                  breakfast_list[index].time);
                            }),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'foodPageHome_recipies'.tr().toString(),
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'foodPageHome_filter1'.tr().toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF7B6F72),
                          fontSize: 14,
                        ),
                      ),
                      Container(
                        // width: 150,
                        child: AnimatedButtonBar(
                          foregroundColor: pink1,
                          backgroundColor: Colors.white,
                          radius: 8.0,
                          padding: const EdgeInsets.all(5.0),
                          invertedSelection: true,
                          children: [
                            ButtonBarEntry(
                                onTap: () {
                                  vegNonvegFilter = 0;
                                  setState(() {});
                                },
                                child: Wraptext(
                                  text: Text(
                                    'foodPageHome_filter2'.tr().toString(),
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                )),
                            ButtonBarEntry(
                                onTap: () {
                                  vegNonvegFilter = 1;
                                  setState(() {});
                                },
                                child: Wraptext(
                                  text: Text(
                                    'foodPageHome_filter3'.tr().toString(),
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                )),
                            ButtonBarEntry(
                                onTap: () {
                                  vegNonvegFilter = 2;

                                  setState(() {});
                                },
                                child: Wraptext(
                                  text: Text(
                                    'foodPageHome_filter4'.tr().toString(),
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        // height: 300,
                        // width: SizeConfig.screenWidth - 50,
                        // constraints: BoxConstraints(
                        //   maxHeight: SizeConfig.screenHeight-180,
                        //   maxWidth: SizeConfig.screenWidth,
                        //   minHeight: 100.0,
                        //   minWidth: 100.0,
                        // ),
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: breakfast_list.length,
                            itemBuilder: (BuildContext context, int index) {
                              return (vegNonvegFilter == 0)
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: RecipeBox(
                                          index,
                                          breakfast_list[index].name,
                                          breakfast_list[index].imagepath,
                                          breakfast_list[index].itemsreq,
                                          breakfast_list[index].method,
                                          breakfast_list[index].cals,
                                          breakfast_list[index].time,
                                          breakfast_list[index].isveg),
                                    )
                                  : (vegNonvegFilter == 1 &&
                                          breakfast_list[index].isveg == '1')
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: RecipeBox(
                                              index,
                                              breakfast_list[index].name,
                                              breakfast_list[index].imagepath,
                                              breakfast_list[index].itemsreq,
                                              breakfast_list[index].method,
                                              breakfast_list[index].cals,
                                              breakfast_list[index].time,
                                              breakfast_list[index].isveg),
                                        )
                                      : (vegNonvegFilter == 2 &&
                                              breakfast_list[index].isveg ==
                                                  '0')
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: RecipeBox(
                                                  index,
                                                  breakfast_list[index].name,
                                                  breakfast_list[index]
                                                      .imagepath,
                                                  breakfast_list[index]
                                                      .itemsreq,
                                                  breakfast_list[index].method,
                                                  breakfast_list[index].cals,
                                                  breakfast_list[index].time,
                                                  breakfast_list[index].isveg),
                                            )
                                          : SizedBox(
                                              height: 0,
                                            );
                            }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'foodPageHome_more_recipes'.tr().toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  )
                : (foodpagecontroller == 3) //Lunchpage
                    ? ListView(
                        key: ValueKey<int>(1),
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.,
                                children: [
                                  Container(
                                    // color: Colors.amber,
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            minimumSize: Size(50, 50),
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                            alignment: Alignment.center),
                                        onPressed: () {
                                          foodpagecontroller = 0;
                                          setState(() {});
                                        },
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.black,
                                        )),
                                  ),
                                  Container(
                                    // height: 50,
                                    width: SizeConfig.screenWidth - 150,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'foodPageHome_lunch'.tr().toString(),
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 24,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Text(
                              'foodPageHome_featured'.tr().toString(),
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Container(
                            height: 300,
                            width: SizeConfig.screenWidth - 50,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: lunch_list.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return FoodCard(
                                      lunch_list[index].name,
                                      lunch_list[index].imagepath,
                                      " ",
                                      lunch_list[index].cals,
                                      lunch_list[index].time);
                                }),
                          ),
                          SizedBox(height: 15),
                          Text(
                            'foodPageHome_recipies'.tr().toString(),
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'foodPageHome_filter1'.tr().toString(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF7B6F72),
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            // width: 150,
                            child: AnimatedButtonBar(
                              foregroundColor: pink1,
                              backgroundColor: Colors.white,
                              radius: 8.0,
                              padding: const EdgeInsets.all(5.0),
                              invertedSelection: true,
                              children: [
                                ButtonBarEntry(
                                    onTap: () {
                                      vegNonvegFilter = 0;
                                      setState(() {});
                                    },
                                    child: Wraptext(
                                      text: Text(
                                        'foodPageHome_filter2'.tr().toString(),
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    )),
                                ButtonBarEntry(
                                    onTap: () {
                                      vegNonvegFilter = 1;
                                      setState(() {});
                                    },
                                    child: Wraptext(
                                      text: Text(
                                        'foodPageHome_filter3'.tr().toString(),
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    )),
                                ButtonBarEntry(
                                    onTap: () {
                                      vegNonvegFilter = 2;

                                      setState(() {});
                                    },
                                    child: Wraptext(
                                      text: Text(
                                        'foodPageHome_filter4'.tr().toString(),
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            // height: 300,
                            // width: SizeConfig.screenWidth - 50,
                            // constraints: BoxConstraints(
                            //   maxHeight: SizeConfig.screenHeight-180,
                            //   maxWidth: SizeConfig.screenWidth,
                            //   minHeight: 100.0,
                            //   minWidth: 100.0,
                            // ),
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: lunch_list.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return (vegNonvegFilter == 0)
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: RecipeBox(
                                              index,
                                              lunch_list[index].name,
                                              lunch_list[index].imagepath,
                                              lunch_list[index].itemsreq,
                                              lunch_list[index].method,
                                              lunch_list[index].cals,
                                              lunch_list[index].time,
                                              lunch_list[index].isveg),
                                        )
                                      : (vegNonvegFilter == 1 &&
                                              lunch_list[index].isveg == '1')
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: RecipeBox(
                                                  index,
                                                  lunch_list[index].name,
                                                  lunch_list[index].imagepath,
                                                  lunch_list[index].itemsreq,
                                                  lunch_list[index].method,
                                                  lunch_list[index].cals,
                                                  lunch_list[index].time,
                                                  lunch_list[index].isveg),
                                            )
                                          : (vegNonvegFilter == 2 &&
                                                  lunch_list[index].isveg ==
                                                      '0')
                                              ? Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  child: RecipeBox(
                                                      index,
                                                      lunch_list[index].name,
                                                      lunch_list[index]
                                                          .imagepath,
                                                      lunch_list[index]
                                                          .itemsreq,
                                                      lunch_list[index].method,
                                                      lunch_list[index].cals,
                                                      lunch_list[index].time,
                                                      lunch_list[index].isveg),
                                                )
                                              : SizedBox(
                                                  height: 0,
                                                );
                                }),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'foodPageHome_more_recipes'.tr().toString(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      )
                    : (foodpagecontroller == 4) //Dinnerpage
                        ? ListView(
                            key: ValueKey<int>(1),
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.,
                                    children: [
                                      Container(
                                        // color: Colors.amber,
                                        child: TextButton(
                                            style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                minimumSize: Size(50, 50),
                                                tapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                alignment: Alignment.center),
                                            onPressed: () {
                                              foodpagecontroller = 0;
                                              setState(() {});
                                            },
                                            child: Icon(
                                              Icons.arrow_back_ios,
                                              color: Colors.black,
                                            )),
                                      ),
                                      Container(
                                        // height: 50,
                                        width: SizeConfig.screenWidth - 150,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                'foodPageHome_dinner'.tr().toString(),
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 24,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                child: Text(
                                  'foodPageHome_featured'.tr().toString(),
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Container(
                                height: 300,
                                width: SizeConfig.screenWidth - 50,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: dinner_list.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return FoodCard(
                                          dinner_list[index].name,
                                          dinner_list[index].imagepath,
                                          " ",
                                          dinner_list[index].cals,
                                          dinner_list[index].time);
                                    }),
                              ),
                              SizedBox(height: 15),
                              Text(
                                'foodPageHome_recipies'.tr().toString(),
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'foodPageHome_filter1'.tr().toString(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF7B6F72),
                                  fontSize: 14,
                                ),
                              ),
                              Container(
                                // width: 150,
                                child: AnimatedButtonBar(
                                  foregroundColor: pink1,
                                  backgroundColor: Colors.white,
                                  radius: 8.0,
                                  padding: const EdgeInsets.all(5.0),
                                  invertedSelection: true,
                                  children: [
                                    ButtonBarEntry(
                                        onTap: () {
                                          vegNonvegFilter = 0;
                                          setState(() {});
                                        },
                                        child: Wraptext(
                                          text: Text(
                                            'foodPageHome_filter2'.tr().toString(),
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                          ),
                                        )),
                                    ButtonBarEntry(
                                        onTap: () {
                                          vegNonvegFilter = 1;
                                          setState(() {});
                                        },
                                        child: Wraptext(
                                          text: Text(
                                            'foodPageHome_filter3'.tr().toString(),
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                          ),
                                        )),
                                    ButtonBarEntry(
                                        onTap: () {
                                          vegNonvegFilter = 2;

                                          setState(() {});
                                        },
                                        child: Wraptext(
                                          text: Text(
                                            'foodPageHome_filter4'.tr().toString(),
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                // height: 300,
                                // width: SizeConfig.screenWidth - 50,
                                // constraints: BoxConstraints(
                                //   maxHeight: SizeConfig.screenHeight-180,
                                //   maxWidth: SizeConfig.screenWidth,
                                //   minHeight: 100.0,
                                //   minWidth: 100.0,
                                // ),
                                child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: dinner_list.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return (vegNonvegFilter == 0)
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: RecipeBox(
                                                  index,
                                                  dinner_list[index].name,
                                                  dinner_list[index].imagepath,
                                                  dinner_list[index].itemsreq,
                                                  dinner_list[index].method,
                                                  dinner_list[index].cals,
                                                  dinner_list[index].time,
                                                  dinner_list[index].isveg),
                                            )
                                          : (vegNonvegFilter == 1 &&
                                                  dinner_list[index].isveg ==
                                                      '1')
                                              ? Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  child: RecipeBox(
                                                      index,
                                                      dinner_list[index].name,
                                                      dinner_list[index]
                                                          .imagepath,
                                                      dinner_list[index]
                                                          .itemsreq,
                                                      dinner_list[index].method,
                                                      dinner_list[index].cals,
                                                      dinner_list[index].time,
                                                      dinner_list[index].isveg),
                                                )
                                              : (vegNonvegFilter == 0 &&
                                                      dinner_list[index]
                                                              .isveg ==
                                                          '0')
                                                  ? Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 5),
                                                      child: RecipeBox(
                                                          index,
                                                          dinner_list[index]
                                                              .name,
                                                          dinner_list[index]
                                                              .imagepath,
                                                          dinner_list[index]
                                                              .itemsreq,
                                                          dinner_list[index]
                                                              .method,
                                                          dinner_list[index]
                                                              .cals,
                                                          dinner_list[index]
                                                              .time,
                                                          dinner_list[index]
                                                              .isveg),
                                                    )
                                                  : SizedBox(
                                                      height: 0,
                                                    );
                                    }),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'foodPageHome_more_recipes'.tr().toString(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          )
                        : ListView(
                            key: ValueKey<int>(1),
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.,
                                    children: [
                                      Container(
                                        // color: Colors.amber,
                                        child: TextButton(
                                            style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                minimumSize: Size(50, 50),
                                                tapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                alignment: Alignment.center),
                                            onPressed: () {
                                              foodpagecontroller = 0;
                                              setState(() {});
                                            },
                                            child: Icon(
                                              Icons.arrow_back_ios,
                                              color: Colors.black,
                                            )),
                                      ),
                                      Container(
                                        // height: 50,
                                        width: SizeConfig.screenWidth - 150,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                'DUMMY',
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 24,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                child: Text(
                                  'foodPageHome_featured'.tr().toString(),
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Container(
                                height: 300,
                                width: SizeConfig.screenWidth - 50,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 50,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return FoodCard(
                                          snack_list[index].name,
                                          snack_list[index].imagepath,
                                          " ",
                                          snack_list[index].cals,
                                          snack_list[index].time);
                                    }),
                              ),
                              SizedBox(height: 15),
                              Text(
                                'Categories',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              Container(
                                height: 400,
                                child: GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 300,
                                            childAspectRatio: 1 / 1,
                                            crossAxisSpacing: 0,
                                            mainAxisSpacing: 0),
                                    itemCount: 4,
                                    itemBuilder: (BuildContext ctx, index) {
                                      return TextButton(
                                          onPressed: () {},
                                          child: foodCategory(
                                              food_category_list[index]));
                                    }),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          );
  }
}

class RecipeBox extends StatefulWidget {
  int index;
  String image_path, name = "name", cals = "0Cal", time = "123mins";
  List<dynamic> itemsreq = [], method = [];
  String isveg;

  RecipeBox(this.index, this.name, this.image_path, this.itemsreq, this.method,
      this.cals, this.time, this.isveg);

  @override
  State<RecipeBox> createState() => _RecipeBox();
}

class _RecipeBox extends State<RecipeBox> {
  bool expand = false;
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
                ? Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: CachedNetworkImage(
                            height: 60,
                            errorWidget: (context, url, error) => const Image(
                              image:
                                  AssetImage('assets/images/loadingImage.png'),
                            ),
                            placeholder: (context, url) => const Image(
                              image:
                                  AssetImage('assets/images/loadingImage.png'),
                            ),
                            imageUrl: widget.image_path,
                          ),

                          // Image(
                          //   height: 60,
                          //   image: NetworkImage(widget.image_path),
                          // ),
                        ),
                        SizedBox(
                          width: 10,
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
                          width: 5,
                        ),
                        (widget.isveg == "1")
                            ? Container(
                                height: 25,
                                width: 25,
                                child: Image(
                                  image: AssetImage('assets/images/veg.png'),
                                ),
                              )
                            : Container(
                                height: 25,
                                width: 25,
                                child: Image(
                                  image:
                                      AssetImage('assets/images/non-veg.png'),
                                ),
                              ),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${widget.cals}',
                                textAlign: TextAlign.end,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '~ ${widget.time}',
                                textAlign: TextAlign.end,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          // color: Colors.amber,
                          image: DecorationImage(
                              image: NetworkImage(widget.image_path),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          widget.name,
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      (widget.isveg == "1")
                                          ? Container(
                                              height: 25,
                                              width: 25,
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/images/veg.png'),
                                              ),
                                            )
                                          : Container(
                                              height: 25,
                                              width: 25,
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/images/non-veg.png'),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${widget.cals}',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        'foodPageHome_approx'.tr().toString()+ widget.time,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              height: 1,
                              color: pink1,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "foodPageHome_items".tr().toString(),
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            Column(
                              children: [
                                BulletedList(
                                  bulletColor: Colors.black,
                                  listItems: widget.itemsreq,
                                  listOrder: ListOrder.ordered,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: 13,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "foodPageHome_method".tr().toString(),
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            Column(
                              children: [
                                BulletedList(
                                  bulletColor: Colors.black,
                                  listItems: widget.method,
                                  listOrder: ListOrder.ordered,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: 13,
                                  ),
                                )
                              ],
                            ),
                            Center(
                              child: Text(
                                "foodPageHome_enjoy".tr().toString(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                "foodPageHome_minimize".tr().toString(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w200,
                                  color: Colors.black,
                                  fontSize: 11,
                                ),
                              ),
                            ),
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

class Wraptext extends StatelessWidget {
  Widget text;
  Wraptext({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      //constraints: BoxConstraints(minWidth: 10, maxWidth: 700),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Flexible(child: text)],
      ),
    );
  }
}
