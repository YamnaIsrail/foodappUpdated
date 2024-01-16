import 'package:flutter/material.dart';

import '../config/colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onpressed;

  const CustomButton({Key? key, required this.onpressed}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 160,
      decoration: BoxDecoration(
        gradient: primaryGradient,
        borderRadius: BorderRadius.circular(
          30,
        ),
      ),
      child: MaterialButton(
        child: Text("Submit"),
        //  color: primaryColor,
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30,),),

        onPressed: onpressed,
      )
    );
  }
}
