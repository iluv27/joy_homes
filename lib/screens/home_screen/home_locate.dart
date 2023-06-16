// ignore_for_file: unused_import, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import '../../profile/profile_constants.dart';
import 'package:joy_homes/theme.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class HomeLocateScreen extends StatelessWidget {
  const HomeLocateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MapScreen();
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 450,
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.only(top: 20),
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xffD9D9D9).withOpacity(0.3),
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HomeLocateIconContainer(
                    iconData: Icons.map_rounded,
                    locateText: 'Map',
                  ),
                  HomeLocateIconContainer(
                    iconData: Icons.all_inclusive,
                    locateText: 'Overview',
                  ),
                  HomeLocateIconContainer(
                    iconData: Icons.directions,
                    locateText: 'Direction',
                  ),
                  HomeLocateIconContainer(
                    iconData: Icons.share_location,
                    locateText: 'Share',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            height: 200,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.secondary.withOpacity(0.2),
                  width: 1.0,
                ),
                bottom: BorderSide(
                  color: AppColors.secondary.withOpacity(0.2),
                  width: 1.0,
                ),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Related Apartments',
                  style: TextStyle(
                      fontSize: 20,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getLocation,
        child: const Icon(Icons.location_searching),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              'Distance to Brown Location: ${distance.toStringAsFixed(2)} meters'),
        ),
      ),
    );
  }
}

class HomeLocateIconContainer extends StatelessWidget {
  const HomeLocateIconContainer(
      {super.key, required this.iconData, required this.locateText});

  final IconData iconData;
  final String locateText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Icon(iconData, color: AppColors.secondary, size: 25),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          locateText,
          style: const TextStyle(color: AppColors.textColor, fontSize: 14),
        )
      ],
    );
  }
}
