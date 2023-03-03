import 'package:easy_localization/easy_localization.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pcod/HomePage.dart';
import 'package:pcod/LoginPage.dart';
import 'package:pcod/onboarding.dart';
import 'package:pcod/pulseratepredict.dart';
import 'package:pcod/respirationpredict.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'mobile.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:concentric_transition/concentric_transition.dart';

import 'models/predict_pcod_class.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData = const MediaQueryData();
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double blockSizeHorizontal = 0;
  static double blockSizeVertical = 0;
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}

bool already_sign_in = false;
CheckloggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? intValue = prefs.getInt('intValue');
  if (intValue == 1) {
    already_sign_in = true;
    print("true");
  } else {
    already_sign_in = false;
    print("false");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ClassPredictPcodAdapter());
  Box<dynamic> Hive_box = await Hive.openBox('myBox');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CheckloggedIn();
  runApp(
      EasyLocalization(
          supportedLocales: [Locale('en','US'),Locale('ta','IN')],
          fallbackLocale: Locale('en','US'),
          saveLocale: true,
          path: 'assets/translation',
          child: MyApp()
      ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates:context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(primaryColor: Colors.pink),
        debugShowCheckedModeBanner: false,
        home: (already_sign_in) ? HomePage(Hive_box) : OnboardingExample());
  }
}
