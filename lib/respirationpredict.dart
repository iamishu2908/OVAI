import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:pcod/HomePage.dart';
import 'package:pcod/PredictPage.dart';
import 'package:pcod/PredictPage.dart';

int isDone = 0;
int _counter = 0;
int respvalue = _counter * 3;
final CountDownController _countDowncontroller = CountDownController();
bool isNext = true;
final int _duration = 20;

class RespirationRate extends StatefulWidget {
  const RespirationRate({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  State<RespirationRate> createState() => _RespirationRateState();
}

class _RespirationRateState extends State<RespirationRate> {
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _incrementReset() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    'resp_title'.tr().toString(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.07,
                    ),
                  )),
              Container(
                alignment: Alignment.topLeft,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: BackButton(onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => PredictPage()),
                  );
                  setState(() => respirationratecontroller.text = "");
                  _incrementReset();
                  setState(() => isDone = 0);
                  setState(() => isNext = true);
                }),
              ),
            ]),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  'resp_1'.tr().toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  ),
                )),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            (isNext == true)
                ? Container(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 0, top: 5),
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: new BoxDecoration(),
                          child: _button(
                              title: 'pulse_4'.tr().toString(),
                              onPressed: () {
                                _countDowncontroller.start();
                                setState(() => isNext = false);
                                setState(() => isDone = 0);
                              }),
                        ),
                      ),
                    ),
                  )
                : SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            Stack(children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: CircularCountDownTimer(
                  duration: _duration,
                  initialDuration: 0,
                  controller: _countDowncontroller,
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: MediaQuery.of(context).size.height / 2.5,
                  ringColor: pink2,
                  ringGradient: null,
                  fillColor: pink1,
                  fillGradient: null,
                  backgroundColor: Colors.white,
                  backgroundGradient: null,
                  strokeWidth: 20.0,
                  strokeCap: StrokeCap.round,
                  textStyle: TextStyle(
                      fontSize: 33.0,
                      color: pink1,
                      fontWeight: FontWeight.bold),
                  textFormat: CountdownTextFormat.S,
                  isReverse: true,
                  isReverseAnimation: true,
                  isTimerTextShown: true,
                  autoStart: false,
                  onStart: () {
                    debugPrint('Countdown Started');
                  },
                  onComplete: () {
                    setState(() => isDone = 1);
                    debugPrint('Countdown Ended');
                  },
                  onChange: (String timeStamp) {
                    debugPrint('Countdown Changed $timeStamp');
                  },
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFFada4a5),
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10)),
                  child: const Icon(
                    Icons.loop_outlined,
                    size: 20,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _incrementReset();
                    _countDowncontroller.reset();
                    _countDowncontroller.pause();
                    setState(() => isNext = true);
                    setState(() => isDone = 0);
                  },
                ),
              ),
            ]),
            //onPressed: ()=> _countDowncontroller.restart(duration: _duration),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'resp_2'.tr().toString(),
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                    )),
                Container(
                    alignment: Alignment.center,
                    child: Text(
                      '$_counter',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: pink1,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                    )),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            (isDone == 0)
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFFEF5DA8),
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(30)),
                    child: const Icon(
                      Icons.add,
                      size: 32,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _incrementCounter();
                    },
                  )
                : (isDone == 1)
                    ? Container(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 0, top: 5),
                          child: Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: new BoxDecoration(),
                                child: Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0xFFEF5DA8),
                                        onPrimary: Colors.pink,
                                        elevation: 5,
                                        shadowColor: Colors.pinkAccent,
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(25.0),
                                        )),
                                    onPressed: () {
                                      Navigator.pop(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PredictPage()),
                                      );
                                      setState(() => respirationratecontroller
                                          .text = "$respvalue");
                                      setState(() => isDone = 0);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 18),
                                      child: Text(
                                        'pulse_3'.tr().toString(),
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      )
                    : Container()
          ],
        ),
      ),
    );
  }

  Widget _button({required String title, VoidCallback? onPressed}) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Color(0xFFEF5DA8),
            onPrimary: Colors.pink,
            elevation: 5,
            shadowColor: Colors.pinkAccent,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(25.0),
            )),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Text(
            'pulse_start'.tr().toString(),
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
