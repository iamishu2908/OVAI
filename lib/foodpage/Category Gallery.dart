import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pcod/HomePage.dart';
import 'package:pcod/RegisterPage.dart';
import 'package:pcod/foodpage/foodPageHome.dart';
import 'package:pcod/main.dart';
import 'package:google_fonts/google_fonts.dart';

import 'FoodPage.dart';

class FoodCategoryGallery extends StatefulWidget {
  String category;
  FoodCategoryGallery(this.category);
  @override
  State<FoodCategoryGallery> createState() => _FoodCategoryGalleryState();
}

class _FoodCategoryGalleryState extends State<FoodCategoryGallery> {
  @override
  Widget build(BuildContext context) {
    return ListView(
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
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                          '${widget.category}',
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
            'FfoodPageHome_featured'.tr().toString(),
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
                return FoodCard(snack_list[index].name,snack_list[index].imagepath," ",snack_list[index].cals,snack_list[index].time);
              }),
        ),
        SizedBox(height: 15),
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
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 1 / 1,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0),
              itemCount: 4,
              itemBuilder: (BuildContext ctx, index) {
                return TextButton(
                    onPressed: () {},
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
    );
  }
}
