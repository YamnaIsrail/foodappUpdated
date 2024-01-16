import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:food_app/models/user_model.dart';
import 'package:foodapp/model/user_model.dart';

class UserProvider with ChangeNotifier {
  void addUserData({
    required User currentUser,
    required String userName,
    required String userImage,
    required String userEmail,
  }) async {
    await FirebaseFirestore.instance
        .collection("usersData")
        .doc(currentUser.uid)
        .set(
      {
        "userName": userName,
        "userEmail": userEmail,
        "userImage": userImage,
        "userUid": currentUser.uid,
        "status": "approved"
      },
    );
  }

  //UserModel currentData ;

  late UserModel currentUserData;

  Future<void> getUserData() async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('usersData')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();

      if (userSnapshot.exists) {
        dynamic userData = userSnapshot.data();

        if (userData != null && userData["status"] == "approved")
          {
          Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;

          String userEmail = data["userEmail"] ?? "guest001@email.com";
          String userImage = data["userImage"] ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUA9IuDIQlQ4gfQAEBvKOLBgBUHtEKPqWirw&usqp=CAU";

          String userName = data["userName"] ?? "Guest";
          String userUid = data["userUid"] ?? "guest001";

          currentUserData = UserModel(
              userEmail: userEmail,
              userImage: userImage,
              userName: userName,
              userUid: userUid,
              status: "approved"
          );

          notifyListeners();
        } else{
          Fluttertoast.showToast(msg: "Admin has blocked your account. \n Mail here: yum@foodapp.com ");

        }
      }
        else {

          //Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;

          String userEmail =  "guest_user@email.com";
          String userImage = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUA9IuDIQlQ4gfQAEBvKOLBgBUHtEKPqWirw&usqp=CAU";

          String userName =  "Guest";
          String userUid =  "guest001";

          currentUserData = UserModel(
            userEmail: userEmail,
            userImage: userImage,
            userName: userName,
            userUid: userUid,
            status: "approved"
          );

          notifyListeners();

        // Handle the case where the document does not exist
        print("Document does not exist for the current user.");
      }
    } catch (e) {
      // Handle errors
      print("Error getting user data: $e");
    }
  }

  // UserModel get currentUserData {
  //   return currentData;
  // }
}



