import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/config/colors.dart';
import 'package:foodapp/providers/product_provider.dart';
import 'package:foodapp/providers/user_provider.dart';
import 'package:foodapp/screens/home_screen/homescreen.dart';
import 'package:foodapp/screens/my_profile/my_profile.dart';
import 'package:foodapp/screens/review_cart/review_cart.dart';
import 'package:foodapp/screens/search/search.dart';
import 'package:foodapp/screens/wishlist/wishlist.dart';
import 'package:provider/provider.dart';

class MyNavBar extends StatefulWidget {
  @override
  _MyNavBarState createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  final GlobalKey<CurvedNavigationBarState> navigationKey =
  GlobalKey<CurvedNavigationBarState>();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    userProvider.getUserData();

    final productProvider = Provider.of<ProductProvider>(context);

    final items = [
      Icon(Icons.home, size: 20.0),
      Icon(Icons.search, size: 20.0),
      Icon(Icons.shopping_cart, size: 20.0),
      Icon(Icons.favorite, size: 20.0),
      Icon(Icons.person, size: 20.0),
    ];

    final screens = [
      HomeScreen(),
      Search(search: productProvider.getAllProductSearch),
      ReviewCart(),
      WishList(),
      MyProfile(userProvider: userProvider),
    ];

    return Container(
      // color: buttonColor,
      decoration: BoxDecoration(
        gradient: primaryGradient,
        borderRadius: BorderRadius.circular(
          30,
        ),
      ),
      child: SafeArea(
        top: false,
        child: Scaffold(
          extendBody: true,
          backgroundColor: Colors.white,

          // body: screens[_currentIndex],
          body: SafeArea(child: _currentIndex < screens.length ? screens[_currentIndex] : Container()),

          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              iconTheme: IconThemeData(color: Colors.white),
            ),
            child: Container(
              // decoration: BoxDecoration(
              //   gradient: primaryGradient,
              // ),
              child: CurvedNavigationBar(
                key: navigationKey,
                color: Colors.black26,
                backgroundColor: Colors.transparent,
                buttonBackgroundColor: buttonColor,
                height: 50.0,
                animationCurve: Curves.easeInOut,
                animationDuration: Duration(milliseconds: 400),
                index: _currentIndex,
                items: items,
                onTap: (index) => setState(() => _currentIndex = index),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
