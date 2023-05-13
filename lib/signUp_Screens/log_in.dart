import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';
import 'constants.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            const BackgroundImage(),
            Positioned(
              bottom: 0,
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LogoTag(),
                  Expanded(
                    flex: 3,
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 50),
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
                              height: 10,
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
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  // Send data to the server
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                fixedSize: const Size(200, 50),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
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
                  ),
                  const Expanded(flex: 1, child: LastText()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
