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
      backgroundColor: Colors.orangeAccent,
      body: Center(
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

                // Email and password text fields
                Container(
                  height: MediaQuery.of(context).size.width * 0.08,
                  child: TextField(
                    style: TextStyle( color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 2),
                      ),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                      icon: Icon(Icons.email, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  height: MediaQuery.of(context).size.width * 0.08,
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 2),
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                      icon: Icon(Icons.admin_panel_settings, color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.02,
                        // Adjust as needed
                        vertical: MediaQuery.of(context).size.width *0.03, // Adjust as needed
                      ),
                      backgroundColor: Colors.cyan,
                      foregroundColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                        fontSize: MediaQuery.of(context).size.width * 0.025, // Adjust as needed
                      ),
                    ),
                  ),
                ),

                // Sign in with Google button
                Container(
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
                SignInButton(
                  Buttons.apple,
                  text: "Sign in with Apple",
                  onPressed: (){

                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}