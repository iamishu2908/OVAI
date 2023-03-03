import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pcod/HomePage.dart';
import 'package:pcod/foodpage/FoodPage.dart';
import 'package:pcod/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

int faqpagecontroller = 0;
List<String> FAQ_category = [
  'faq_cat1'.tr().toString(),
  'faq_cat2'.tr().toString(),
  'faq_cat3'.tr().toString(),
  'faq_cat4'.tr().toString(),
  'faq_cat5'.tr().toString(),
];

List<ClassFaq> cat1_list = [];
List<ClassFaq> cat2_list = [];
List<ClassFaq> cat3_list = [];
List<ClassFaq> cat4_list = [];

getFaqAPI() async {
  cat1_list = [];
  cat2_list = [];
  cat3_list = [];
  cat4_list = [];
  var faq_url = Uri.parse(
      'https://gist.githubusercontent.com/MaddyDev-glitch/bc0855b0b75f69762de7b2824004debf/raw/faq_pcod.json');
  var faq_response = await http.get(faq_url);
  final List<dynamic> faq_data = await json.decode(faq_response.body);

  print('Response status: ${faq_response.statusCode}');
  print('Response body: ${faq_response.body}');

  if (faq_response.statusCode == 200) {
    for (int i = 0; i < faq_data.length; i++) {
      if (faq_data[i]['category'] == "1") {
        cat1_list.add(ClassFaq(
          faq_data[i]['category'],
          faq_data[i]['question'],
          faq_data[i]['answer'],
        ));
      } else if (faq_data[i]['category'] == "2") {
        cat2_list.add(ClassFaq(
          faq_data[i]['category'],
          faq_data[i]['question'],
          faq_data[i]['answer'],
        ));
      } else if (faq_data[i]['category'] == "3") {
        cat3_list.add(ClassFaq(
          faq_data[i]['category'],
          faq_data[i]['question'],
          faq_data[i]['answer'],
        ));
      } else if (faq_data[i]['category'] == "4") {
        cat4_list.add(ClassFaq(
          faq_data[i]['category'],
          faq_data[i]['question'],
          faq_data[i]['answer'],
        ));
      }
      print(cat1_list);
    }
  }
}

