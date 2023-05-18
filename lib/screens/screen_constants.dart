import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';
import 'package:joy_homes/signUp_Screens/register.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double height;

  const AppBarWidget({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.backgroundColor,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title.toString(),
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: leading,
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
                  return SignupOptions();
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
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.secondary,
                width: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
