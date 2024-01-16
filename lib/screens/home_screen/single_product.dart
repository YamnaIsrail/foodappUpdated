import 'package:flutter/material.dart';
import 'package:foodapp/config/colors.dart';
import 'package:foodapp/widgets/count.dart';
import '../product_overview/product_overview.dart';

class singleProduct extends StatelessWidget {
  final String productName;
  final String productImage;
  final int productPrice;
  final String productdescription;
  final String productId;
  int productQuantity;

  singleProduct({
    required this.productName,
    required this.productQuantity,
    required this.productdescription,
    required this.productImage,
    required this.productPrice,
    required this.productId,
    required Null Function() onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 240,
      width: 165,
      decoration: BoxDecoration(
        color: Color(0xfffcfcfc),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductOverview(
                      productId: productId,
                      productQuantity: productQuantity,
                      productImage: productImage,
                      productName: productName,
                      productPrice: productPrice
                    ),
                  ),
                );
              },
              child: CircleAvatar(radius: 130,backgroundColor: Color(0xff33536f),
                foregroundImage: NetworkImage(productImage ),
          //        child: Image.network(productImage, fit: BoxFit.cover, )
                ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
              //  shrinkWrap: true, // Ensure the ListView only takes the required space
                children: [
                  Column(
                    children: [
                      Text(
                        productName,
                        style: const TextStyle(
                          color: Color(0xff3f3e3e),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        productdescription,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                     // SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 18,
                              decoration: BoxDecoration(
                                border: Border.all(color: buttonOutline),
                                color: buttonColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        ' Grams',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      size: 15,
                                      color: iconcolor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 3),
                          Expanded(
                            child: Count(
                              count_design: true,
                                productPrice : productPrice ,
                                productName: productName,
                                productImage: productImage,
                                productId: productId,
                                //productQuantity: 1,

                            ),
                          )

                        ],
                      ),
                    ],
                  ),
                ],
              )

            ),
          ),
        ],
      ),
    );
  }
}
