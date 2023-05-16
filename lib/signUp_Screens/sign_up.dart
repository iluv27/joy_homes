// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';
import 'constants.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  TextEditingController fullName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            const BackgroundImage(),
            Positioned(
              top: 80,
              height: MediaQuery.of(context).size.height * 1,
              width: MediaQuery.of(context).size.width * 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/logo.png', // Replace with your image path
                      scale: 3,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 30),
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
                              height: 25,
                            ),
                            InputField(
                              textEditingController: lastName,
                              onInputChanged: ((value) {
                                value = lastName.text;
                              }),
                              innerText: 'Last Name',
                              validatorText: 'Please enter your last name',
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            InputField(
                              textEditingController: phoneNo,
                              onInputChanged: ((value) {
                                value = phoneNo.text;
                              }),
                              innerText: 'Phone No.',
                              validatorText: 'Please enter your phone no.',
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            InputField(
                              textEditingController: email,
                              onInputChanged: ((value) {
                                value = email.text;
                              }),
                              innerText: 'Email',
                              validatorText: 'Please enter your email',
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            InputField(
                              textEditingController: password,
                              onInputChanged: ((value) {
                                value = password.text;
                              }),
                              innerText: 'Enter Password',
                              validatorText: 'Please enter your password',
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            InputField(
                              textEditingController: confirmPassword,
                              onInputChanged: (value) {
                                value = confirmPassword.text;
                              },
                              innerText: 'Confirm Password',
                              validatorText: 'Please confirm your password',
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            InputField(
                              textEditingController: userName,
                              onInputChanged: (value) {
                                value = userName.text;
                              },
                              innerText: 'Create Username',
                              validatorText:
                                  'Please create your own unique username',
                            ),
                            const CheckBoxListTile(
                              text: Text(
                                "I accept the terms and conditions  of Joyhomes",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
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
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
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
                  const Expanded(
                    flex: 1,
                    child: LastText(),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
