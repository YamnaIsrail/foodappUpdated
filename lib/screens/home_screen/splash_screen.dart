import 'package:flutter/material.dart';
import 'package:foodapp/screens/home_screen/nav.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5), () {
      // Navigate to the home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyNavBar()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.network(
          'https://assets5.lottiefiles.com/private_files/lf30_dNmoO1.json',
          width: 200,
          height: 200,
          repeat: false, // Set to true if you want the animation to loop
          reverse: false, // Set to true if you want the animation to play in reverse
          animate: true, // Set to false if you want to display a static frame
        ),
      ),
    );
  }
}
