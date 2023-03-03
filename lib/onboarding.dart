import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcod/LoginPage.dart';
import 'package:pcod/main.dart';

import 'HomePage.dart';

Color pink_pastel = Color(0xFFFCDDEC);
Color pink1 = Color(0xFFF178B6);
int finalslideindex = 0;
int currentpage = 0;
List<PageData> pages = [
  PageData(
    image: 'assets/images/onboarding/logo.png',
    blob: 'assets/images/onboarding/blob1.png',
    title: "Welcome!",
    subtext:
        "Join us to help improve your lifestyle and live\na PCOD-free living",
    bgColor: Colors.white,
    textColor: Colors.black,
  ),
  PageData(
    image: 'assets/images/onboarding/human1.png',
    blob: 'assets/images/onboarding/blob2.png',
    title: "Stay on Track",
    subtext:
        "With our accurate and real-time predictions,\nyou now keep track of your calorie intake,\nnumber of steps taken antaken\nsleep cycle and much more",
    bgColor: Colors.white,
    textColor: Colors.black,
  ),
  PageData(
    image: 'assets/images/onboarding/human2.png',
    blob: 'assets/images/onboarding/blob3.png',
    title: "Adapt to a better\nlifestyle",
    subtext:
        "We offer you personalised diet and fitness \nsuggestions to help you adapt to a \nhealthier style",
    bgColor: Colors.white,
    textColor: Colors.black,
  ),
  PageData(
    image: 'assets/images/onboarding/human3.png',
    blob: 'assets/images/onboarding/blob4.png',
    title: "Have a regular check",
    subtext:
        "Using the PCOD predictor you can measure \nyour current risk of having PCOD",
    bgColor: Colors.white,
    textColor: Colors.black,
  ),
  PageData(
    image: 'assets/images/onboarding/human4.png',
    blob: 'assets/images/onboarding/blob5.png',
    title: "Don’t fret, be a part\nof us",
    subtext:
        "Our community will offer you support and \nhelp you get all your questions answered ",
    bgColor: Colors.white,
    textColor: Colors.black,
  ),
];

class OnboardingExample extends StatefulWidget {
  const OnboardingExample({Key? key}) : super(key: key);

  @override
  State<OnboardingExample> createState() => _OnboardingExample();
}

class _OnboardingExample extends State<OnboardingExample> {
  @override
  void initState() {
    finalslideindex = pages.length - 1;
    print("helo $finalslideindex");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pages = [
      PageData(
        image: 'assets/images/onboarding/logo.png',
        blob: 'assets/images/onboarding/blob1.png',
        title: "Welcome!",
        subtext:
            "Join us to help improve your lifestyle and live\na PCOD-free living",
        bgColor: Colors.white,
        textColor: Colors.black,
      ),
      PageData(
        image: 'assets/images/onboarding/human1.png',
        blob: 'assets/images/onboarding/blob2.png',
        title: "Stay on Track",
        subtext:
            "With our accurate and real-time predictions,\nyou now keep track of your calorie intake,\nnumber of steps taken antaken\nsleep cycle and much more",
        bgColor: Colors.white,
        textColor: Colors.black,
      ),
      PageData(
        image: 'assets/images/onboarding/human2.png',
        blob: 'assets/images/onboarding/blob3.png',
        title: "Adapt to a better\nlifestyle",
        subtext:
            "We offer you personalised diet and fitness \nsuggestions to help you adapt to a \nhealthier style",
        bgColor: Colors.white,
        textColor: Colors.black,
      ),
      PageData(
        image: 'assets/images/onboarding/human3.png',
        blob: 'assets/images/onboarding/blob4.png',
        title: "Have a regular check",
        subtext:
            "Using the PCOD predictor you can measure \nyour current risk of having PCOD",
        bgColor: Colors.white,
        textColor: Colors.black,
      ),
      PageData(
        image: 'assets/images/onboarding/human4.png',
        blob: 'assets/images/onboarding/blob5.png',
        title: "Don’t fret, be a part\nof us",
        subtext:
            "Our community will offer you support and \nhelp you get all your questions answered ",
        bgColor: Colors.white,
        textColor: Colors.black,
      ),
    ];
    SizeConfig().init(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ConcentricPageView(
        colors: pages.map((p) => p.bgColor).toList(),
        radius: screenWidth * 0.1,
        onChange: (a) {
          currentpage = a;
          print("$currentpage     $finalslideindex");
          setState(() {});
        },
        // curve: Curves.ease,
        nextButtonBuilder: (context) => Padding(
          padding: const EdgeInsets.only(left: 0), // visual center
          child: TextButton(
            onPressed:
                //   (){
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return LoginPage(Hive_box);
                //     },
                //   ),
                // );
                (currentpage != finalslideindex)
                    ? null
                    : () {
                        print("$currentpage  $finalslideindex");
                        if (currentpage == pages.length - 1)
                          // Navigator.push(context, ConcentricPageRoute(builder: (ctx) {
                          //   return LoginPage(Hive_box);
                          // }));
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return LoginPage(Hive_box);
                              },
                            ),
                          );
                      },
            child: Icon(
              Icons.navigate_next_rounded,
              size: 70,
              color: Colors.black,
            ),
          ),
        ),
        itemCount: pages.length,
        // duration: const Duration(milliseconds: 1500),
        // opacityFactor: 2.0,
        // scaleFactor: 0.2,
        // verticalPosition: 0.7,
        // direction: Axis.vertical,
        // itemCount: pages.length,
        // physics: NeverScrollableScrollPhysics(),
        itemBuilder: (index) {
          final page = pages[index];
          return SafeArea(
            child: _Page(page, index),
          );
        },
      ),
    );
  }
}

class PageData {
  final String? title;
  final String? subtext;
  final String? image;
  final String? blob;
  final Color bgColor;
  final Color textColor;

  const PageData({
    this.title,
    this.subtext,
    this.image,
    this.blob,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
  });
}

class _Page extends StatelessWidget {
  final PageData page;
  int index;
  _Page(this.page, this.index);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Container(
          height: SizeConfig.screenHeight / 1.2,
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(page.blob!), fit: BoxFit.fitWidth),

                      // color: Colors.amber,
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(top: SizeConfig.screenHeight / 7),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: _Image(
                    page: page,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: SizeConfig.screenHeight / 2),
                child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: SizeConfig.screenWidth,
                      height: 300,
                      child: Column(
                        children: [
                          Text(
                            page.title!,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: SizeConfig.screenWidth / 11,
                            ),
                          ),
                          Text(
                            page.subtext!,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFADA4A5),
                              fontSize: SizeConfig.screenWidth / 30,
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: (index == finalslideindex)
                    ? SizedBox(
                        height: 0,
                      )
                    : Text(
                        "Swipe right to proceed >>>",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w200,
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    Key? key,
    required this.page,
  }) : super(key: key);

  final PageData page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(page.image!), fit: BoxFit.fitHeight),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          // color: Colors.amber,
        ),
      ),
    );
  }
}
