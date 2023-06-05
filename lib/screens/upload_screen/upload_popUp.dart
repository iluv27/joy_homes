import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';
import 'upload_register.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    // final popupHeight = screenHeight / 1.9;

    return Stack(
      children: [
        Container(
          color: Colors.black54,
        ),
        AlertDialog(
          title: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.asset(
                  'assets/images/miniPicture.png',
                  scale: 3,
                ),
              ),
              Text(
                'You will need to be verified to upload a home on Joyhomes',
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1.4,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor),
              )
            ],
          ),
          actions: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
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
                  child: Text('Ok',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ],
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}
