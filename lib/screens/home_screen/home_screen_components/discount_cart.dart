import 'package:flutter/material.dart';
import '../../../config/size_config.dart';

class DiscountCard extends StatefulWidget {
  const DiscountCard({Key? key}) : super(key: key);

  @override
  _DiscountCardState createState() => _DiscountCardState();
}

class _DiscountCardState extends State<DiscountCard> {
  final List<String> imageList = [
    "assets/images/discount2.png",
    "assets/images/discount1.png",
    "assets/images/discount3.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 10),
      child: SizedBox(
        height: 180.0,
        child: PageView.builder(
          itemCount: imageList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  imageList[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          pageSnapping: false,
          physics: BouncingScrollPhysics(),
          controller: PageController(
            viewportFraction: 0.85, // Adjust this value for the visible portion
            initialPage: 1, // Display the middle image initially
          ),
        ),
      ),
    );
  }
}