class FaqPage extends StatefulWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  void initState() {
    getFaqAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (faqpagecontroller == 0) //Homepage
        ? Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              child: ListView(children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 30, left: 5, right: 10, bottom: 10),
                  width: SizeConfig.screenWidth - 50,
                  child: Text(
                    'faq_faq'.tr().toString(),
                    //textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 5 * 190,
                  child: ListView.builder(
                      physics: new NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    faqpagecontroller = index + 1;
                                  });
                                  print(faqpagecontroller);
                                },
                                child: FaqBox(index)),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        );
                      }),
                )
              ]),
            ),
          )
        : (faqpagecontroller == 1)
            ? ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0XFFEEA4CE),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.02),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(
                                      1, 2), // changes position of shadow
                                ),
                              ]),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.,
                            children: [
                              TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.only(left: 10),
                                      minimumSize: Size(50, 50),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      alignment: Alignment.center),
                                  onPressed: () {
                                    faqpagecontroller = 0;
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.black,
                                    size: 20,
                                  )),
                              Container(
                                // height: 50,
                                width: SizeConfig.screenWidth - 250,
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        'faq_back'.tr().toString(),
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      // height: SizeConfig.screenHeight,
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cat1_list.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: qbox(cat1_list, index));
                          }),
                    ),
                  ),
                ],
              )
            : (faqpagecontroller == 2)
                ? ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0XFFEEA4CE),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.02),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(
                                          1, 2), // changes position of shadow
                                    ),
                                  ]),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.,
                                children: [
                                  TextButton(
                                      style: TextButton.styleFrom(
                                          padding: EdgeInsets.only(left: 10),
                                          minimumSize: Size(50, 50),
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          alignment: Alignment.center),
                                      onPressed: () {
                                        faqpagecontroller = 0;
                                        setState(() {});
                                      },
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.black,
                                        size: 20,
                                      )),
                                  Container(
                                    // height: 50,
                                    width: SizeConfig.screenWidth - 250,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'faq_back'.tr().toString(),
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          // height: SizeConfig.screenHeight,
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cat2_list.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: qbox(cat2_list, index));
                              }),
                        ),
                      ),
                    ],
                  )
                : (faqpagecontroller == 3)
                    ? ListView(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color(0XFFEEA4CE),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(40)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.02),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: Offset(1,
                                              2), // changes position of shadow
                                        ),
                                      ]),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.,
                                    children: [
                                      TextButton(
                                          style: TextButton.styleFrom(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              minimumSize: Size(50, 50),
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              alignment: Alignment.center),
                                          onPressed: () {
                                            faqpagecontroller = 0;
                                            setState(() {});
                                          },
                                          child: Icon(
                                            Icons.arrow_back_ios,
                                            color: Colors.black,
                                            size: 20,
                                          )),
                                      Container(
                                        // height: 50,
                                        width: SizeConfig.screenWidth - 250,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                'faq_back'.tr().toString(),
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              // height: SizeConfig.screenHeight,
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: cat3_list.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: qbox(cat3_list, index));
                                  }),
                            ),
                          ),
                        ],
                      )
                    : ListView(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color(0XFFEEA4CE),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(40)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.02),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: Offset(1,
                                              2), // changes position of shadow
                                        ),
                                      ]),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.,
                                    children: [
                                      TextButton(
                                          style: TextButton.styleFrom(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              minimumSize: Size(50, 50),
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              alignment: Alignment.center),
                                          onPressed: () {
                                            faqpagecontroller = 0;
                                            setState(() {});
                                          },
                                          child: Icon(
                                            Icons.arrow_back_ios,
                                            color: Colors.black,
                                            size: 20,
                                          )),
                                      Container(
                                        // height: 50,
                                        width: SizeConfig.screenWidth - 250,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                'faq_back'.tr().toString(),
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              // height: SizeConfig.screenHeight,
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: cat4_list.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: qbox(cat4_list, index));
                                  }),
                            ),
                          ),
                        ],
                      );
  }
}
// qbox(index);

class qbox extends StatefulWidget {
  int index;
  List<ClassFaq> catlist;

  qbox(this.catlist, this.index);

  @override
  State<qbox> createState() => _qboxState();
}

class _qboxState extends State<qbox> {
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
                ? Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.7),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Text(
                            '${widget.index + 1}. ${widget.catlist[widget.index].question}',
                            // overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 22.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.index + 1}. ${widget.catlist[widget.index].question}',
                              // overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${widget.catlist[widget.index].answer}',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.keyboard_arrow_up_rounded,
                                size: 22.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            // Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Container(
            //             height: 200,
            //             child: Text(
            //               '1.Question',
            //               textAlign: TextAlign.left,
            //               style: GoogleFonts.poppins(
            //                 fontWeight: FontWeight.w600,
            //                 color: Colors.black,
            //                 fontSize: 18,
            //               ),
            //             ),
            //           ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           Divider(
            //             height: 1,
            //             color: pink1,
            //           ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           Flexible(
            //             child: Text(
            //               'Answer 1',
            //               textAlign: TextAlign.left,
            //               style: GoogleFonts.poppins(
            //                 fontWeight: FontWeight.w600,
            //                 color: Colors.black,
            //                 fontSize: 18,
            //               ),
            //             ),
            //           ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           Center(
            //             child: Text(
            //               "^ Click to minimize ^",
            //               textAlign: TextAlign.center,
            //               style: GoogleFonts.poppins(
            //                 fontWeight: FontWeight.w200,
            //                 color: Colors.black,
            //                 fontSize: 11,
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
          ),
        ),
      ),
    );
  }
}

class FaqBox extends StatelessWidget {
  int index;

  FaqBox(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.9,
      height: 120,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/FAQcat$index.png")),
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
        child: Text(
          FAQ_category[index],
          textAlign: TextAlign.left,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class ClassFaq {
  String category, question, answer;

  ClassFaq(this.category, this.question, this.answer);
}
