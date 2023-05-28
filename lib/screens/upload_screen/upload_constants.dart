import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';
import 'upload_details.dart';
import 'dart:io';

final List<File> selectedImages = [];

class AppBarWidget2 extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double height;
  final PreferredSizeWidget? preferredSize1;
  final double? leadingWidth1;
  final bool showForwardIcon; // New property

  const AppBarWidget2({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.backgroundColor,
    required this.height,
    this.preferredSize1,
    this.leadingWidth1,
    this.showForwardIcon = true, // Default value is true
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: title,
      leading: leading,
      leadingWidth: leadingWidth1,
      actions: [
        if (showForwardIcon) // Conditionally show the forward icon
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const UploadDetails();
                }));
              },
              child: Icon(
                Icons.forward,
                color: AppColors.smallIcons,
                size: 30,
              ),
            ),
          ),
      ],
      bottom: preferredSize1,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

// THIS IS THE INPUT FIELDS
// ignore: must_be_immutable
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
      child: TextFormField(
        controller: textEditingController,
        onChanged: onInputChanged,
        cursorWidth: 1.5,
        cursorHeight: 20,
        cursorColor: AppColors.primary,
        style: const TextStyle(color: AppColors.textColor, fontSize: 16),
        decoration: InputDecoration(
          labelStyle: TextStyle(color: AppColors.textColor),
          counterText: '0/100',
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          hintText: innerText,
          hintStyle: TextStyle(color: AppColors.textColor.withOpacity(0.3)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primary.withOpacity(0.3),
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primary,
              width: 1.0,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(66, 235, 62, 62),
              width: 1.0,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
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
