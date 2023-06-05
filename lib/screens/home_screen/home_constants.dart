// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../screen_constants.dart';
import 'package:joy_homes/theme.dart';
import 'home_locate.dart';
import 'home_details.dart';

class HomeDetailsScreen extends StatefulWidget {
  const HomeDetailsScreen({super.key});

  @override
  State<HomeDetailsScreen> createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
            leadingWidth1: 36,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.navigate_before_rounded,
                  color: AppColors.textColor,
                  size: 36,
                )),
            title: Text(
              'House Info',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            height: 60),
        body: const HouseInfoToggle());
  }
}

class HouseInfoToggle extends StatefulWidget {
  const HouseInfoToggle({super.key});

  @override
  _HouseInfoToggleState createState() => _HouseInfoToggleState();
}

class _HouseInfoToggleState extends State<HouseInfoToggle>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  bool isContainerVisible = true;

  @override
  void initState() {
    super.initState();
  }

  void _handleButtonClick(int index) {
    setState(() {
      if (selectedIndex != index) {
        selectedIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: OutlinedButton.icon(
                  onPressed: () {
                    _handleButtonClick(0);

                    // Handle onPressed event for outlined button
                  },
                  icon: const Icon(
                    Icons.info_outline,
                    color: AppColors.primary,
                    size: 20,
                  ), // Add desired icon
                  label: Text(
                    'Details',
                    style: TextStyle(
                        color: selectedIndex == 0
                            ? Colors.white
                            : AppColors.textColor,
                        fontSize: 16),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor:
                        selectedIndex == 0 ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: BorderSide(
                      color: selectedIndex == 0
                          ? AppColors.secondary
                          : AppColors.secondary,
                    ),
                    backgroundColor: selectedIndex == 0
                        ? AppColors.secondary
                        : Colors.transparent,
                    minimumSize: const Size(150, 45),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    _handleButtonClick(1);

                    // Handle onPressed event for filled button
                  },
                  icon: const Icon(
                    Icons.share_location,
                    size: 20,
                    color: AppColors.primary,
                  ), // Add desired icon
                  label: Text(
                    'Locate',
                    style: TextStyle(
                        fontSize: 16,
                        color: selectedIndex == 1
                            ? Colors.white
                            : AppColors.textColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: BorderSide(
                      color: selectedIndex == 1
                          ? AppColors.secondary
                          : AppColors.secondary,
                    ),
                    backgroundColor:
                        selectedIndex == 1 ? AppColors.secondary : Colors.white,
                    minimumSize: const Size(150, 45),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Stack(
              children: [
                selectedIndex == 0
                    ? const DetailsPage()
                    : const HomeLocateScreen()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
