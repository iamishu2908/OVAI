import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pcod/HomePage.dart';
import 'package:pcod/RegisterPage.dart';
import 'package:pcod/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Box<dynamic> Hive_box = Hive.box('myBox');
bool isButtonDisabled = true;
late User user;
bool checkbox_value = false;
Prefsetsignin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('intValue', 1);
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
bool isLoggedIn = false;
var det = "";

Future<User?> signInWithGoogle() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication? googleSignInAuthentication =
      await googleSignInAccount?.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication!.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  user = authResult.user!;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User? currentUser = _auth.currentUser;
    assert(user.uid == currentUser?.uid);

    print('signInWithGoogle succeeded: ${user}');
    det = (await user.displayName)!;
    print(det);
    return user;
  }

  return null;
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}

class LoginPage extends StatefulWidget {
  late final Box<dynamic> box;
  LoginPage(this.box);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      isLoggedIn = isLoggedIn;
    });
  }

  var loggedIn = false;
  var firebaseAuth = FirebaseAuth.instance;
  TextEditingController nameController = TextEditingController();
  Color label = Color(0xADA4A5);
  Color button = Color(0xF7F8F8);

  @override
  Widget build(BuildContext context) {
    Hive_box = widget.box;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false, //new line

        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Center(
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // FlutterLogo(size: 150),
                    Text(
                      'LoginPage_greeting'.tr().toString(),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'LoginPage_create'.tr().toString(),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  ],
                ),
              ),
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: new BoxDecoration(
                border: Border.all(
                    color: Colors
                        .transparent //                   <--- border color
                    ),
                color: Color(0xFFF7F8F8),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(14.0)),
              ),
              padding: const EdgeInsets.only(left: 20),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      print("changed $value");
                      setState(() {});
                    },
                    textCapitalization: TextCapitalization.words,
                    textAlign: TextAlign.start,
                    cursorColor: Color(0xFFF7F8F8),
                    controller: nameController,
                    decoration: InputDecoration(
                      //color:Color(0xFF7b6f72),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'LoginPage_hinttext'.tr().toString(),
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Color(0xFFada4a5),
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: Checkbox(
                      checkColor: Colors.white,
                      activeColor: Color(0xFFEF5DA8),
                      value: checkbox_value,
                      onChanged: (value) {
                        setState(() {
                          checkbox_value = value!;
                          print(checkbox_value);
                        });
                      },
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7),
                    child: Text(
                      'LoginPage_name'.tr().toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Color(0xFFada4a5),
                          fontSize: MediaQuery.of(context).size.width * 0.03),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),

            Flexible(
              child: Image(
                image: AssetImage('assets/images/standing-8.png'),
              ),
            ),
            SizedBox(height: 39),
            _googleSignInButton(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                TextButton(
                  onPressed: (){
                    setState(() {
                      context.locale = Locale('en','US');
                    });
                  },
                  child: Text(
                      'English'
                  ),
                ),
                TextButton(
                  onPressed: (){
                    setState(() {
                      context.locale = Locale('ta','IN');
                    });
                  },
                  child: Text(
                      'Tamil'
                  ),
                )
              ],
            ),
            // ElevatedButton(
            //     onPressed: _googleSignInButton,
            //     child: const Text('Continue'))
          ]),
        ),
      ),
    );
  }

  Widget _googleSignInButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: (checkbox_value == true && nameController.text.length > 0)
            ? LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xFFEF5DA8), Color(0xFFEF5DA8)],
                //colors: [
                //Color(0xFF9AC3FF),
                //Color(0xFF93A6FD),
                //],
              )
            : LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.grey.shade400, Colors.grey.shade400],
                //colors: [
                //Color(0xFF9AC3FF),
                //Color(0xFF93A6FD),
                //],
              ),
      ),
      child: MaterialButton(
        onPressed: () async {
          signInWithGoogle().then((result) {
            if (result != null &&
                checkbox_value == true &&
                nameController.text.length > 0) {
              Hive_box.put('name', nameController.text);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return RegisterPage(Hive_box, true);
                  },
                ),
              );
            }
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
        highlightElevation: 0,
        height: 60,
        minWidth: MediaQuery.of(context).size.width * 0.85,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 18,
                width: 18,
                child: Image(
                  image: AssetImage('assets/images/googleicon.png'),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'LoginPage_google'.tr().toString(),
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.055,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//git fixed
