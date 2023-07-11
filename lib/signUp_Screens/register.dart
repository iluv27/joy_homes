import 'package:flutter/material.dart';
import 'package:joy_homes/main.dart';

import 'constants.dart';
import 'sign_up.dart';
import 'package:joy_homes/theme.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class SignupOptions extends StatefulWidget {
  const SignupOptions({super.key});

  @override
  State<SignupOptions> createState() => _SignupOptionsState();
}

class _SignupOptionsState extends State<SignupOptions> {
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(
            color: AppColors.secondary,
          ),
          inAsyncCall: showSpinner,
          child: Stack(
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
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        await Provider.of<AuthenticationProvider>(context,
                                listen: false)
                            .signUpWithGoogle();

                        if (Provider.of<AuthenticationProvider>(context,
                                    listen: false)
                                .currentUser !=
                            null) {
                          // ignore: use_build_context_synchronously

                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: ((BuildContext) {
                            return MainMenuScreen();
                          })));
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        // Handle sign-in errors, such as wrong email or password
                        print('Sign in with google error: $e');
                      }
                    },
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
                        Navigator.push(context,
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
      ),
    );
  }
}
