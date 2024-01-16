import 'package:flutter/material.dart';
import 'package:foodapp/config/colors.dart';

class SingleDeliveryItem extends StatelessWidget {
  final String title;
  final String address;
  final String number;
  final String addressType;

  const SingleDeliveryItem({
    required this.title,
    required this.address,
    required this.number,
    required this.addressType,
  });
  @override
  Widget build(BuildContext context) {

    return ListTile(
      title:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Container(
            width: 60,
            padding: EdgeInsets.all(1),
            height: 20,
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                addressType,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      leading: CircleAvatar(
        radius: 8,
        backgroundColor: primaryColor,


      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5,),
          Text(address),
          SizedBox(
            height: 5,
          ),
          Text(number),
          Divider(height: 35,)

        ],
      ),

    );

  }
}
