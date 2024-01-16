import 'package:flutter/material.dart';
import 'package:foodapp/config/colors.dart';

class categories extends StatefulWidget {
  const categories({super.key});

  @override
  State<categories> createState() => _categoriesState();
}

class _categoriesState extends State<categories> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xff33536f),
              backgroundImage: AssetImage('assets/images/burger.png')
          ),

          CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xff33536f),
              backgroundImage: AssetImage('assets/images/img2.png')
          ),
          CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xff33536f),
              backgroundImage: AssetImage('assets/images/pizza.jpg')
          ),

          CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xff33536f),
              backgroundImage: AssetImage('assets/images/food.jpg')
          ),
          CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xff33536f),
              backgroundImage: AssetImage('assets/images/roll.png')
          ),

        ],
      ),
    );
  }
}
