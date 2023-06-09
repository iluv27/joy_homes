import 'package:flutter/material.dart';
import 'package:joy_homes/screens/upload_screen/upload_constants.dart';
import 'package:joy_homes/theme.dart';

class TermsOfServiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Terms and Conditions',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          showForwardIcon: selectedImages.isNotEmpty,
        ),
        body: TermsAndConditionsScreen());
  }
}

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to Joyhomes!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'By accessing or using our app, you signify that you have read, understood, and agree to be bound by the following terms and conditions:',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            '1. User Responsibilities',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '1.1 You are responsible for maintaining the confidentiality of any login information associated with your account.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            '1.2 You are responsible for all activities that occur under your account.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            '2. Privacy',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '2.1 We respect your privacy and handle your personal information in accordance with our Privacy Policy.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            '3. Contact Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '3.1 If you have any questions or concerns regarding these terms and conditions, please contact us at [Your contact email].',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            '4. Changes to the Terms and Conditions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '4.1 We reserve the right to modify or update these terms and conditions at any time without prior notice. Please review this page periodically to stay informed of any changes.',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            '1. Introduction',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Welcome to our home search app. By accessing or using our app, you agree to comply with and be bound by the following terms and conditions. If you do not agree to these terms and conditions, you should not use the app.',
          ),
          SizedBox(height: 16.0),
          Text(
            '2. App Usage',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'a. Our app allows users to search for homes and view agent/landlord contact information. Users may use this information to contact agents/landlords directly.',
          ),
          Text(
            'b. Users are solely responsible for their interactions with agents/landlords. We do not endorse or guarantee the accuracy of any information provided by agents/landlords.',
          ),
          SizedBox(height: 16.0),
          Text(
            '3. User Accounts',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'a. Users may sign up for an account to access additional features of the app.',
          ),
          Text(
            'b. Users are responsible for maintaining the confidentiality of their account credentials and are liable for any activities that occur under their account.',
          ),
          SizedBox(height: 16.0),
          Text(
            '4. Agent Uploads',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'a. Agents may upload property pictures to showcase their listings.',
          ),
          Text(
            'b. Agents are solely responsible for the content they upload and must ensure that they have the necessary rights and permissions to use and display the content.',
          ),
          SizedBox(height: 16.0),
          Text(
            '5. Disclaimer',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'a. The information provided on the app is for general informational purposes only and should not be considered as professional advice.',
          ),
          Text(
            'b. We do not warrant the accuracy, completeness, or reliability of any information on the app.',
          ),
          SizedBox(height: 16.0),
          Text(
            '6. Limitation of Liability',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'a. We shall not be liable for any indirect, incidental, special, consequential, or punitive damages, including but not limited to loss of profits, data, or use.',
          ),
          SizedBox(height: 16.0),
          Text(
            '7. Governing Law',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'These terms and conditions shall be governed by and construed in accordance with the laws of [your jurisdiction].',
          ),
          SizedBox(height: 16.0),
          Text(
            '8. Contact Us',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'If you have any questions or concerns regarding these terms and conditions, please contact us at [your contact information].',
          ),
        ],
      ),
    );
  }
}
