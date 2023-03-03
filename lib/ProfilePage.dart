import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'mobile.dart';
import 'dart:ui';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:pcod/PredictPage.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'mobile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pcod/HomePage.dart';
import 'package:pcod/RegisterPage.dart';
import 'package:pcod/main.dart';
import 'package:google_fonts/google_fonts.dart';

String currentDate = DateFormat.yMMMd().format(DateTime.now());

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView(
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
                      child: Text(
                        'Profile',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    // Container(
                    //   alignment: Alignment.topRight,
                    //   child: Image(
                    //     alignment: Alignment.topRight,
                    //     image: AssetImage('assets/images/Chat.png'),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
             
            SizedBox(height: 15),
            Container(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    height: 65,
                    width: SizeConfig.screenWidth * 0.25,
                    decoration: new BoxDecoration(
                      color: Color(0xFFF7F8F8),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(14.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$height cm',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFEF5DA8),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Height',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        )
                      ],
                    )),
                Container(
                    height: 65,
                    width: SizeConfig.screenWidth * 0.25,
                    decoration: new BoxDecoration(
                      color: Color(0xFFF7F8F8),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(14.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$weight Kg',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFEF5DA8),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Weight',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        )
                      ],
                    )),
                Container(
                    height: 65,
                    width: SizeConfig.screenWidth * 0.25,
                    decoration: new BoxDecoration(
                      color: Color(0xFFF7F8F8),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(14.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${(DateTime.now().difference(dob_dt!).inDays/365).round()} yo',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFEF5DA8),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Age',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        )
                      ],
                    )),
              ],
            )),
            SizedBox(height: 15),
            Container(
                alignment: Alignment.center,
                height: 60,
                width: SizeConfig.screenWidth * 0.95,
                decoration: new BoxDecoration(
                  color: Color(0xFFF7F8F8),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Date of Birth',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: pink1,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      '${dob_dt.toString().substring(0, 10)}',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    )
                  ],
                )),
            SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  height: SizeConfig.screenHeight * 0.15,
                  width: SizeConfig.screenWidth * 0.95,
                  decoration: new BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(2, 2),
                        ),
                      ],
                      color: Color(0xFFF7F8F8),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  child: Text(
                    'Risk of having PCOD',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: pink1,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.25),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: SizeConfig.screenWidth * 0.85,
                child: ElevatedButton(
                  child: Text('Export information to pdf'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFEF5DA8),
                    onPrimary: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(99))),
                  ),
                  onPressed: _createPDF,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();

    final page = document.pages.add();

    document.pageSettings.orientation = PdfPageOrientation.portrait;
    document.pageSettings.margins.all = 50;
    PdfBrush solidBrush = PdfSolidBrush(PdfColor(255, 255, 255));
    PdfBrush pinkbrush = PdfSolidBrush(PdfColor(239, 93, 168));
    PdfGraphics graphics = page.graphics;
    Rect bounds = Rect.fromLTWH(50, 30, graphics.clientSize.width, 70);
    graphics.drawRectangle(brush: solidBrush, bounds: bounds);
    PdfFont subHeadingFont =
        PdfStandardFont(PdfFontFamily.helvetica, 18, style: PdfFontStyle.bold);
    page.graphics.drawString(
        'OV-AI',
        PdfStandardFont(
          PdfFontFamily.helvetica,
          20,
        ),
        bounds: const Rect.fromLTWH(230, 0, 0, 0),
        brush: pinkbrush);
    PdfTextElement element = PdfTextElement(text: '', font: subHeadingFont);
    element.brush = PdfBrushes.white;
    PdfLayoutResult result =
        element.draw(page: page, bounds: Rect.fromLTWH(40, 70, 0, 0))!;
    page.graphics.drawString(
      'PCOD Diagnostic Test Report',
      PdfStandardFont(
        PdfFontFamily.helvetica,
        32,
      ),
      bounds: bounds,
    );
    graphics.drawLine(
        PdfPen(PdfColor(239, 93, 168), width: 2),
        Offset(0, result.bounds.bottom + 3),
        Offset(graphics.clientSize.width, result.bounds.bottom + 3));
    element = PdfTextElement(
        text: '$currentDate',
        font: PdfStandardFont(
          PdfFontFamily.helvetica,
          12,
        ));
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page,
        bounds: Rect.fromLTWH(300, result.bounds.bottom + 5, 0, 0))!;
    element = PdfTextElement(
        text: '$name',
        font: PdfStandardFont(
          PdfFontFamily.helvetica,
          12,
        ));
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page,
        bounds: Rect.fromLTWH(10, result.bounds.bottom - 13, 0, 0))!;
    element = PdfTextElement(
        text: 'Blood Group : $bloodgrp',
        font: PdfStandardFont(
          PdfFontFamily.helvetica,
          12,
        ));
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom, 0, 0))!;
    element = PdfTextElement(
        text: 'Gender : $gender',
        font: PdfStandardFont(
          PdfFontFamily.helvetica,
          12,
        ));
    result = element.draw(
        page: page,
        bounds: Rect.fromLTWH(300, result.bounds.bottom - 16, 0, 0))!;

    element = PdfTextElement(
        text: 'Date of Birth: $dob_dt',
        font: PdfStandardFont(
          PdfFontFamily.helvetica,
          12,
        ));
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 4, 0, 0))!;
    element = PdfTextElement(
      text: 'Height : $height cms',
      font: PdfStandardFont(
        PdfFontFamily.helvetica,
        12,
      ),
    );
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 4, 0, 0))!;
    element = PdfTextElement(
        text: 'Weight: $weight kgs',
        font: PdfStandardFont(
          PdfFontFamily.helvetica,
          12,
        ));
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 4, 0, 0))!;
    element = PdfTextElement(
        text: 'Age : 22 years',
        font: PdfStandardFont(
          PdfFontFamily.helvetica,
          12,
        ));
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 4, 0, 0))!;
    element = PdfTextElement(
        text:
            '*This report is generated plainly based on the insights obtained from the application*',
        font: PdfStandardFont(PdfFontFamily.courier, 12,
            style: PdfFontStyle.bold));
    element.brush = pinkbrush;
    result = element.draw(page: page, bounds: Rect.fromLTWH(10, 730, 0, 0))!;
    element = PdfTextElement(
        text: 'PCOD PREDICTION :',
        font: PdfStandardFont(PdfFontFamily.helvetica, 22,
            style: PdfFontStyle.bold));
    element.brush = pinkbrush;
    result = element.draw(page: page, bounds: Rect.fromLTWH(10, 700, 0, 0))!;

    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
        cellPadding: PdfPaddings(left: 2, right: 2, top: 2, bottom: 2));

    grid.columns.add(count: 2);
    grid.headers.add(1);

    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'parameters';
    header.cells[1].value = 'status';

    PdfGridRow row = grid.rows.add();
    row.cells[0].value = 'Cycle R/I';
    row.cells[1].value = '';

    row = grid.rows.add();
    row.cells[0].value = 'Cycle Length';
    row.cells[1].value = '';

    row = grid.rows.add();
    row.cells[0].value = 'Pregnancy Status';
    row.cells[1].value = '';

    row = grid.rows.add();
    row.cells[0].value = 'Marital Status';
    row.cells[1].value = '';

    row = grid.rows.add();
    row.cells[0].value = 'No of Abortions';
    row.cells[1].value = '';

    row = grid.rows.add();
    row.cells[0].value = 'FastFood Consumption';
    row.cells[1].value = '';

    row = grid.rows.add();
    row.cells[0].value = 'Exercise';
    row.cells[1].value = '';

    row = grid.rows.add();
    row.cells[0].value = 'Weight Gain';
    row.cells[1].value = '';

    row = grid.rows.add();
    row.cells[0].value = 'HairFall';
    row.cells[1].value = '';

    row = grid.rows.add();
    row.cells[0].value = 'Body HairGrowth';
    row.cells[1].value = '';

    row = grid.rows.add();
    row.cells[0].value = 'Skin darkening';
    row.cells[1].value = '';

    row = grid.rows.add();
    row.cells[0].value = 'Acne';
    row.cells[1].value = '';

    grid.draw(page: page, bounds: const Rect.fromLTWH(0, 275, 0, 0));
    showTopSnackBar(
      context,
      Container(
        height: 50,
        child: CustomSnackBar.success(
          iconRotationAngle: 0,
          iconPositionTop: -21,
          iconPositionLeft: 40.0,
          icon: Icon(Icons.info),
          backgroundColor: pink1,
          message: "PDF successfully saved!",
        ),
      ),
    );
    List<int> bytes = await document.save();
    document.dispose();
    saveAndLaunchFile(bytes, 'Ovai_report_$currentDate');
  }
}
