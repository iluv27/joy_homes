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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Tag line',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            maxLength: 50,
            controller: textEditingController,
            onChanged: onInputChanged,
            cursorWidth: 1.5,
            cursorHeight: 20,
            cursorColor: AppColors.primary,
            style: const TextStyle(color: AppColors.textColor, fontSize: 16),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: AppColors.textColor),
              counterText: '0/50',
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              hintText: innerText,
              hintStyle: TextStyle(color: AppColors.textColor.withOpacity(0.3)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primary.withOpacity(0.8),
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primary.withOpacity(0.3),
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
        ],
      ),
    );
  }
}

class DescriptionTextField extends StatelessWidget {
  final TextEditingController controller;

  const DescriptionTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        TextFormField(
          textAlignVertical: TextAlignVertical.top,
          textAlign: TextAlign.justify,
          cursorColor: AppColors.secondary,
          cursorWidth: 1,
          expands: true,
          controller: controller,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          maxLength: 200,
          decoration: InputDecoration(
            constraints: BoxConstraints.tightFor(height: 100),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: AppColors.primary.withOpacity(0.8),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: AppColors.primary.withOpacity(0.3),
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: AppColors.primary.withOpacity(0.3),
              ),
            ),
            counterText: '0/200', // Disable the default character counter
          ),
          style:
              TextStyle(fontSize: 16, color: AppColors.textColor, height: 1.3),
        ),
      ],
    );
  }
}

class RentTextField extends StatelessWidget {
  final TextEditingController controller;

  const RentTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rent',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                height: 50,
                child: TextFormField(
                  cursorColor: AppColors.secondary,
                  cursorWidth: 1,
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefix: Text(
                      '₦  ',
                      style: TextStyle(
                          color: AppColors.contactColor.withOpacity(0.6)),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.primary.withOpacity(0.8),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.primary.withOpacity(0.3),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.primary.withOpacity(0.3),
                      ),
                    ),
                  ),
                  style: TextStyle(
                      fontSize: 16, color: AppColors.textColor, height: 1.3),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  '/',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 50,
                child: TextFormField(
                  cursorWidth: 1,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.primary.withOpacity(0.8),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.primary.withOpacity(0.3),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.primary.withOpacity(0.3),
                      ),
                    ),
                  ),
                  style: TextStyle(
                      fontSize: 16, color: AppColors.textColor, height: 1.3),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 50,
                child: TextFormField(
                  cursorWidth: 1,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.primary.withOpacity(0.8),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.primary.withOpacity(0.3),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.primary.withOpacity(0.3),
                      ),
                    ),
                  ),
                  style: TextStyle(
                      fontSize: 16, color: AppColors.textColor, height: 1.3),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
