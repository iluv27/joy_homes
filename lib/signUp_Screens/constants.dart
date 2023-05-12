import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';
import 'package:flutter/gestures.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/homeimg.png', // Replace with your image path
      fit: BoxFit.fitWidth,
      width: double.infinity,
      height: double.infinity,
    );
  }
}

// This is the logo tags
class LogoTag extends StatelessWidget {
  const LogoTag({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }
}

// This is the 'already have an account' TEXT
class LastText extends StatelessWidget {
  const LastText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
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
    );
  }
}

// This is the sign up with google and mail buttons
class SignupButtons extends StatelessWidget {
  const SignupButtons(
      {super.key,
      required this.icondata,
      required this.buttonWords,
      required this.onPressed});

  final IconData icondata;
  final String buttonWords;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            backgroundColor:
                MaterialStateProperty.all<Color>(AppColors.secondary),
            fixedSize: MaterialStateProperty.all<Size>(
                const Size(double.infinity, 48))),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icondata),
            const SizedBox(
              width: 10,
            ),
            Text(
              buttonWords,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
