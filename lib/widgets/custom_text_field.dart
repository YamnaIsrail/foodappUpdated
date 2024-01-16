import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  String labText;
  //TextInputType keyboardType;

  CustomTextField({
    required this.controller,
    required this.labText,
    //required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      //keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        hintText: labText,
      ),
    );
  }
}
