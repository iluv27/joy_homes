import 'package:flutter/material.dart';
import 'package:joy_homes/screens/upload_screen/upload_constants.dart';
import 'package:joy_homes/theme.dart';
import 'settings_constants.dart';

class PrivacyScreen extends StatelessWidget {
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
              'Privacy Policy',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          showForwardIcon: selectedImages.isNotEmpty,
        ),
        body: PrivacyPolicyScreen());
  }
}

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
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
            heading('Privacy Policy'),
            SizedBox(height: 16),
            Text(
              'Last Updated: June 1, 2023',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 24),
            heading('1. Introduction'),
            SizedBox(height: 8),
            body(
              'We respect the privacy of our users and are committed to protecting their personal information. This Privacy Policy outlines how we collect, use, and disclose user information when they use our app.',
            ),
            SizedBox(height: 24),
            heading('2. Information We Collect'),
            SizedBox(height: 8),
            body(
              'When you use our app, we may collect the following information:',
            ),
            SizedBox(height: 8),
            BulletText(
              text:
                  'Personal information such as name, email address, and phone number.',
            ),
            BulletText(
              text: 'Location information when you use the app\'s map feature.',
            ),
            BulletText(
              text:
                  'Information about the houses you view and interact with on the app.',
            ),
            SizedBox(height: 24),
            heading('3. How We Use Your Information'),
            SizedBox(height: 8),
            body(
              'We may use the collected information for the following purposes:',
            ),
            SizedBox(height: 8),
            BulletText(
              text:
                  'To provide and improve our services, including personalized recommendations and customer support.',
            ),
            BulletText(
              text:
                  'To communicate with you and send you important updates and notifications.',
            ),
            BulletText(
              text:
                  'To analyze usage trends and enhance the functionality of the app.',
            ),
            SizedBox(height: 24),
            heading('4. Information Sharing and Disclosure'),
            SizedBox(height: 8),
            body(
              'We may share your information with third parties in the following circumstances:',
            ),
            SizedBox(height: 8),
            BulletText(
              text:
                  'With the agents or landlords associated with the houses you show interest in, for the purpose of facilitating communication and arranging property viewings.',
            ),
            BulletText(
              text:
                  'With service providers who assist us in operating and maintaining the app, such as cloud storage providers and analytics companies.',
            ),
            BulletText(
              text:
                  'In response to legal requests or to protect our rights, property, and safety.',
            ),
            SizedBox(height: 24),
            heading('5. Security'),
            SizedBox(height: 8),
            body(
              'We take reasonable measures to protect the security of your information, but please be aware that no method of transmission or storage is completely secure.',
            ),
            SizedBox(height: 24),
            heading('6. Changes to This Privacy Policy'),
            SizedBox(height: 8),
            body(
              'We reserve the right to modify this Privacy Policy at any time. Any changes will be effective immediately upon posting the updated policy on this page.',
            ),
            SizedBox(height: 24),
            heading('7. Contact Us'),
            SizedBox(height: 8),
            body(
              'If you have any questions or concerns regarding this Privacy Policy, please contact us at privacy@joyhomes.com.',
            ),
          ],
        ),
      ),
    );
  }
}
