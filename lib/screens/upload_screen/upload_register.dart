import 'package:flutter/material.dart';
import 'package:joy_homes/screens/upload_screen/upload_constants.dart';
import 'package:joy_homes/theme.dart';
import 'upload_popUp.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFAFAFA),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verify Identity',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor),
            ),
            SizedBox(
              height: 40,
            ),
            _DropdownBtn(
              dropdownTitle: 'Owner?',
              dropDownMenuItem: const [
                DropdownMenuItem(
                  value: 'Owner',
                  child: Text('Owner'),
                ),
                DropdownMenuItem(
                  value: 'House Agent',
                  child: Text('House Agent'),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            _DropdownBtn(
              dropdownTitle: 'Contact Preference',
              dropDownMenuItem: const [
                DropdownMenuItem(
                  value: 'Mail',
                  child: Text('Mail'),
                ),
                DropdownMenuItem(
                  value: 'Phone no.',
                  child: Text('Phone no.'),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            _DropdownBtn(
              dropdownTitle: 'Mode of Verification',
              dropDownMenuItem: const [
                DropdownMenuItem(
                  value: 'Driver\'s License',
                  child: Text('Driver\'s License'),
                ),
                DropdownMenuItem(
                  value: 'NIN',
                  child: Text('NIN'),
                ),
                DropdownMenuItem(
                  value: 'International Passport',
                  child: Text('International Passport'),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const VerificationScreen();
                }));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                fixedSize: const Size(200, 50),
              ),
              child: Text('Verify',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}

class _DropdownBtn extends StatelessWidget {
  const _DropdownBtn(
      {super.key, required this.dropdownTitle, required this.dropDownMenuItem});

  final String dropdownTitle;
  final List<DropdownMenuItem<String>> dropDownMenuItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: AppColors.textColor.withOpacity(0.03),
              offset: Offset(0, 0.5),
              spreadRadius: 0.5,
              blurRadius: 5)
        ],
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.primary.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: DropdownButton(
        elevation: 1,
        borderRadius: BorderRadius.circular(5),
        underline: Container(),
        isExpanded: true,
        iconSize: 40,
        iconEnabledColor: AppColors.textColor.withOpacity(0.5),
        hint: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            dropdownTitle,
            style: TextStyle(
              color: AppColors.textColor.withOpacity(0.3),
              fontSize: 16,
            ),
          ),
        ),
        items: dropDownMenuItem,
        onChanged: (value) {
          value = dropdownTitle;
          // Do something with the selected value
        },
      ),
    );
  }
}
