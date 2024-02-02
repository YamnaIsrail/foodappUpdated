import 'package:flutter/material.dart';
import 'package:foodapp/config/colors.dart';
import 'package:foodapp/providers/check_out_providers.dart';
import 'package:foodapp/screens/check_out/delivery_details/delivery_details.dart';
import 'package:foodapp/widgets/custom_text_field.dart';
import 'package:foodapp/widgets/simple_app_bar_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../google_map/google_map.dart';

class AddDeliveryAddress extends StatefulWidget {
  const AddDeliveryAddress({Key? key}) : super(key: key);

  @override
  State<AddDeliveryAddress> createState() => _AddDeliveryAddressState();
}

enum AddressType { Home, Work, Other }

class _AddDeliveryAddressState extends State<AddDeliveryAddress> {
  AddressType myType = AddressType.Home;
  // Remove the duplicate declaration of setLocation
  late String setLocationText = ""; // Change variable name to avoid conflicts
  LatLng setLocation = LatLng(37.7749, -122.4194);

  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);

    return Scaffold(
      appBar: SimpleAppBar(title: "Add Delivery Address"),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: 160,
        height: 48,
        decoration: BoxDecoration(
            gradient: primaryGradient,
            borderRadius: BorderRadius.circular(30)),
        child: MaterialButton(
          onPressed: () {
            checkoutProvider.validator(context, myType);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeliveryDetails()));
          },
          child: Text("Add Address", style: TextStyle(color: text2Color)),
          
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
              onTap: () async {
                // Call a function to add the address
                checkoutProvider.validator(context, myType);

                // Navigate to the map screen and receive the selected location
                LatLng selectedLocation = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CustomGoogleMap()),
                );

                if (selectedLocation != null) {
                  // Update the location when the user selects a location on the map
                  setState(() {
                    setLocation = selectedLocation;
                    setLocationText = "Location already added";
                  });
                }
              },
              child: Container(
                height: 47,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(setLocationText),
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
              },
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
              },
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
