import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';

class SignupOptions extends StatelessWidget {
  const SignupOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/homeimg.png', // Replace with your image path
              fit: BoxFit.fitWidth,
              width: double.infinity,
              height: double.infinity,
            ),
            // Your other widgets will be placed on top of the background image
            // For example, here's a centered Text widget
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 90,
                ),
                Image.asset(
                  'assets/images/logo.png', // Replace with your image path
                  scale: 3,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Acquiring Your Dream Home With Ease',
                  style: TextStyle(fontSize: 16, letterSpacing: 1),
                ),
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.secondary),
                        fixedSize: MaterialStateProperty.all<Size>(
                            const Size(double.infinity, 48))),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.fmd_good),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Sign up with Google',
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Or',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.secondary),
                        fixedSize: MaterialStateProperty.all<Size>(
                            const Size(double.infinity, 48))),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.mail),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Sign up with Mail',
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Text.rich(
                  TextSpan(
                    text: 'Already have an account? ',
                    children: [
                      TextSpan(
                        text: 'Log in',
                        style: const TextStyle(
                          color: AppColors.secondary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Navigate to the About page
                          },
                      ),
                      const TextSpan(text: '.'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
