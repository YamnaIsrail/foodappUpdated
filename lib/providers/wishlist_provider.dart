import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodapp/model/product_model.dart';
import 'package:provider/provider.dart';

class WishListProvider with ChangeNotifier{
  Future<void> addWishListData({
    required String wishListId,
    String? wishListImage,
    String? wishListName,
    int? wishListPrice,
    int? wishListQuantity,
  }) async {
    // Use the user ID directly to avoid potential null errors
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      await FirebaseFirestore.instance
          .collection('WishList')
          .doc(userId)
          .collection("YourWishList")
          .doc(wishListId)
          .set({
        "wishListId": wishListId,
        "wishListImage": wishListImage,
        "wishListName": wishListName,
        "wishListPrice": wishListPrice,
        "wishListQuantity": wishListQuantity,
        "wishlist": true,

      });
    }
  }



///// Get WishList Data ///////
  List<ProductModel> wishList = [];

  getWishtListData() {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourWishList")
        .snapshots()
        .listen((event) {
      // Handle data changes or initial data retrieval here
      List<ProductModel> newList = [];
      event.docs.forEach((element) {
        ProductModel productModel = ProductModel(
          productId: element.get("wishListId"),
          productImage: element.get("wishListImage"),
          productName: element.get("wishListName"),
          productPrice: element.get("wishListPrice"),
          productQuantity: element.get("wishListQuantity"),

        );
        newList.add(productModel);
        print("\$${productModel}");
      });
      wishList = newList;
      notifyListeners();
    }, onError: (error) {
      print("Error fetching data: $error");
    });
  }


  List<ProductModel> get getWishList {
    return wishList;
  }

////////// Delete WishList /////
  deleteWishtList(wishListId){
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourWishList").doc(wishListId).delete();
  }


}