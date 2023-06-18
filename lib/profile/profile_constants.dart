import 'dart:math';
import 'package:joy_homes/main.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:joy_homes/profile/profile_main.dart';
import 'package:joy_homes/theme.dart';
import 'package:joy_homes/signUp_Screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';

// class UserInfo {
//   final String newUser;
//   final String newMail;

//   UserInfo({
//     required this.newUser,
//     required this.newMail,
//   });
// }

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final String? nameInitials;
  final double height;
  final PreferredSizeWidget? preferredSize1;
  final double? leadingWidth1;

  AppBarWidget({
    Key? key,
    required this.title,
    this.nameInitials,
    this.leading,
    this.actions,
    this.backgroundColor,
    required this.height,
    this.preferredSize1,
    this.leadingWidth1,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
      builder: (context, authenticationProvider, _) {
        final isLoggedIn = authenticationProvider.isLoggedIn;

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
                      color: AppColors.primary,
                      width: 1,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: ProfileSection()),
            ),
          ],
          bottom: preferredSize1,
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class ProfileSection extends StatelessWidget {
  ProfileSection({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isLoggedIn) {
          return GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  return ProfileScreen();
                }),
              );
            },
            child: CircleAvatar(
              maxRadius: 20,
              backgroundColor: _getRandomColor(),
              child: Icon(
                Icons.favorite_rounded,
                color: AppColors.textColor,
                size: 22,
              ),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  return const SignupOptions();
                }),
              );
            },
            child: CircleAvatar(
              maxRadius: 20,
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.person,
                color: AppColors.textColor,
                size: 22,
              ),
            ),
          );
        }
      },
    );
  }

  Widget _getUserInitialsWidget() {
    return Consumer<AuthenticationProvider>(
      builder: (context, authenticationProvider, _) {
        try {
          final user = authenticationProvider.currentUser;

          if (user != null) {
            final String? firstName = user.displayName?.split(' ')[0];
            final String? lastName = user.displayName?.split(' ')[1];
            final userInitials = _getUserInitials(firstName, lastName);

            return Text(
              userInitials,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            );
          }
        } catch (e) {
          print(e);
        }

        return Container();
      },
    );
  }

  String _getUserInitials(String? firstName, String? lastName) {
    final String? firstInitial =
        firstName?.isNotEmpty == true ? firstName![0] : null;
    final String? lastInitial =
        lastName?.isNotEmpty == true ? lastName![0] : null;
    return '$firstInitial $lastInitial';
  }

  Color _getRandomColor() {
    final List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
    ];

    return colors[Random().nextInt(colors.length)];
  }
}
