import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';
import 'constants.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  TextEditingController fullName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  void _signUpWithEmail() {
    String fullName1 = fullName.text;
    String lastName1 = lastName.text;
    String phoneNo1 = phoneNo.text;
    String email1 = email.text;
    String password1 = password.text;
    String confirmPassword1 = confirmPassword.text;

    // Perform sign up with email and password logic here
    // You can use FirebaseAuth or any other authentication service

    // Clear the text fields after sign up
    fullName.clear();
    lastName.clear();
    phoneNo.clear();
    email.clear();
    password.clear();
    confirmPassword.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            const BackgroundImage(),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Image.asset(
                      'assets/images/logo.png', // Replace with your image path
                      scale: 4.5,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30, top: 30),
                          child: Column(
                            children: [
                              Flexible(
                                child: InputField(
                                  textEditingController: fullName,
                                  onInputChanged: ((value) {
                                    value = fullName.text;
                                  }),
                                  innerText: 'First Name',
                                  validatorText: 'Please enter your first name',
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Flexible(
                                child: InputField(
                                  textEditingController: lastName,
                                  onInputChanged: ((value) {
                                    value = lastName.text;
                                  }),
                                  innerText: 'Last Name',
                                  validatorText: 'Please enter your last name',
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Flexible(
                                child: InputField(
                                  textEditingController: phoneNo,
                                  onInputChanged: ((value) {
                                    value = phoneNo.text;
                                  }),
                                  innerText: 'Phone No.',
                                  validatorText: 'Please enter your phone no.',
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Flexible(
                                child: InputField(
                                  textEditingController: email,
                                  onInputChanged: ((value) {
                                    value = email.text;
                                  }),
                                  innerText: 'Email',
                                  validatorText: 'Please enter your email',
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Flexible(
                                child: InputField(
                                  textEditingController: password,
                                  onInputChanged: ((value) {
                                    value = password.text;
                                  }),
                                  innerText: 'Enter Password',
                                  validatorText: 'Please enter your password',
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Flexible(
                                child: InputField(
                                  textEditingController: confirmPassword,
                                  onInputChanged: (value) {
                                    value = confirmPassword.text;
                                  },
                                  innerText: 'Confirm Password',
                                  validatorText: 'Please confirm your password',
                                ),
                              ),
                              Flexible(
                                child: const CheckBoxListTile(
                                  text: Text(
                                    "I accept the terms and conditions  of Joyhomes",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black54),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _signUpWithEmail();
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
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: const LastText(),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SignUpScreen1 extends StatefulWidget {
  @override
  _SignUpScreen1State createState() => _SignUpScreen1State();
}

class _SignUpScreen1State extends State<SignUpScreen1> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signUpWithEmail() {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Perform sign up with email and password logic here
    // You can use FirebaseAuth or any other authentication service

    // Clear the text fields after sign up
    _emailController.clear();
    _passwordController.clear();
  }

  void _signUpWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? account = await googleSignIn.signIn();

      if (account != null) {
        // Get user information from Google account
        String name = account.displayName ?? '';
        String email = account.email ?? '';
        String profileImageUrl = account.photoUrl ?? '';

        // Perform sign up with Google logic here
        // You can use FirebaseAuth or any other authentication service

        // Display user information
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Google Sign Up'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Name: $name'),
                  Text('Email: $email'),
                  Image.network(profileImageUrl),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Sign up with Google failed: $e');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _signUpWithEmail,
              child: Text('Sign Up with Email'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton.icon(
              onPressed: _signUpWithGoogle,
              icon: Image.asset(
                'assets/google_logo.png',
                width: 24.0,
                height: 24.0,
              ),
              label: Text('Sign Up with Google'),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
