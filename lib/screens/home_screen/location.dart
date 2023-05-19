// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
const apiKEY = 'c6f3a123d26a91e9b39df80672d08ebe';

class Location extends StatefulWidget {
  Location({super.key});

  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    // ignore: unused_local_variable
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

Future<dynamic> getLocationWeather() async {
  Location location = Location();
  await location.getCurrentLocation();

  location.latitude;
  location.longitude;

  NetworkHelper networkHelper = NetworkHelper(
      '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKEY&units=metric');

  var weatherData = await networkHelper.getData();

  return weatherData;
}

class NetworkHelper {
  final String urL;
  NetworkHelper(this.urL);

  Future getData() async {
    var url = urL;
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
