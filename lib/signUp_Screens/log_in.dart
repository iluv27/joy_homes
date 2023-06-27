// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:joy_homes/main.dart';
import 'package:joy_homes/signUp_Screens/register.dart';
import 'package:joy_homes/theme.dart';
import 'constants.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(
            color: AppColors.secondary,
          ),
          inAsyncCall: showSpinner,
          child: Stack(
            children: <Widget>[
              const BackgroundImage(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: const LogoTag(),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SignupButtons2(
                    icondata: Icons.fmd_good,
                    buttonWords: 'Sign in with Google',
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        await Provider.of<AuthenticationProvider>(context,
                                listen: false)
                            .signInWithGoogle();

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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                    ),
                    child: Stack(children: [
                      Positioned(
                        top: 23,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: 0.5,
                          color: AppColors.textColor.withOpacity(0.3),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.center,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          child: Container(
                            padding: EdgeInsets.all(15),
                            color: Colors.white,
                            child: Text(
                              'Or',
                              style: TextStyle(
                                  color: AppColors.textColor.withOpacity(0.4)),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 30),
                      child: Column(
                        children: [
                          InputField(
                            textEditingController: email,
                            onInputChanged: ((value) {
                              value = email.text;
                            }),
                            innerText: 'Enter Email',
                            validatorText: 'Please enter your email',
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          InputField(
                            textEditingController: password,
                            onInputChanged: (value) {
                              value = password.text;
                            },
                            innerText: 'Enter Password',
                            validatorText: 'Please enter your password',
                          ),
                          const SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                      fontSize: 14, color: AppColors.primary),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                showSpinner = true;
                              });
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                // Send data to the server
                              }
                              try {
                                await Provider.of<AuthenticationProvider>(
                                        context,
                                        listen: false)
                                    .login(email.text, password.text);

                                // FROM SIGN UP

                                if (Provider.of<AuthenticationProvider>(context,
                                            listen: false)
                                        .currentUser !=
                                    null) {
                                  // ignore: use_build_context_synchronously

                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                          builder: ((BuildContext) {
                                    return MainMenuScreen();
                                  })));
                                }
                                setState(() {
                                  showSpinner = false;
                                });
                              } catch (e) {
                                // Handle sign-in errors, such as wrong email or password
                                print('Sign in error: $e');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fixedSize: const Size(200, 50),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.person),
                                SizedBox(width: 10.0),
                                Text('Log in',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 70.0),
                    child: Text.rich(
                      TextSpan(
                        text: 'Don\'t have an account? ',
                        style: const TextStyle(fontSize: 16),
                        children: [
                          TextSpan(
                            text: 'Sign up',
                            style: const TextStyle(
                              color: AppColors.secondary,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const SignupOptions();
                                }));
                              },
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
