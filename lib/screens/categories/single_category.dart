import 'package:flutter/material.dart';

class category extends StatefulWidget {
  //final String image;
  const category({super.key, });

  @override
  State<category> createState() => _categoryState();
}

class _categoryState extends State<category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CircleAvatar(
          radius: 45,
          backgroundColor: Colors.blue,
          //backgroundImage: AssetImage(widget.image),

        ),

    );
  }
}
