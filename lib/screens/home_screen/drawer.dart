import 'package:flutter/material.dart';
import 'package:foodapp/config/colors.dart';
import 'package:foodapp/providers/user_provider.dart';
import 'package:foodapp/screens/review_cart/review_cart.dart';
import 'package:foodapp/screens/wishlist/wishlist.dart';
import 'package:foodapp/welcome_slider/welcome.dart';

import '../../auth/sign_in.dart';
import '../my_profile/my_profile.dart';

class drawerSide extends StatefulWidget {
  final UserProvider userProvider;
  const drawerSide({required this.userProvider});

  @override
  _drawerSideState createState() => _drawerSideState();
}

class _drawerSideState extends State<drawerSide> {
 @override
  Widget build(BuildContext context) {

  var userData = widget.userProvider.currentUserData;

    return Padding(
      padding: const EdgeInsets.only(right: 80.0),
      child: Container(
        //color: primaryColor,
        decoration: BoxDecoration(
          gradient: primaryGradient,
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  // color: Color(0xffb0ad13),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 43,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Color(0xffb0ad13),
                          backgroundImage: NetworkImage(
                              userData?.userImage ??
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUA9IuDIQlQ4gfQAEBvKOLBgBUHtEKPqWirw&usqp=CAU",
                          ),

                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(userData.userName, style: TextStyle(fontSize: 14),),
                          Text(
                            userData.userEmail,
                            overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12)
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: Text('Login Page'),
              onTap: () {
                // Handle the Home item tap
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Welcome()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.shop_outlined),
              title: Text("Review Cart"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ReviewCart(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_outlined),
              title: Text("My Profile"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MyProfile(userProvider: widget.userProvider,),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications_outlined),
              title: Text("Notification"),
            ),
            ListTile(
              leading: const Icon(Icons.star_outline),
              title: Text("Rating & Review"),
            ),
            ListTile(
              leading: const Icon(Icons.favorite_outline),
              title: Text("Wishlist"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => WishList(),
                  ),
                );
              },
            ),
            ListTile(leading: const Icon(Icons.copy_outlined), title: Text("Raise a Complaint")),
            ListTile(leading: const Icon(Icons.format_quote_outlined), title: Text("FAQs")),
            SizedBox(height: 10,),
            Divider(height: 5,),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Contact Support"),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("Call us:"),
                      SizedBox(
                        width: 10,
                      ),
                      Text("+92........."),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text("Mail us:"),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "yum@gmail.com",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
