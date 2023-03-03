//===================================================================

//
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:pcod/HomePage.dart';
//
//
//
// class FaqPage extends StatefulWidget {
//   @override
//   _FaqPageState createState() => _FaqPageState();
// }
//
// List<Widget> bodyElements = [];
// List<Widget> answerelements = [];
// void addBodyElement() {
//   bodyElements.add(
//
//     Container(
//         child:
//         Padding(
//           padding: const EdgeInsets.all(20),
//           child:Container(
//             width: double.infinity,
//             child: Center(child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 //crossAxisAlignment: CrossAxisAlignment.center,
//                 //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     alignment: Alignment.center,
//                     child:Container(
//                       child:
//                       TextField(
//                         textAlign: TextAlign.center,
//                         minLines: 1,
//                         maxLines: 10,
//                         style: TextStyle(fontSize: 20,
//                             fontWeight: FontWeight.w900
//                         ),
//                         decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: "Ask Your Questions",
//                             hintStyle: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w900,
//                             )
//                         ),
//                       ),
//                     ),),
//
//                   TextField(
//                     textAlign: TextAlign.center,
//                     minLines: 1,
//                     maxLines: 10,
//                     style: TextStyle(fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     decoration: InputDecoration(
//                         border: InputBorder.none,
//                         hintText: "enter answers here",
//                         hintMaxLines: 1,
//                         hintStyle: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         )
//                     ),
//                   ),
//                   Container(
//
//                     alignment: Alignment.bottomRight,
//                     child:
//                     ElevatedButton(
//                       child: Text(
//                           "+ Add Answer"),
//                       onPressed: (
//                           null),
//                       style: ButtonStyle(
//                         alignment: Alignment.bottomRight,
//                         shape:MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16.0),
//                             side: BorderSide(
//                               color: pink1,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ])
//             ),
//             decoration: BoxDecoration(
//               color: pink2,
//               borderRadius: BorderRadius.circular(15),
//             ),
//           ),
//         )
//     ),
//   );
// }
//
// class _FaqPageState extends State<FaqPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: ListView(
//         children: <Widget>[
//           Container(
//               alignment: Alignment.center,
//               padding:
//               const EdgeInsets.only(top: 25, left: 10, right: 10, bottom: 10),
//               child: Text(
//                 'Frequently Asked Questions',
//                 textAlign: TextAlign.left,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                   fontSize: 24,
//                 ),
//               )
//           ),
//           Column(
//             children: bodyElements,
//
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         backgroundColor: pink1,
//         extendedPadding: const EdgeInsets.all(25),
//         icon: Icon(Icons.add_circle_rounded,
//         ),
//         label: Text(
//             "Ask questions"),
//         extendedTextStyle: TextStyle(
//             color: Colors.black
//         ),
//         onPressed: () {
//           setState(() {
//             addBodyElement();
//           });
//         },
//       ),
//     );
//   }
// }
//===================================================================
import 'dart:core';
import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcod/HomePage.dart';
import 'package:pcod/main.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

Color lightpink = Color(0xFFFCDDEC);
TextEditingController nameController = TextEditingController();

class ForumPage extends StatefulWidget {
  const ForumPage({Key? key}) : super(key: key);

  @override
  State<ForumPage> createState() => _FaqPage();
}

void main() => runApp(ForumPage());
const double paddingInset = 5;
final myController = TextEditingController();
final myController1 = TextEditingController();
final Color darkpink = Color(0xFFEF5DA8);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
    );
  }
}

class _FaqPage extends State<ForumPage> {
  List<DocumentSnapshot> _products = [];
  bool _loadingProducts = true;
  int _perPage = 4;
  late DocumentSnapshot _lastDocument;
  bool _gettingMoreProducts = false;
  bool _moreProductsAvailable = true;
  ScrollController _scrollController = new ScrollController();

  _getProducts() async {
    Query q = (await FirebaseFirestore.instance
        .collection("Faq")
        .orderBy('question')
        .limit(_perPage));

    QuerySnapshot querySnapshot = await q.get();
    _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
    setState(() {
      _loadingProducts = true;
    });

    _products = querySnapshot.docs;
    setState(() {
      _loadingProducts = false;
    });
  }

  void _getMoreProducts() async {
    print("MORE MORE MORE");
    if (_moreProductsAvailable == false) {
      print("exit");
      return;
    }
    if (_gettingMoreProducts == true) {
      print("_gettingMoreProducts");
      return;
    }
    _gettingMoreProducts = true;
    Map<String, dynamic> data = _lastDocument.data()! as Map<String, dynamic>;
    print("last doc=${data['question']}");
    late Query q;

    q = (await FirebaseFirestore.instance
        .collection("Faq")
        .orderBy('question')
        .startAfter([data['question']]).limit(_perPage));

    QuerySnapshot querySnapshot = await q.get();
    if (querySnapshot.docs.length < _perPage) {
      print("LOW");
      _moreProductsAvailable = false;
    }
    _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
    if (querySnapshot.docs.length == 1) {
      _moreProductsAvailable = false;
    }
    _products.addAll(querySnapshot.docs);
    _gettingMoreProducts = false;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getProducts();

    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = SizeConfig.screenHeight * 0.25;
      // if ((maxScroll - currentScroll) <= delta && _moreProductsAvailable==true) {
      if (_scrollController.position.extentAfter < 500 &&
          _moreProductsAvailable == true) {
        print("CALLED");
        _getMoreProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Row(
              children: [
                Text(
                  'forumpage_title'.tr().toString(),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(), primary: Colors.black),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'forumpage_addqstn'.tr().toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Container(
                child: (_products.length == 0)
                    ? Center(
                        child: Text( 'forumpage_nofaqs'.tr().toString(),),
                      )
                    : (_loadingProducts == true)
                        ? Center(
                            child: Text( 'forumpage_loading'.tr().toString(),),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            controller: _scrollController,
                            itemCount: _products.length,
                            itemBuilder: (BuildContext context, int index) {
                              Map<String, dynamic> data = _products[index].data()!
                                  as Map<String, dynamic>;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: FaqWidget(data['question'], data['answer'],
                                    _products[index].id),
                              );
                            })
                ),
          ),
          SizedBox(height: 30,),
        ]),
      ),
    );
  }
}
class FaqWidget extends StatefulWidget {
  String question;
  List<dynamic> answer;
  String id;

