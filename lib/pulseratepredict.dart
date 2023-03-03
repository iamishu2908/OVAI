import 'package:easy_localization/easy_localization.dart';
import 'package:pcod/HomePage.dart';
import 'package:pcod/PredictPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:pcod/HomePage.dart' as HomePage;
import 'package:numberpicker/numberpicker.dart';

int _pulsecounter = 0;
int pulsevalue = _pulsecounter * 3;
bool isNextpulse = true;
int isDonepulse = 0;
final int _duration = 20;
final CountDownController _countDownPulsecontroller = CountDownController();

class PulseRate extends StatefulWidget {
  PulseRate();
  @override
  State<PulseRate> createState() => _PulseRateState();
}

class _PulseRateState extends State<PulseRate> {
  void _incrementReset() {
    setState(() {
      _pulsecounter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ScrollConfiguration(
            behavior: HomePage.MyBehavior(),
            child: ListView(
              children: [
                Stack(children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        'pulse_title'.tr().toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 22,
                        ),
                      )),
                  Container(
                    decoration: new BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.topLeft,
                    child: BackButton(
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PredictPage()),
                          );
                          setState(() => pulseratecontroller.text = "");
                          _incrementReset();
                          setState(() => isDonepulse = 0);
                          setState(() => isNextpulse = true);
                        }),
                  ),
                  Container(
                    decoration: new BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.topLeft,
                    child: BackButton(
                        color: pink2,
                        onPressed: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PredictPage()),
                          );
                          setState(() => pulseratecontroller.text = "");
                          _incrementReset();
                          setState(() => isDonepulse = 0);
                          setState(() => isNextpulse = true);
                        }
                        ),
                  ),
                ]),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      'pulse_1'.tr().toString(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Color(0xFF7B6F72),
                        fontSize: 14,
                      ),
                    )),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                (isNextpulse == true)
                    ? Container(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 0, top: 5),
                          child: Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: new BoxDecoration(),
                              child: _button(
                                  title: "pulse_4".tr().toString(),
                                  onPressed: () {
                                    _countDownPulsecontroller.start();
                                    setState(() => isNextpulse = false);
                                    setState(() => isDonepulse = 0);
                                  }),
                            ),
                          ),
                        ),
                      )
                    : (isDonepulse == 1)
                        ? Container(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 0, top: 5),
                              child: Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
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
                                                  new BorderRadius.circular(
                                                      25.0),
                                            )),
                                        onPressed: () {
                                          Navigator.pop(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PredictPage()),
                                          );
                                          setState(() => pulseratecontroller
                                              .text = "$pulsevalue");
                                          setState(() => isDonepulse = 0);
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
                        : Container(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                Stack(children: <Widget>[
                  Container(
                    // height: 350,
                    constraints: BoxConstraints(minHeight: 120, maxHeight: 350),
                    alignment: Alignment.center,
                    child: CircularCountDownTimer(
                      duration: _duration,
                      initialDuration: 0,
                      controller: _countDownPulsecontroller,
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: MediaQuery.of(context).size.height / 2.5,
                      ringColor: HomePage.pink2,
                      ringGradient: null,
                      fillColor: HomePage.pink1,
                      fillGradient: null,
                      backgroundColor: Colors.white,
                      backgroundGradient: null,
                      strokeWidth: 20.0,
                      strokeCap: StrokeCap.round,
                      textStyle: TextStyle(
                          fontSize: 33.0,
                          color: HomePage.pink1,
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
                        setState(() => isDonepulse = 1);
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
                        _countDownPulsecontroller.reset();
                        _countDownPulsecontroller.pause();
                        _incrementReset();
                        setState(() => isNextpulse = true);
                        setState(() => isDonepulse = 0);
                      },
                    ),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'pulse_2'.tr().toString(),
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
                          '$_pulsecounter',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: HomePage.pink1,
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                          ),
                        )),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                NumberPicker(
                  value: _pulsecounter,
                  selectedTextStyle: TextStyle(
                      color: HomePage.pink1,
                      fontSize: MediaQuery.of(context).size.width * 0.1),
                  minValue: 0,
                  maxValue: 100,
                  onChanged: (value) => setState(() => _pulsecounter = value),
                )
              ],
            ),
          ),
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
            "pulse_start".tr().toString(),
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
