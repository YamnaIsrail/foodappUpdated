import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/config/colors.dart';
import 'package:foodapp/model/product_model.dart';
import 'package:foodapp/model/review_cart_model.dart';
import 'package:foodapp/providers/review_cart_provider.dart';
import 'package:foodapp/screens/check_out/delivery_details/delivery_details.dart';
import 'package:foodapp/widgets/single_item.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/simple_app_bar_widget.dart';

class ReviewCart extends StatefulWidget {
  @override
  _ReviewCartState createState() => _ReviewCartState();
}

class _ReviewCartState extends State<ReviewCart> {
  late ReviewCartProvider reviewCartProvider;

  void initState() {
    super.initState();
    reviewCartProvider = Provider.of<ReviewCartProvider>(context, listen: false);
    reviewCartProvider.getReviewCartData();
  }

  showAlertDialog(BuildContext context, ReviewCartModel delete) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        reviewCartProvider.reviewCartDataDelete(delete.cartId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("ReviewCart Product"),
      content: Text("Are you delete on ReviewCart Product?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    return Scaffold(
      bottomNavigationBar: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ListTile(
          title: Text("Total Amount"),
          subtitle: Text(
            "\$ ${reviewCartProvider.getTotalPrice()}",
            style: TextStyle(
              color: Colors.green[900],
            ),
          ),
          trailing: CustomButton(
              onpressed: () {
                if (reviewCartProvider.getReviewCartDataList.isEmpty) {
                  print("getReviewCartDataList.isEmpty");
                  Fluttertoast.showToast(msg: "No Cart Data Found");
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DeliveryDetails(),
                    ),
                  );
                }
              }
          ),
        ),
      ),
      appBar:  SimpleAppBar(title: "Review Cart"),
      body: reviewCartProvider.getReviewCartDataList.isEmpty
          ? Center(
        child: Text("NO DATA"),
      )
          : ListView.builder(
        itemCount: reviewCartProvider.getReviewCartDataList.length,
        itemBuilder: (context, index) {
          ReviewCartModel data =
          reviewCartProvider.getReviewCartDataList[index];
          return Column(
            children: [

              SizedBox(
                height: 10,
              ),
              SingleItem(
                isbool: true,
                //wishList: false,
                productImage: data.cartImage,
                productName: data.cartName,
                productPrice: data.cartPrice,
                productId: data.cartId,
                productQuantity: data.cartQuantity,
                //productUnit: data.cartUnit,
                onDelete: () {
                  showAlertDialog(context, data);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