  FaqWidget(this.question, this.answer, this.id);

  bool expand_answer = false;
  bool grey = true;
  String listener = "";

  @override
  State<FaqWidget> createState() => _FaqWidget();
}

class _FaqWidget extends State<FaqWidget> {
  TextEditingController answer_controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingInset),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 0),
                child: Container(
                  constraints:
                      BoxConstraints(maxWidth: SizeConfig.screenWidth * 0.7),
                  child: Text(
                    widget.question,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Spacer(),
              IconButton(
                  alignment: Alignment.centerRight,
                  tooltip:  'forumpage_tooltip1'.tr().toString(),
                  icon: Icon(Icons.add),
                  onPressed: () {
                    answer_controller.clear();
                    // answer_controller.addListener(check_valid);
                    showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      transitionDuration: Duration(milliseconds: 500),
                      barrierLabel:
                          MaterialLocalizations.of(context).dialogLabel,
                      barrierColor: Colors.black.withOpacity(0.5),
                      pageBuilder: (context, _, __) {
                        return SafeArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: DefaultTextStyle(
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                    child: Text(
                                      widget.question,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 150,
                                color: Colors.white,
                                child: Card(
                                  child: TextField(
                                    onChanged: (_) {
                                      if (_.length > 0)
                                        widget.grey = false;
                                      else
                                        widget.grey = true;
                                      setState(() {});
                                    },
                                    decoration: InputDecoration(
                                        fillColor: pink1,
                                        border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: pink1)),
                                        labelText:  'forumpage_labeltextanswer'.tr().toString(),
                                        labelStyle: TextStyle(color: pink1)),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 20,
                                    cursorColor: pink1,
                                    controller: answer_controller,
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 0, top: 0),
                                  child: Align(
                                    alignment: FractionalOffset.bottomCenter,
                                    child: Container(
                                      width: SizeConfig.screenWidth * 1,
                                      decoration: new BoxDecoration(),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: (!widget.grey)
                                                ? Color(0xFFEF5DA8)
                                                : Colors.grey,
                                            onPrimary: Colors.pink,
                                            elevation: 5,
                                            shadowColor: (!widget.grey)
                                                ? Colors.pinkAccent
                                                : Colors.grey.shade600,
                                            shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(25),
                                                      bottomRight:
                                                          Radius.circular(25)),
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 18),
                                          child: Text(
                                            'forumpage_post'.tr().toString(),
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        onPressed: () async {
                                          if (answer_controller.text.length >
                                                  1 &&
                                              answer_controller.text != null) {
                                            widget.answer
                                                .add(answer_controller.text);
                                            await FirebaseFirestore.instance
                                                .collection('Faq')
                                                .doc(widget.id)
                                                .update(
                                                    {'answer': widget.answer});
                                            Navigator.pop(context);
                                            setState(() {});
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
                                                  message:
                                                  'forumpage_snackbar'.tr().toString(),
                                                ),
                                              ),
                                            );
                                          } else {}
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      transitionBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                          position: CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOut,
                          ).drive(Tween<Offset>(
                            begin: Offset(0, -1.0),
                            end: Offset.zero,
                          )),
                          child: child,
                        );
                      },
                    );
                  }),
            ],
          ),
          (widget.expand_answer == true)
              ? Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.answer.length,
                        itemBuilder: (context, index) {
                          return Card(
                            key: UniqueKey(),
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  widget.answer[index],
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade800,
                                    fontSize: 14,
                                  ),
                                )),
                          );
                        }),
                  ),
                )
              : ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent],
                    ).createShader(
                        Rect.fromLTRB(0, 0, rect.width, rect.height - 10));
                  },
                  blendMode: BlendMode.dstIn,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Card(
                            key: UniqueKey(),
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  widget.answer[index],
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade800,
                                    fontSize: 14,
                                  ),
                                )),
                          );
                        }),
                  ),
                ),
          Align(
            alignment: Alignment.center,
            child: IconButton(
              tooltip: (widget.expand_answer == false) ?
    'forumpage_tooltip2'.tr().toString() :
    'forumpage_tooltip3'.tr().toString(),
              onPressed: () {
                widget.expand_answer = !widget.expand_answer;
                setState(() {});
              },
              icon: Icon((widget.expand_answer == false)
                  ? Icons.keyboard_arrow_down_rounded
                  : Icons.keyboard_arrow_up_rounded),
              color: Colors.grey,
              iconSize: 30.0,
            ),
          ),
        ],
      ),
    );
  }

  void check_valid() {
    if (answer_controller.text.length > 0) {
      widget.grey = false;
      print("FALSEEEEEE");
    } else {
      widget.grey = true;
    }
  }
}