import 'package:foodapp/providers/check_out_providers.dart';
import 'package:foodapp/providers/product_provider.dart';
import 'package:foodapp/providers/review_cart_provider.dart';
import 'package:foodapp/providers/user_provider.dart';
import 'package:foodapp/providers/wishlist_provider.dart';
import 'package:foodapp/screens/home_screen/bottom_nav.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/auth/sign_in.dart';
import 'package:foodapp/screens/home_screen/homescreen.dart';
import 'package:foodapp/screens/home_screen/nav.dart';
import 'package:foodapp/screens/home_screen/splash_screen.dart';
import 'package:foodapp/screens/home_screen/splash_screen_gif.dart';
import 'package:foodapp/screens/product_overview/product_overview.dart';
import 'package:foodapp/screens/review_cart/review_cart.dart';
import 'package:provider/provider.dart';

Future<void> main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD0qf8stWBFVpy8_XeODlCFshHZzhowr9A",
      authDomain: "",
      projectId: "foodapp-e30a2",
      storageBucket: "",
      messagingSenderId: "702238377977",
      appId: "1:702238377977:android:604ecea80cc568dda35f28",
    ),
  ); // Initialize Firebase

  runApp( MyApp(userProvider: UserProvider()));
}

class MyApp extends StatefulWidget {
  final UserProvider userProvider;
  const MyApp({required this.userProvider});
  

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(providers: [
      ChangeNotifierProvider(
      create: (context) => ReviewCartProvider(),
      child: ReviewCart(), // Your ReviewCart widget
    ),

      
      ChangeNotifierProvider<ProductProvider>(
        create: (context)=>ProductProvider(),
      ),
      ChangeNotifierProvider<UserProvider>(
        create: (context)=>UserProvider(),
      ),
      ChangeNotifierProvider<WishListProvider>(
        create: (context)=>WishListProvider(),
      ),
      ChangeNotifierProvider<CheckoutProvider>(
        create: (context)=>CheckoutProvider(),
      ),



    ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,

       //home: MyHomePage(userProvider:widget.userProvider),
        home: SplashScreenGif(),
        //home:SignIn(),
      ),
    );
  }
}


