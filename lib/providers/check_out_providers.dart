import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/model/delivery_address_model.dart';
import 'package:foodapp/model/review_cart_model.dart';
import 'package:location/location.dart';

class CheckoutProvider with ChangeNotifier {
  bool isloadding = false;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController alternateMobileNo = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController pincode = TextEditingController();
  late LocationData setLocation;

  void validator(context, myType) async {

    if (firstName.text.isEmpty) {
      Fluttertoast.showToast(msg: "firstname is empty");
    } else if (lastName.text.isEmpty) {
      Fluttertoast.showToast(msg: "lastname is empty");
    } else if (mobileNo.text.isEmpty) {
      Fluttertoast.showToast(msg: "mobileNo is empty");
    } else if (street.text.isEmpty) {
      Fluttertoast.showToast(msg: "street is empty");
    } else if (landmark.text.isEmpty) {
      Fluttertoast.showToast(msg: "landmark is empty");
    } else if (city.text.isEmpty) {
      Fluttertoast.showToast(msg: "city is empty");
    } else if (area.text.isEmpty) {
      Fluttertoast.showToast(msg: "area is empty");
    } else if (pincode.text.isEmpty) {
      Fluttertoast.showToast(msg: "pincode is empty");
    } else if (setLocation.longitude== null) {
      Fluttertoast.showToast(msg: "Location is empty");
    } else {
      isloadding = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("AddDeliverAddress")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        "firstname": firstName.text,
        "lastname": lastName.text,
        "mobileNo": mobileNo.text,
        "alternateMobileNo": alternateMobileNo.text,
        "street": street.text,
        "landmark": landmark.text,
        "city": city.text,
        "area": area.text,
        "pincode": pincode.text,
        "addressType": myType.toString(),
        "longitude": setLocation.longitude,
        "latitude": setLocation.latitude,
      }).then((value) async {
        isloadding = false;
        notifyListeners();
        await Fluttertoast.showToast(msg: "Your deliver address added Successfully!");
        Navigator.of(context).pop();
        notifyListeners();
      });
      notifyListeners();
    }
  }

  List<DeliveryAddressModel> deliveryAdressList = [];
  getDeliveryAddressData() async {
    List<DeliveryAddressModel> newList = [];

    DeliveryAddressModel deliveryAddressModel;
    DocumentSnapshot _db = await FirebaseFirestore.instance
        .collection("AddDeliverAddress")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (_db.exists) {
      deliveryAddressModel = DeliveryAddressModel(
        firstName: _db.get("firstname"),
        lastName: _db.get("lastname"),
        addressType: _db.get("addressType"),
        area: _db.get("area"),
        alternateMobileNo: _db.get("alternateMobileNo"),
        city: _db.get("city"),
        landMark: _db.get("landmark"),
        mobileNo: _db.get("mobileNo"),
        pinCode: _db.get("pincode"),
        street: _db.get("street"),
      );
      newList.add(deliveryAddressModel);
      notifyListeners();
    }

    deliveryAdressList = newList;
    notifyListeners();
  }

  List<DeliveryAddressModel> get getDeliveryAddressList {
    return deliveryAdressList;
  }

////// Order /////////

  addPlaceOderData({
    required List<ReviewCartModel> orderItemList,
    var subTotal,
    var address,
    var shipping,
  }) async {
    FirebaseFirestore.instance
        .collection("Order")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("MyOrders")
        .doc()
        .set(
      {
        "subTotal": "1234",
        "Shipping Charge": "",
        "Discount": "10",
        "orderItems": orderItemList
            .map((e) => {
          "orderTime": DateTime.now(),
          "orderImage": e.cartImage,
          "orderName": e.cartName,
          // "orderUnit": e.cartUnit,
          "orderPrice": e.cartPrice,
          "orderQuantity": e.cartQuantity
        })
            .toList(),
        "address": address
            .map((e) => {
                  "orderTime": DateTime.now(),
                  "orderImage": e.cartImage,
                  "orderName": e.cartName,
                  "orderUnit": e.cartUnit,
                  "orderPrice": e.cartPrice,
                  "orderQuantity": e.cartQuantity
                })
            .toList(),
      },
    );
  }
}
