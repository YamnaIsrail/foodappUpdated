
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodapp/model/delivery_address_model.dart';
import 'package:foodapp/model/review_cart_model.dart';
import 'package:foodapp/widgets/simple_app_bar_widget.dart';
import 'package:provider/provider.dart';

import '../../../config/colors.dart';
import '../../../providers/review_cart_provider.dart';
import '../../home_screen/homescreen.dart';


class home_pay extends StatefulWidget {
  final double total;
  final DeliveryAddressModel deliveryAddress;
  final List<ReviewCartModel> products;

  home_pay({
    required this.total,
    required this.deliveryAddress,
    required this.products,
  });

  @override
  State<home_pay> createState() => _home_payState();
}

class _home_payState extends State<home_pay> {

  void clearReviewCartt(  List<ReviewCartModel> products) {
    print('Before clearing: ${products.length}');
    products.clear();
    print('After clearing: ${products.length}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "Home Pay",),
      body: Center(
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xffa9bf4e)),
          ),
          onPressed: () {
            _placeOrder(context);
          },
          child: Text('Place Order'),
        ),
      ),
    );
  }

  void _placeOrder(BuildContext context) async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId != null) {

        Map<String, dynamic> orderData = {
          'totalAmount': widget.total,
          'userDetails': {
            'userName': widget.deliveryAddress.firstName + ' ' + widget.deliveryAddress.lastName,
            'mobileNo': widget.deliveryAddress.mobileNo,
          },
          'deliveryAddress': {
            'area': widget.deliveryAddress.area,
            'street': widget.deliveryAddress.street,
            'pinCode': widget.deliveryAddress.pinCode,
          },
          'products': widget.products.map((product) => {
            'cartName': product.cartName,
            'cartPrice': product.cartPrice,
            'cartQuantity': product.cartQuantity,
          }).toList(),
          'timestamp': FieldValue.serverTimestamp(),
        };

        await FirebaseFirestore.instance
            .collection('Orders')
            .doc(userId)
            .collection("UserOrders")
            .add(orderData);


        Provider.of<ReviewCartProvider>(context, listen: true).clearReviewCartt();

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Order Placed Successfully!'),
              content: Text('Thank you for your order.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('Error placing order: $error');
    }
  }
}


