import 'package:flutter/material.dart';
import 'package:foodapp/config/colors.dart';
import 'package:foodapp/providers/check_out_providers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMap();
}

class _CustomGoogleMap extends State<CustomGoogleMap> {

  LatLng _initialcameraposition= LatLng(20.5937, 78.9629);
  late GoogleMapController controller;
  Location _location = Location();

  void _onMapCreated(GoogleMapController _cntrlr){
    controller= _cntrlr;
    _location.onLocationChanged.listen((
        event) {
      double? eventLatitude = event.latitude;
      double? eventLongitude = event.longitude;

      controller.animateCamera(
          CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(eventLatitude!, eventLongitude!),
            zoom: 15
          )
          )
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Location"),
      // ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          child: Stack(
            children: [
              GoogleMap(initialCameraPosition: CameraPosition(
                target: _initialcameraposition,
              ),
               // mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
              ),
              Positioned(
                bottom: 0,
                  left: 0,
                  right: 0,
                  top: 0,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    margin: EdgeInsets.only(right: 60, left: 10, bottom: 40, top: 40),
                    child: MaterialButton(
                      onPressed: () async {
                        await _location.getLocation().then((value) {
                          setState(() {
                            checkoutProvider.setLocation= value;
                          });
                        });
                        Navigator.of(context).pop();

                      },
                      color: primaryColor,
                      child: Text("Set your Location"),
                      shape: StadiumBorder(),
                    ),


                  )
              )

            ],
          ),
        ),
      ),

    );
  }
}
