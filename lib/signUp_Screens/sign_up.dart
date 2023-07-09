// ignore_for_file: unused_local_variable, unused_element, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:joy_homes/main.dart';
import 'package:joy_homes/theme.dart';
import 'constants.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'log_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

// FOR SIGN UP

  void _signUpWithEmail() {
    String firstName1 = firstName.text;
    String lastName1 = lastName.text;
    String phoneNo1 = phoneNo.text;
    String email1 = email.text;
    String password1 = password.text;
    String confirmPassword1 = confirmPassword.text;

    // Perform sign up with email and password logic here
    // You can use FirebaseAuth or any other authentication service

    // Clear the text fields after sign up
    firstName.clear();
    lastName.clear();
    phoneNo.clear();
    email.clear();
    password.clear();
    confirmPassword.clear();

    @override
    void dispose() {
      firstName.dispose();
      lastName.dispose();
      phoneNo.dispose();
      email.dispose();
      password.dispose();
      confirmPassword.dispose();
      super.dispose();
    }
  }

// For Agents
// Future<void> registerAgent(String name, String email, String agency) async {
//   try {
//     CollectionReference agents = FirebaseFirestore.instance.collection('agents');

//     await agents.add({
//       'name': name,
//       'email': email,
//       'agency': agency,
//       // Add any other relevant agent information
//     });
//   } catch (e) {
//     // Handle any errors
//   }
// }

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        progressIndicator: CircularProgressIndicator(
          color: AppColors.secondary,
        ),
        inAsyncCall: showSpinner,
        child: Stack(
          children: [
            const BackgroundImage(),
            Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 90.0),
                    child: Image.asset(
                      'assets/images/logo.png', // Replace with your image path
                      scale: 4.5,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 60.0, left: 10, right: 10),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                InputField(
                                  textEditingController: firstName,
                                  onInputChanged: ((value) {
                                    value = firstName.text;
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
                                const CheckBoxListTile(
                                  text: Text(
                                    "I accept the terms and conditions  of Joyhomes",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black54),
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
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
                                          .registerUser(
                                              '${firstName.text} ${lastName.text}',
                                              phoneNo.text,
                                              email.text,
                                              password.text);

                                      if (Provider.of<AuthenticationProvider>(
                                                  context,
                                                  listen: false)
                                              .currentUser !=
                                          null) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: ((context) {
                                              return LoginScreen();
                                            }),
                                          ),
                                        );
                                      }
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    } catch (e) {
                                      // Handle sign-up errors, such as invalid email, weak password, or email already exists
                                      print('Sign up error: $e');
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
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    flex: 0,
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: const LastText(),
                        ))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // implement build
  throw UnimplementedError();
}

// DEMACATION

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
        String email = account.email;
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
                  // primary: Colors.white,
                  // onPrimary: Colors.black,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
