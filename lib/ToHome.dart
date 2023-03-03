import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pcod/HomePage.dart';
import 'package:pcod/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class ToHome extends StatefulWidget {
  const ToHome({Key? key}) : super(key: key);
  @override
  State<ToHome> createState() => _ToHome();
}

class _ToHome extends State<ToHome> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: SizeConfig.screenHeight,
          child: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                        child: Container(
                            child: Image(
                      image:
                          AssetImage('assets/images/Humaaans 1 Character.png'),
                      // fit: BoxFit.fitHeight,
                    ))),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Welcome, User',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 24,
                          ),
                        )),
                    SizedBox(height: 7),
                    Container(
                        width: 230,
                        alignment: Alignment.center,
                        child: Text(
                            'You are all set now,lets reach your goals together with us',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF7B6F72),
                              fontSize: 12,
                            ))),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                      width: 318,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF8AC3FF),
                            Color(0xFF93A6FD),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Go To Home',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
