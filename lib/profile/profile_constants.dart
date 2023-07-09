import 'dart:math';
import 'package:joy_homes/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:joy_homes/profile/profile_main.dart';
import 'package:joy_homes/theme.dart';
import 'package:joy_homes/signUp_Screens/register.dart';

// class UserInfo {
//   final String newUser;
//   final String newMail;

//   UserInfo({
//     required this.newUser,
//     required this.newMail,
//   });
// }

// ignore: must_be_immutable
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final String? nameInitials;
  final double height;
  final PreferredSizeWidget? preferredSize1;
  final double? leadingWidth1;

  AppBarWidget(
      {Key? key,
      required this.title,
      this.nameInitials,
      this.leading,
      this.actions,
      this.backgroundColor,
      required this.height,
      this.preferredSize1,
      this.leadingWidth1,
      required this.openEndDrawer});

  void Function() openEndDrawer;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
      builder: (context, authenticationProvider, _) {
        return Scaffold(
          appBar: AppBar(
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
                    child: ProfileSection(
                      openEndDrawer: openEndDrawer,
                    )),
              ),
            ],
            bottom: preferredSize1,
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

// ignore: must_be_immutable
class ProfileSection extends StatefulWidget {
  ProfileSection({Key? key, required this.openEndDrawer});

  void Function() openEndDrawer;

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isLoggedIn) {
          return GestureDetector(
            onTap: () {
              setState(() {
                widget.openEndDrawer();
              });
            },
            child: CircleAvatar(
              maxRadius: 20,
              backgroundColor:
                  authProvider.googleUser != null ? null : getRandomColor(),
              backgroundImage: authProvider.googleUser != null
                  ? NetworkImage(authProvider.photoUrl.toString())
                  : null,
              child: authProvider.googleUser != null
                  ? null
                  : Text(
                      authProvider.getUserInitials(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          letterSpacing: -2,
                          fontWeight: FontWeight.w600),
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
}

Color getRandomColor() {
  final List<Color> colors = [
    const Color.fromARGB(255, 133, 20, 12),
    const Color.fromARGB(255, 15, 85, 143),
    const Color.fromARGB(255, 9, 107, 12),
    const Color.fromARGB(255, 123, 112, 13),
    Color.fromARGB(255, 87, 55, 7),
    const Color.fromARGB(255, 90, 8, 104),
  ];

  return colors[Random().nextInt(colors.length)];
}

class ProfileDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
      builder: (context, authProvider, child) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(authProvider.displayName.toString()),
                  accountEmail: Text(authProvider.userEmail.toString()),
                  currentAccountPicture: CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: authProvider.googleUser != null
                        ? null
                        : getRandomColor(),
                    backgroundImage: authProvider.googleUser != null
                        ? NetworkImage(authProvider.photoUrl.toString())
                        : null,
                    child: authProvider.googleUser != null
                        ? null
                        : Text(
                            authProvider.getUserInitials(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                letterSpacing: -1,
                                fontWeight: FontWeight.w600),
                          ),
                  ),
                  // Additional properties can be set to customize the header
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            ListTileBar(
                              listTitle: 'Liked Homes',
                              iconData: Icons.favorite_rounded,
                            ),
                            ListTileBar(
                              listTitle: 'Recent',
                              iconData: Icons.history,
                            ),
                            ListTileBar(
                              listTitle: 'Uploads',
                              iconData: Icons.upload,
                            ),
                            Divider(
                              color: AppColors.textColor,
                            ),
                            ListTileBar(
                              listTitle: 'Reviews',
                              iconData: Icons.reviews,
                            ),
                            ListTileBar(
                              listTitle: 'FAQ',
                              iconData: Icons.question_answer,
                            ),
                            ListTileBar(
                              listTitle: 'Logout',
                              iconData: Icons.logout,
                            ),
                            Divider(
                              color: AppColors.textColor,
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text('Version 1.0.0'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
