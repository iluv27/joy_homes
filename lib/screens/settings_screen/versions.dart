import 'package:flutter/material.dart';
import 'package:joy_homes/screens/upload_screen/upload_constants.dart';
import 'package:joy_homes/theme.dart';
import 'settings_constants.dart';

class VersionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFFFAFAFA),
        appBar: AppBarWidget2(
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.navigate_before_rounded,
                  color: AppColors.textColor,
                  size: 36,
                )),
          ),
          leadingWidth1: 40,
          title: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              'About Us',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          showForwardIcon: selectedImages.isNotEmpty,
        ),
        body: VersionandUpdatesScreen());
  }
}

class VersionandUpdatesScreen extends StatelessWidget {
  const VersionandUpdatesScreen({super.key});

  final String appVersion = '1.0.0';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/logo.png',
              scale: 5.5,
            ),
            SizedBox(height: 16),
            Text(
              'Version: $appVersion',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 24),
            body(
              'Welcome to JoyHomes - the app that helps you find your dream home. Whether you are looking to buy or rent, JoyHomes provides a convenient platform to search for available houses and connect with the agents associated with them.',
            ),
            SizedBox(height: 24),
            heading(
              'With JoyHomes, you can:',
            ),
            SizedBox(height: 16),
            BulletText(
              text:
                  'Browse through a wide selection of houses for sale or rent',
            ),
            SizedBox(height: 8),
            BulletText(
              text:
                  'View detailed information about each house, including photos, amenities, and contact information of the associated agent or landlord',
            ),
            SizedBox(height: 8),
            BulletText(
              text:
                  'Use the map feature to easily locate houses and get directions',
            ),
            SizedBox(height: 24),
            Text(
              'Stay tuned for future updates and new features!!',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
