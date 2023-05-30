import 'package:flutter/material.dart';
import 'package:joy_homes/screens/upload_screen/upload_constants.dart';
import 'package:joy_homes/theme.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class UploadLocate extends StatelessWidget {
  const UploadLocate({super.key});

  @override
  Widget build(BuildContext context) {
    return const _MapScreen();
  }
}

class _MapScreen extends StatefulWidget {
  const _MapScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<_MapScreen> {
  final LatLng brownLocation =
      LatLng(37.7749, -122.4194); // Brown location coordinates

  LatLng? userLocation;
  double distance = 0.0;

  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
      latitude = position.latitude;
      longitude = position.longitude;
      // ignore: empty_catches
    } catch (e) {}
    setState(() {
      userLocation = LatLng(latitude!, longitude!);
      calculateDistance();
    });
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void calculateDistance() {
    if (userLocation != null) {
      const Distance distanceCalculator = Distance();
      double calculatedDistance = distanceCalculator(
        LatLng(userLocation!.latitude, userLocation!.longitude),
        LatLng(brownLocation.latitude, brownLocation.longitude),
      );
      setState(() {
        distance = calculatedDistance;
      });
    }
  }

  TextEditingController address = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 40,
        leading: IconButton(
            padding: EdgeInsets.only(left: 20),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.textColor,
            )),
        title: Text('Go back'),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          Container(
            height: 300,
            child: FlutterMap(
              options: MapOptions(
                center: brownLocation,
                zoom: 13.0,
              ),
              //**** */
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 40.0,
                      height: 40.0,
                      point: brownLocation,
                      builder: (ctx) => Container(
                        child: const Icon(
                          Icons.location_on,
                          color: AppColors.contactColor,
                          size: 40,
                        ),
                      ),
                    ),
                    if (userLocation != null)
                      Marker(
                        width: 40.0,
                        height: 40.0,
                        point: userLocation!,
                        builder: (ctx) => Container(
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputField(
                        inputTitle: 'Address 1',
                        textEditingController: address,
                        onInputChanged: ((value) {
                          value = address.text;
                        }),
                        innerText: 'House Location?',
                        validatorText: 'Please enter the address',
                      ),
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
