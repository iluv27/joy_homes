import 'package:flutter/material.dart';
import 'package:joy_homes/screens/upload_screen/upload_constants.dart';
import 'package:joy_homes/theme.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:joy_homes/main.dart';
import 'nigeria_states.dart';

class UploadLocate extends StatelessWidget {
  const UploadLocate({super.key});

  @override
  Widget build(BuildContext context) {
    return const _MapScreen();
  }
}

class _MapScreen extends StatefulWidget {
  const _MapScreen();

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

  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController latitude1 = TextEditingController();
  TextEditingController longitude1 = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // THIS IS FOR THE STATES DROP DOWN
  String? selectedState;
  String? selectedLGA;

  void handleStateSelected(String state) {
    selectedState = state;
    print('Selected State: $state');
  }

  void handleLGASelected(String lga) {
    selectedLGA = lga;
    print('Selected LGA: $lga');
  }

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
                      textEditingController: address1,
                      onInputChanged: ((value) {
                        value = address1.text;
                      }),
                      innerText: 'House Location?',
                      validatorText: 'Please enter the address',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    _LocateDropdownBtn(
                      onStateSelected: handleStateSelected,
                      onLGASelected: handleLGASelected,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    BottomNavButton(
                      formKey: _formKey,
                      bottomFunctionality: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // Send data to the server
                        }
                        Navigator.push(context,
                            MaterialPageRoute(builder: (Context) {
                          return UploadLocate();
                        }));
                      },
                      buttonTitle: 'Locate House',
                      buttonIcon: Container(),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    InputField(
                      inputTitle: 'Address 2 (Optional)',
                      textEditingController: address2,
                      onInputChanged: ((value) {
                        value = address2.text;
                      }),
                      innerText: 'No 2, Bola Street, Wuse',
                      validatorText: 'Please enter the address',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: _ButtonCode(
                            buttonTitle: 'Longitude',
                            buttonHint: '102.30',
                            controller: longitude1,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: _ButtonCode(
                            buttonTitle: 'Latitude',
                            buttonHint: '203.45',
                            controller: latitude1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    BottomNavButton(
                      formKey: _formKey,
                      bottomFunctionality: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // Send data to the server
                        }

                        await Provider.of<HouseProvider>(context, listen: false)
                            .setLocationDetails(
                                address1: address1.text,
                                state: selectedState,
                                lga: selectedLGA,
                                address2: address2.text,
                                longitude: longitude1.text,
                                latitude: latitude1.text);

                        Navigator.push(context,
                            MaterialPageRoute(builder: (Context) {
                          return MainMenuScreen();
                        }));
                      },
                      buttonTitle: 'Upload',
                      buttonIcon: Container(),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// SIDE BY SIDE BUTTON CODE
class _ButtonCode extends StatefulWidget {
  _ButtonCode(
      {required this.buttonTitle,
      required this.buttonHint,
      required this.controller});

  final TextEditingController controller;
  final String buttonTitle;
  final String buttonHint;

  @override
  State<_ButtonCode> createState() => __ButtonCodeState();
}

class __ButtonCodeState extends State<_ButtonCode> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.buttonTitle,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        Container(
          height: 50,
          child: TextFormField(
            cursorColor: AppColors.secondary,
            cursorWidth: 1,
            controller: widget.controller,
            onChanged: (value) {
              widget.controller.text = value;
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: widget.buttonHint,
              hintStyle: TextStyle(color: AppColors.textColor.withOpacity(0.3)),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.primary.withOpacity(0.8),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.primary.withOpacity(0.3),
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.primary.withOpacity(0.3),
                ),
              ),
            ),
            style: TextStyle(
                fontSize: 16, color: AppColors.textColor, height: 1.3),
          ),
        ),
      ],
    );
  }
}

// DROPDOWN BUTTON CODE

class _LocateDropdownBtn extends StatefulWidget {
  const _LocateDropdownBtn(
      {required this.onStateSelected, required this.onLGASelected});
  final Function(String) onStateSelected;
  final Function(String) onLGASelected;

  @override
  State<_LocateDropdownBtn> createState() => __LocateDropdownBtnState();
}

String? selectedState;
String? selectedLGA;

List<DropdownMenuItem<String>> buildStateDropdown() {
  List<DropdownMenuItem<String>> items = [];
  for (String state in states) {
    items.add(
      DropdownMenuItem(
        value: state,
        child: Text(state),
      ),
    );
  }
  return items;
}

List<DropdownMenuItem<String>> buildLGADropdown() {
  List<DropdownMenuItem<String>> items = [];
  if (selectedState != null && lgasByState.containsKey(selectedState)) {
    List<String>? lgas = lgasByState[selectedState];
    for (String lga in lgas!) {
      items.add(
        DropdownMenuItem(
          value: lga,
          child: Text(lga),
        ),
      );
    }
  }
  return items;
}

class __LocateDropdownBtnState extends State<_LocateDropdownBtn> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'State',
                style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.primary,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButton(
                  value: selectedState,
                  underline: Container(),
                  isExpanded: true,
                  iconSize: 40,
                  iconEnabledColor: AppColors.textColor.withOpacity(0.5),
                  hint: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'FCT',
                      style: TextStyle(
                          color: AppColors.textColor.withOpacity(0.3),
                          fontSize: 16),
                    ),
                  ),
                  items: buildStateDropdown(),
                  onChanged: (value) {
                    setState(() {
                      selectedState = value;
                      selectedLGA =
                          null; // Reset selected LGA when state changes
                      widget.onStateSelected(
                          value!); // Call the callback function
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'LGA',
                style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.primary,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButton(
                  value: selectedLGA,
                  underline: Container(),
                  isExpanded: true,
                  iconSize: 42,
                  iconEnabledColor: AppColors.textColor.withOpacity(0.5),
                  hint: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Municipal Area',
                      style: TextStyle(
                          color: AppColors.textColor.withOpacity(0.3),
                          fontSize: 16),
                    ),
                  ),
                  items: buildLGADropdown(),
                  onChanged: (value) {
                    setState(() {
                      selectedLGA = value;
                      widget
                          .onLGASelected(value!); // Call the callback function
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
