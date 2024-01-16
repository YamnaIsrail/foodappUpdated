import 'package:flutter/material.dart';
import 'package:foodapp/config/colors.dart';
import 'package:foodapp/model/user_model.dart';
import 'package:foodapp/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/simple_app_bar_widget.dart';
import '../home_screen/drawer.dart';

class MyProfile extends StatefulWidget {
  final UserProvider userProvider;

  MyProfile({required this.userProvider});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  Widget listTile({required IconData icon, required String title}) {
    return Column(
      children: [
        Divider(height: 1,),
        ListTile(
          trailing: Icon(Icons.add),
          leading: Icon(icon),
          title: Text(title),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
// Use Provider to listen for changes in the UserProvider
    var userData = widget.userProvider.currentUserData;

    return Scaffold(
      appBar: SimpleAppBar(title: "My profile",),
      drawer: drawerSide(userProvider: widget.userProvider,),
      body: Container(
        decoration: BoxDecoration(
            gradient: primaryGradient
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 80,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    margin: EdgeInsets.only(right: 37, ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              //width: 200,
                              height: 50,
                             // padding: EdgeInsets.only(left: 50),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(userData?.userName ?? "Guest",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: text2Color,
                                          ),
                                        ),
                                        Text(userData?.userEmail ?? "Guest@email.com"),
                                      ],
                                    ),
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Color(0xff73be7a),
                                      child: CircleAvatar(
                                        radius: 12,
                                        child: Icon(Icons.edit, color: Color(0xff73be7a)),
                                      ),
                                    ),
                                  ],
                              ),
                            ),
                          ],
                        ),
                        listTile(
                          icon: Icons.shop_2_outlined,
                          title: "My Orders",
                        ),
                        listTile(
                          icon: Icons.location_pin,
                          title: "My Delivery Address",
                        ),
                        listTile(
                          icon:Icons.person,
                          title: "Refer a Friend",
                        ),
                        listTile(
                          icon:Icons.file_copy_outlined,
                          title: "Terms and Conditions ",
                        ),
                        listTile(
                          icon:Icons.policy_outlined,
                          title: "Privacy Policy",
                        ),
                        listTile(
                          icon:Icons.add_chart,
                          title: "About",
                        ),
                        listTile(
                          icon:Icons.exit_to_app_sharp,
                          title: "Logout",
                        ),

                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 30),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xff73be7a),
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Color(0xff95bf5e),
                  backgroundImage: NetworkImage(
                      userData?.userImage ??
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUA9IuDIQlQ4gfQAEBvKOLBgBUHtEKPqWirw&usqp=CAU"
                  ),
                ),
              ),
            )
          ],
        ),
      ),

    );
  }
}