import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class UserModel {
  String userName;
  String userEmail;
  String userUid;
  String userImage;
  String status;

UserModel({
  required this.userName,
  required this.userEmail,
  required this.userUid,
  required this.userImage,
  required this.status

});

}
