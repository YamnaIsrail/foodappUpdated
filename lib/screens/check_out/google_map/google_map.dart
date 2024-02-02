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
  LatLng? _initialcameraposition; // Allow for null value initially
  late GoogleMapController controller;
  Location _location = Location();

  @override
  void initState() {
    super.initState();
    // Request location permissions if needed
    checkLocationPermissions();
  }

  Future<void> checkLocationPermissions() async {
    // Implement logic to request location permissions if needed
  }

  void _onMapCreated(GoogleMapController _cntrlr) {
    controller = _cntrlr;
    _location.onLocationChanged.listen((event) {
      // Ensure non-null latitude and longitude before creating LatLng
      if (event.latitude != null && event.longitude != null) {
        _initialcameraposition = LatLng(event.latitude!, event.longitude!);
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: _initialcameraposition ?? const LatLng(20.5937, 78.9629),
              zoom: 15,
            ),
          ),
        );
      } else {
        // Handle cases where latitude or longitude is null
        // You might display a message or use a default location
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _initialcameraposition ?? LatLng(20.5937, 78.9629), // Use default if null
                ),
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
              ),
              Positioned(
                bottom: 100, // Adjust button position as needed
                right: 100,
                child: MaterialButton(
                  onPressed: () async {
                    try {
                      final location = await _location.getLocation();
                      setState(() {
                        checkoutProvider.setLocation = location;
                      });
                      Navigator.of(context).pop();
                    } catch (error) {
                      // Handle location retrieval errors
                    }
                  },
                  color: primaryColor,
                  child: Text("Set your Location"),
                  shape: StadiumBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
