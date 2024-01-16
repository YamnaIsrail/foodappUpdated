import 'package:flutter/material.dart';
import 'package:foodapp/config/colors.dart';
import 'package:foodapp/providers/product_provider.dart';
import 'package:foodapp/providers/user_provider.dart';
import 'package:foodapp/screens/home_screen/homescreen.dart';
import 'package:foodapp/screens/my_profile/my_profile.dart';
import 'package:foodapp/screens/review_cart/review_cart.dart';
import 'package:foodapp/screens/search/search.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MaterialApp(
    home: MyHomePage(userProvider: UserProvider()),
  ));
}

class MyHomePage extends StatefulWidget {
  @override
  final UserProvider userProvider;

  const MyHomePage({required this.userProvider});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  @override

  Widget build(BuildContext context) {

    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();

    final productProvider = Provider.of<ProductProvider>(context);

    // Define the pages for each tab
    final List<Widget> _pages = [
      HomeScreen(),
      Search(search: productProvider.getAllProductSearch),
      ReviewCart(),
      MyProfile(userProvider: userProvider),
    ];

    return Scaffold(

      body: _pages[_currentIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (int index) {
          // Handle tab selection
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 20),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 20),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, size: 20),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 20),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

