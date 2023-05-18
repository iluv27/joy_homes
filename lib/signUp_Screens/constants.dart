// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';
import 'package:flutter/gestures.dart';
import 'log_in.dart';

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
          scale: 4.5,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Acquiring Your Dream Home With Ease',
          style: TextStyle(fontSize: 14, letterSpacing: 0.5),
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
        style: const TextStyle(fontSize: 16),
        children: [
          TextSpan(
            text: 'Log in',
            style: const TextStyle(color: AppColors.secondary, fontSize: 16),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              },
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}

// The LOGIN SCREEN CONST
class InputField extends StatelessWidget {
  InputField(
      {Key? key,
      required this.innerText,
      required this.validatorText,
      this.onInputChanged,
      this.textEditingController})
      : super(key: key);

  final String innerText;
  final String validatorText;
  final Function(String)? onInputChanged;
  TextEditingController? textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: TextFormField(
        controller: textEditingController,
        onChanged: onInputChanged,
        cursorWidth: 1.5,
        cursorHeight: 20,
        cursorColor: AppColors.primary,
        style: const TextStyle(color: AppColors.textColor, fontSize: 16),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
          hintText: innerText,
          hintStyle: TextStyle(color: AppColors.textColor.withOpacity(0.5)),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.textColor,
              width: 1.0,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.textColor,
              width: 1.0,
            ),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(66, 235, 62, 62),
              width: 1.0,
            ),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(66, 235, 62, 62),
              width: 1.0,
            ),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return validatorText;
          }
          return null;
        },
      ),
    );
  }
}

// THIS IS THE REMEMBER ME CHECK BOX
class CheckBoxListTile extends StatefulWidget {
  const CheckBoxListTile({super.key, required this.text});
  final Widget? text;
  @override
  State<CheckBoxListTile> createState() => _CheckBoxListTileState();
}

class _CheckBoxListTileState extends State<CheckBoxListTile> {
  bool? _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      side: const BorderSide(color: Colors.black),
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      selected: true,
      value: _isChecked,
      onChanged: (bool? value) {
        setState(() {
          _isChecked = value;
        });
      },
      title: widget.text,
      controlAffinity: ListTileControlAffinity.leading,
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
