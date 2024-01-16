import 'package:flutter/material.dart';
import 'package:foodapp/config/colors.dart';
import 'package:foodapp/config/size_config.dart';
import 'package:foodapp/screens/home_screen/nav.dart';
import 'package:lottie/lottie.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

import '../../auth/sign_in.dart';


class SplashScreenGif extends StatefulWidget {
  @override
  _SplashScreenGifState createState() => _SplashScreenGifState();
}

class _SplashScreenGifState extends State<SplashScreenGif> {
  bool showText = false;

  @override


  Future<void> loadData() async {
    String jsonString = '{"key": "value",}';

    try {
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      print("Parsed JSON: $jsonMap");

      // Continue with your logic, e.g., navigate to the main screen
      MyNavBar();
    } catch (e) {
      print("Error parsing JSON: $e");

      // Handle the error or take appropriate action
      // For example, you could display an error message or retry loading the data.
    }
  }

  void initState() {
    super.initState();
    loadData();


      Future.delayed(Duration(seconds: 4), () {
        setState(() {
          showText = true;
        // Navigate to the home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyNavBar()), //MyNavBar()
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: primaryGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.white,
                foregroundImage: AssetImage("assets/images/fireBurgerGif.gif"),
              ),
              Text("Food Flows", style: TextStyle(fontSize: 45.0,color: Colors.white, letterSpacing: 3, fontFamily: "Signatra"),
              ),
            ],
          ),
        )
      ),

    );
  }
}
