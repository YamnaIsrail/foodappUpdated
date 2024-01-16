import 'package:flutter/material.dart';
import 'package:foodapp/config/colors.dart';
import 'package:foodapp/model/product_model.dart';
import 'package:foodapp/providers/wishlist_provider.dart';
import 'package:foodapp/widgets/single_item.dart';
import 'package:provider/provider.dart';

import '../../widgets/simple_app_bar_widget.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  late WishListProvider wishListProvider;

  void initState() {
    super.initState();
    wishListProvider = Provider.of<WishListProvider>(context, listen: false);
    wishListProvider.getWishtListData();
  }

  showAlertDialog(BuildContext context, ProductModel delete) {
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
        wishListProvider.deleteWishtList(delete.productId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("WishList Product"),
      content: Text("Are you delete on wishList Product?"),
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
    wishListProvider = Provider.of(context);
    wishListProvider.getWishtListData();
    return Scaffold(
      appBar: SimpleAppBar(title: "Favorites"),
      body: wishListProvider.getWishList.isEmpty
          ? Center(
        child: Text("Your wishlist is empty."),
      )
          : ListView.builder(
        itemCount: wishListProvider.getWishList.length,
        itemBuilder: (context, index) {
          ProductModel data = wishListProvider.getWishList[index];
          return Column(
            children: [
              SizedBox(
                height: 10,
              ),
              SingleItem(
                isbool: true,
                productImage: data.productImage,
                productName: data.productName,
                productPrice: data.productPrice,
                productId: data.productId,
                productQuantity: data.productQuantity,
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
