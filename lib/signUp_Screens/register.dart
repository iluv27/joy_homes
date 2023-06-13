import 'package:flutter/material.dart';
import 'constants.dart';
import 'sign_up.dart';

class SignupOptions extends StatelessWidget {
  const SignupOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            const BackgroundImage(),
            // Your other widgets will be placed on top of the background image
            // For example, here's a centered Text widget
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 150,
                ),
                const LogoTag(),
                const SizedBox(
                  height: 100,
                ),
                SignupButtons2(
                  icondata: Icons.fmd_good,
                  buttonWords: 'Sign up with Google',
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Or',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                SignupButtons(
                    icondata: Icons.mail,
                    buttonWords: 'Sign up with Mail',
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return SignupScreen();
                      }));
                    }),
                const SizedBox(
                  height: 100,
                ),
                const LastText(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
