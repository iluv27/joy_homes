import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';
import 'package:joy_homes/signUp_Screens/register.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double height;
  final PreferredSizeWidget? preferredSize1;
  final double? leadingWidth1;

  const AppBarWidget(
      {super.key,
      required this.title,
      this.leading,
      this.actions,
      this.backgroundColor,
      required this.height,
      this.preferredSize1,
      this.leadingWidth1});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: false,
        title: title,
        leading: leading,
        leadingWidth: leadingWidth1,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primary, // set border color
                  width: 1, // set border width
                ),
                shape: BoxShape.circle, // set container shape to circle
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const SignupOptions();
                  }));
                },
                child: const CircleAvatar(
                  maxRadius: 18,
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.person,
                    color: AppColors.textColor,
                    size: 22,
                  ),
                ),
              ),
            ),
          )
        ],
        bottom: preferredSize1);
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
