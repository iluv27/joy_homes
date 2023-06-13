import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';
import '../screen_constants.dart';
import 'terms.dart';
import 'versions.dart';
import 'privacy.dart';
import 'help.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFFAFAFA),
        appBar: AppBarWidget(
          preferredSize1: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.secondary.withOpacity(0.4),
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              'Settings',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          height: 60,
        ),
        body: const SettingsListview(),
      ),
    );
  }
}

class SettingsListview extends StatelessWidget {
  const SettingsListview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
      children: const [
        SettingsColumn(),
        SizedBox(
          height: 10,
        ),
        SettingsColumn2()
      ],
    );
  }
}

class SettingsColumn extends StatefulWidget {
  const SettingsColumn({Key? key}) : super(key: key);

  @override
  State<SettingsColumn> createState() => _SettingsColumnState();
}

class _SettingsColumnState extends State<SettingsColumn> {
  bool toggleButtonLocation = true;
  bool toggleButtonNotification = true;
  String mainSubtitleLocation = 'On';
  String mainSubtitleNotification = 'On';

  @override
  void initState() {
    super.initState();
  }

  void toggleSwitchLocation() {
    setState(() {
      toggleButtonLocation = !toggleButtonLocation;
      mainSubtitleLocation = toggleButtonLocation ? 'On' : 'Off';
    });
  }

  void toggleSwitchNotification() {
    setState(() {
      toggleButtonNotification = !toggleButtonNotification;
      mainSubtitleNotification = toggleButtonNotification ? 'On' : 'Off';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
          child: Text(
            'Phone',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        SettingsListile2(
          toggleSwitch: toggleButtonLocation,
          onTapped: toggleSwitchLocation,
          mainTitle: 'Location',
          mainSubtitle: mainSubtitleLocation,
          firstIcon: Icons.location_on,
        ),
        const SizedBox(
          height: 10,
        ),
        SettingsListile2(
          toggleSwitch: toggleButtonNotification,
          mainTitle: 'Notification',
          mainSubtitle: mainSubtitleNotification,
          onTapped: toggleSwitchNotification,
          firstIcon: Icons.notifications_active,
        ),
        const SizedBox(
          height: 10,
        ),
        SettingsListTile(
          onTapped: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) {
                return HelpCenterScreen();
              }),
            );
          },
          mainTitle: 'Help Center',
          mainSubtitle: 'Need some guidance?',
          firstIcon: Icons.help_center,
        ),
      ],
    );
  }
}

class SettingsColumn2 extends StatefulWidget {
  const SettingsColumn2({Key? key}) : super(key: key);

  @override
  _SettingsColumn2State createState() => _SettingsColumn2State();
}

class _SettingsColumn2State extends State<SettingsColumn2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
          child: Text(
            'Support',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        SettingsListTile3(
          mainTitle: 'Language',
          mainSubtitle: 'English',
          firstIcon: Icons.language,
        ),
        SizedBox(
          height: 10,
        ),
        SettingsListTile(
          mainTitle: 'Privacy Policy',
          mainSubtitle: 'Read',
          firstIcon: Icons.privacy_tip_outlined,
          onTapped: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) {
                return PrivacyScreen();
              }),
            );
          },
        ),
        SizedBox(
          height: 10,
        ),
        SettingsListTile(
          onTapped: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) {
                return TermsOfServiceScreen();
              }),
            );
          },
          mainTitle: 'Terms and Conditions',
          mainSubtitle: 'Read',
          firstIcon: Icons.sticky_note_2_sharp,
        ),
        SizedBox(
          height: 10,
        ),
        SettingsListTile(
          onTapped: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) {
                return VersionsScreen();
              }),
            );
          },
          mainTitle: 'App version and Updates',
          mainSubtitle: 'V1.0.0',
          firstIcon: Icons.phone_android_outlined,
        ),
      ],
    );
  }
}

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    Key? key,
    required this.mainTitle,
    required this.mainSubtitle,
    required this.firstIcon,
    this.onTapped,
  }) : super(key: key);

  final String mainTitle;
  final String mainSubtitle;
  final IconData firstIcon;
  final Function()? onTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white, // set the background color
          border: Border.all(
            color: AppColors.primary.withOpacity(0.2), // set the border color
            width: 1.0, // set the border width
          ),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 13),
          horizontalTitleGap: 15,
          iconColor: AppColors.primary,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                firstIcon,
                size: 40,
              ),
            ],
          ),
          title: Text(
            mainTitle,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              mainSubtitle,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.textColor.withOpacity(0.7),
              ),
            ),
          ),
          trailing: GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.25),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SettingsListile2 extends StatelessWidget {
  const SettingsListile2({
    Key? key,
    required this.mainTitle,
    required this.mainSubtitle,
    required this.firstIcon,
    required this.toggleSwitch,
    required this.onTapped,
  }) : super(key: key);

  final String mainTitle;
  final String mainSubtitle;
  final IconData firstIcon;
  final bool toggleSwitch;
  final VoidCallback onTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          border: Border.all(
            color: AppColors.primary.withOpacity(0.2),
            width: 1.0,
          ),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 13),
          horizontalTitleGap: 15,
          iconColor: AppColors.primary,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                firstIcon,
                size: 40,
              ),
            ],
          ),
          title: Text(
            mainTitle,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              mainSubtitle,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.textColor.withOpacity(0.7),
              ),
            ),
          ),
          trailing: Container(
            height: 25,
            width: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primary,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(1000),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: CupertinoSwitch(
                value: toggleSwitch,
                onChanged: (bool value) {
                  onTapped();
                },
                activeColor: AppColors.secondary,
                trackColor: Colors.white,
                thumbColor: toggleSwitch ? Colors.white : AppColors.secondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// THE LANGUAGE OWN IS DIFFERENT
class SettingsListTile3 extends StatelessWidget {
  const SettingsListTile3({
    Key? key,
    required this.mainTitle,
    required this.mainSubtitle,
    required this.firstIcon,
    this.onTapped,
  }) : super(key: key);

  final String mainTitle;
  final String mainSubtitle;
  final IconData firstIcon;
  final Function()? onTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white, // set the background color
          border: Border.all(
            color: AppColors.primary.withOpacity(0.2), // set the border color
            width: 1.0, // set the border width
          ),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 13),
          horizontalTitleGap: 15,
          iconColor: AppColors.primary,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                firstIcon,
                size: 40,
              ),
            ],
          ),
          title: Text(
            mainTitle,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              mainSubtitle,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.textColor.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
