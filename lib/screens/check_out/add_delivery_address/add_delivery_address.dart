import 'package:flutter/material.dart';
import 'package:foodapp/config/colors.dart';
import 'package:foodapp/providers/check_out_providers.dart';
import 'package:foodapp/screens/check_out/delivery_details/delivery_details.dart';
import 'package:foodapp/screens/check_out/google_map/google_map.dart';
import 'package:foodapp/widgets/custom_text_field.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class AddDeliveryAddress extends StatefulWidget {
  const AddDeliveryAddress({super.key});

  @override
  State<AddDeliveryAddress> createState() => _AddDeliveryAddressState();
}

enum AddressType { Home, Work, Other }

class _AddDeliveryAddressState extends State<AddDeliveryAddress> {
  AddressType myType = AddressType.Home;
  //late String setLocation;
  LatLng setLocation = LatLng(37.7749, -122.4194);

  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Delivery Address"),
        backgroundColor: primaryColor,
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: 160,
        height: 48,
        child: MaterialButton(
          onPressed: () {
            checkoutProvider.validator(context, myType);
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DeliveryDetails()));

          },
          child: Text("Add Address", style: TextStyle(color: text2Color)),
          color: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            CustomTextField(
              controller: checkoutProvider.firstName,
              labText: "First Name",
            ),
            CustomTextField(
              controller: checkoutProvider.lastName,
              labText: "Last Name",
            ),
            CustomTextField(
              controller: checkoutProvider.mobileNo,
              labText: "Mobile No",
            ),
            CustomTextField(
              controller: checkoutProvider.alternateMobileNo,
              labText: "Alternative Mobile No",
            ),

            CustomTextField(
              controller: checkoutProvider.street,
              labText: "Street",
            ),
            CustomTextField(
              controller: checkoutProvider.landmark,
              labText: "Land Market",
            ),
            CustomTextField(
              controller: checkoutProvider.city,
              labText: "City",
            ),
            CustomTextField(
              controller: checkoutProvider.area,
              labText: "Area",
            ),
            CustomTextField(
              controller: checkoutProvider.pincode,
              labText: "Pincode",
            ),
            InkWell(
              onTap: () {
                // Call a function to add the address
                checkoutProvider.validator(context, myType);

                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CustomGoogleMap()));
              },
              child: Container(
                height: 47,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    checkoutProvider.setLocation== null ?Text("Set Location") : Text("Location already added") ,

                  ],
                ),
              ),
            ),

            Divider(color: Colors.black),
            ListTile(title: Text("Address type")),
            RadioListTile(
              value: AddressType.Home,
              title: Text("Home"),
              secondary: Icon(Icons.home, color: primaryColor),
              groupValue: myType,
                onChanged: (AddressType? value) {
                  if (value != null) {
                    setState(() {
                      myType = value;
                    });
                  }
                }
            ),
            RadioListTile(
              value: AddressType.Work,
              title: Text("Work"),
              secondary: Icon(Icons.work, color: primaryColor),
              groupValue: myType,
              onChanged: (AddressType? value) {
                if (value != null) {
                  setState(() {
                    myType = value;
                  });
                }
              }
            ),
            RadioListTile(
              value: AddressType.Other,
              title: Text("Other"),
              secondary: Icon(Icons.devices_other, color: primaryColor),
              groupValue: myType,
                onChanged: (AddressType? value) {
                  if (value != null) {
                    setState(() {
                      myType = value;
                    });
                  }
                }
            ),
          ],
        ),
      ),
    );
  }
}
