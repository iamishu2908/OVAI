import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pcod/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
Box<dynamic> Hive_box1 = Hive.box('myBox');

late User user;
Prefsetsignin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('intValue',1);
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
bool isLoggedIn = false;
var det = "";

Future<String?> signInWithGoogle() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount!.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
  await _auth.signInWithCredential(credential);
  user = authResult.user!;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User? currentUser = _auth.currentUser;
    assert(user.uid == currentUser!.uid);

    print('signInWithGoogle succeeded: ${user}');
    det = (await user.displayName)!;
    print(det);
    Prefsetsignin();
    return '${user.displayName}';
  }

  return null;
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}

class AlreadyLoginPage extends StatefulWidget {
  late final Box<dynamic> box;
  AlreadyLoginPage(this.box);
  @override
  _AlreadyLoginPageState createState() => _AlreadyLoginPageState();
}

class _AlreadyLoginPageState extends State<AlreadyLoginPage> {
  var loggedIn = false;
  var firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    Hive_box1=widget.box;
    // TODO: implement initState
    super.initState();
    signInWithGoogle().then((result) {
      if (result != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return HomePage(Hive_box1);
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 5,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'OV',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                    fontSize: 60,
                  ),),
                Text(
                  'AI',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w300,
                    color: Colors.pink,
                    fontSize: 60,
                  ),),
              ],
            ),
          ),
          Center(
              child: Text("Loading...",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: Colors.black))),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
                child: Text(
                  "Just a Second",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Center(
                child: SpinKitWave(
                  color: Colors.pink,
                  size: 50,
                  itemCount: 5,
                  type: SpinKitWaveType.start,
                )),
          ),
        ],
      ),
    );
  }

  Widget _googleSignInButton() {
    return OutlinedButton(
      // splashColor: Colors.pinkAccent,
      onPressed: () async {
        signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return HomePage(Hive_box1);
                },
              ),
            );
          }
        });
      },
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      // highlightElevation: 0,
      // borderSide: BorderSide(color: Colors.blue),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("images/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
