import 'package:flutter/material.dart';
import 'package:joy_homes/screens/upload_screen/upload_constants.dart';
import 'package:joy_homes/theme.dart';
import 'settings_constants.dart';

class TermsOfServiceScreen extends StatelessWidget {
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
      padding: EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Joyhomes!',
              style: TextStyle(
                  fontSize: 18,
                  color: const Color.fromARGB(255, 109, 109, 109)),
            ),
            SizedBox(height: 24),
            body(
              'By accessing or using our app, you signify that you have read, understood, and agree to be bound by the following terms and conditions:',
            ),
            SizedBox(height: 24),
            heading('1. User Responsibilities'),
            SizedBox(height: 8),
            body(
              '1.1 You are responsible for maintaining the confidentiality of any login information associated with your account.',
            ),
            SizedBox(height: 8),
            body(
              '1.2 You are responsible for all activities that occur under your account.',
            ),
            SizedBox(height: 24),
            heading('2. Privacy'),
            SizedBox(height: 8),
            body(
              '2.1 We respect your privacy and handle your personal information in accordance with our Privacy Policy.',
            ),
            SizedBox(height: 24),
            heading('3. App Usage'),
            SizedBox(height: 8.0),
            body(
              '3.1. Our app allows users to search for homes and view agent/landlord contact information. Users may use this information to contact agents/landlords directly.',
            ),
            SizedBox(height: 8.0),
            body(
              '3.2. Users are solely responsible for their interactions with agents/landlords. We do not endorse or guarantee the accuracy of any information provided by agents/landlords.',
            ),
            SizedBox(height: 16.0),
            heading('4. User Accounts'),
            SizedBox(height: 8.0),
            body(
              '4.1. Users may sign up for an account to access additional features of the app.',
            ),
            SizedBox(height: 8.0),
            body(
              '4.2. Users are responsible for maintaining the confidentiality of their account credentials and are liable for any activities that occur under their account.',
            ),
            SizedBox(height: 16.0),
            heading('5. Agent Uploads'),
            SizedBox(height: 8.0),
            body(
              '5.1. Agents may upload property pictures to showcase their listings.',
            ),
            SizedBox(height: 8.0),
            body(
              '5.2. Agents are solely responsible for the content they upload and must ensure that they have the necessary rights and permissions to use and display the content.',
            ),
            SizedBox(height: 16.0),
            heading('6. Disclaimer'),
            SizedBox(height: 8.0),
            body(
              '6.1. The information provided on the app is for general informational purposes only and should not be considered as professional advice.',
            ),
            SizedBox(height: 8.0),
            body(
              '6.2. We do not warrant the accuracy, completeness, or reliability of any information on the app.',
            ),
            SizedBox(height: 16.0),
            heading('7. Limitation of Liability'),
            SizedBox(height: 8.0),
            body(
              'We shall not be liable for any indirect, incidental, special, consequential, or punitive damages, including but not limited to loss of profits, data, or use.',
            ),
            SizedBox(height: 16.0),
            heading('8. Governing Law'),
            SizedBox(height: 8.0),
            body(
              'These terms and conditions shall be governed by and construed in accordance with the laws of [your jurisdiction].',
            ),
            SizedBox(height: 16.0),
            heading('9. Contact Information'),
            SizedBox(height: 8.0),
            body(
              'If you have any questions or concerns regarding these terms and conditions, please contact us at admin.joyhomes.com.',
            ),
            SizedBox(height: 16.0),
            heading('10. Changes to the Terms and Conditions'),
            SizedBox(height: 8),
            body(
              'We reserve the right to modify or update these terms and conditions at any time without prior notice. Please review this page periodically to stay informed of any changes.',
            ),
          ],
        ),
      ),
    );
  }
}
