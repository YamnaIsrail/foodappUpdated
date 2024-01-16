import 'package:flutter/material.dart';
import 'package:foodapp/config/colors.dart';
import 'package:foodapp/model/delivery_address_model.dart';
import 'package:foodapp/providers/check_out_providers.dart';
import 'package:foodapp/screens/check_out/add_delivery_address/add_delivery_address.dart';
import 'package:foodapp/screens/check_out/delivery_details/single_delivery.dart';
import 'package:foodapp/screens/check_out/payment_summary/payment_summary.dart';
import 'package:provider/provider.dart';

class DeliveryDetails extends StatefulWidget {
  const DeliveryDetails({super.key});

  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  late DeliveryAddressModel value;

  @override
  Widget build(BuildContext context) {

    CheckoutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.getDeliveryAddressData();

    return  Scaffold(
      appBar: AppBar(
        title: Text(
          "Delivery Details",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddDeliveryAddress()),
          );
        },
        tooltip: "Add a new Address",
      ),

      bottomNavigationBar: Container(
        height: 60,
        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: MaterialButton(
          child:  deliveryAddressProvider.getDeliveryAddressList.isEmpty
              ? Text("Add new Address", style: TextStyle(color: Colors.white))
              : Text("Payment Summary", style: TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.of(context).push(
                deliveryAddressProvider.getDeliveryAddressList.isEmpty
                    ? MaterialPageRoute(builder: (context) => AddDeliveryAddress())
                    : MaterialPageRoute(builder: (context) => PaymentSummary(deliverAddressList: value,))
              ,
            );
          },
          color: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),

      body:  ListView(
        children: [
          ListTile(
            title: Text("Deliver To"),
          ),
          Divider(
            height: 1,
          ),
          deliveryAddressProvider.getDeliveryAddressList.isEmpty
              ? Center(
            child: Container(
              child: Center(
                child: Text("No Data"),
              ),
            ),
          )
              : Column(
            children: deliveryAddressProvider.getDeliveryAddressList
                .map<Widget>((e) {
              setState(() {
                value  = e;
              });
              return SingleDeliveryItem(
                address: "area, ${e.area}, street, ${e.street}, pincode ${e.pinCode}",
                title: "${e.firstName} ${e.lastName}",
                number: e.mobileNo,
                addressType: e.addressType == "AddressTypes.Home"
                    ? "Home"
                    : e.addressType == "AddressTypes.Other"
                    ? "Other"
                    : "Work",
              );
            }).toList(),
          )
        ],
      ),


    );
  }
}
