import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/config/colors.dart';
import 'package:foodapp/providers/user_provider.dart';
import 'package:foodapp/screens/home_screen/bottom_nav.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../screens/home_screen/homescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId: '702238377977-5oal6q07j2agsl6k2r2thk1p6e3hsfcf',
);

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late UserProvider userProvider;
  Future<User?> _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // Handle the case where the user cancels sign-in or it fails
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        userProvider.addUserData(
          currentUser: user,
          userEmail: user.email ?? "No Email",
          userImage: user.photoURL ?? "",
          userName: user.displayName ?? "Unknown User",
        );

      }

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.orange,


      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.cyan,
                  Colors.amber
                ],
                begin: FractionalOffset(0.0, 1.0),
                end: FractionalOffset(1.0, 0.0),
                //stops: [0.2, 1.0],
                stops: [0.0, 2.0],
                tileMode: TileMode.clamp
            )
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    //"assets/images/CbFD.gif",
                    "assets/images/orderr.png",
                    height: 250,
                  ),

                  SizedBox(height: 30),

                  // Sign in with Google button
                  Container(
                    height: 30,
                    child: SignInButton(
                      Buttons.google,
                      text: "Sign in with Google",
                      onPressed: () async {
                        await _googleSignUp().then(
                              (value) => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(userProvider: UserProvider()),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 10),

                  // Sign in with Apple button
                  Container(
                    height: 30,
                    child: SignInButton(
                      Buttons.apple,
                      text: "Sign in with Apple",
                      onPressed: (){

                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}