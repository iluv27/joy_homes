import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';
import 'constants.dart';
import 'package:flutter/gestures.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  TextEditingController fullName = TextEditingController();
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
              top: 100,
              height: MediaQuery.of(context).size.height * 1,
              width: MediaQuery.of(context).size.width * 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LogoTag(),
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
                              textEditingController: fullName,
                              onInputChanged: ((value) {
                                value = fullName.text;
                              }),
                              innerText: 'First Name',
                              validatorText: 'Please enter your first name',
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InputField(
                              textEditingController: fullName,
                              onInputChanged: ((value) {
                                value = fullName.text;
                              }),
                              innerText: 'Last Name',
                              validatorText: 'Please enter your last name',
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InputField(
                              textEditingController: fullName,
                              onInputChanged: ((value) {
                                value = fullName.text;
                              }),
                              innerText: 'Phone No.',
                              validatorText: 'Please enter your phone no.',
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InputField(
                              textEditingController: fullName,
                              onInputChanged: ((value) {
                                value = fullName.text;
                              }),
                              innerText: 'Email',
                              validatorText: 'Please enter your email',
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InputField(
                              textEditingController: email,
                              onInputChanged: ((value) {
                                value = email.text;
                              }),
                              innerText: 'Enter Password',
                              validatorText: 'Please enter your password',
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InputField(
                              textEditingController: password,
                              onInputChanged: (value) {
                                value = password.text;
                              },
                              innerText: 'Confirm Password',
                              validatorText: 'Please confirm your password',
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InputField(
                              textEditingController: password,
                              onInputChanged: (value) {
                                value = password.text;
                              },
                              innerText: 'Create Username',
                              validatorText:
                                  'Please create your own unique username',
                            ),
                            const CheckBoxListTile(
                              text: Text(
                                "I accept the terms and conditions  of GhostTalks",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54),
                              ),
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
                                  Text('Sign up',
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
