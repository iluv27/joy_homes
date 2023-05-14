import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';
import 'screen_constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFFAFAFA),
        appBar: AppBarWidget(
          title: 'Settings',
          height: 65,
        ),
        body: SettingsListview(),
      ),
    );
  }
}

class SettingsListview extends StatelessWidget {
  const SettingsListview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 15),
      children: const [
        SettingsColumn(),
        SizedBox(
          height: 20,
        ),
        SettingsColumn2()
      ],
    );
  }
}

class SettingsColumn extends StatefulWidget {
  const SettingsColumn({super.key});

  @override
  State<SettingsColumn> createState() => _SettingsColumnState();
}

class _SettingsColumnState extends State<SettingsColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
          child: Text(
            'Phone',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        const SettingsListile(
          mainTitle: 'Language',
          mainSubtitle: 'English',
          firstIcon: Icons.language,
        ),
        const SizedBox(
          height: 10,
        ),
        const SettingsListile(
            mainTitle: 'Notification',
            mainSubtitle: 'Only when I\'m online',
            firstIcon: Icons.notifications_active),
        const SizedBox(
          height: 10,
        ),
        SettingsListile2(
            mainTitle: 'Location',
            mainSubtitle: 'On',
            firstIcon: Icons.location_on),
        const SizedBox(
          height: 10,
        ),
        SettingsListile2(
            mainTitle: 'Darkmode',
            mainSubtitle: 'Off',
            firstIcon: Icons.dark_mode_rounded),
      ],
    );
  }
}

class SettingsColumn2 extends StatefulWidget {
  const SettingsColumn2({super.key});

  @override
  State<SettingsColumn2> createState() => _SettingsColumn2State();
}

class _SettingsColumn2State extends State<SettingsColumn2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
          child: Text(
            'Support',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        SettingsListile(
          mainTitle: 'Sounds & Vibrations',
          mainSubtitle: 'Off',
          firstIcon: Icons.vibration_rounded,
        ),
        SizedBox(
          height: 10,
        ),
        SettingsListile(
            mainTitle: 'Password',
            mainSubtitle: 'Fingerprint',
            firstIcon: Icons.password_rounded),
        SizedBox(
          height: 10,
        ),
        SettingsListile(
            mainTitle: 'Help Center',
            mainSubtitle: 'Need some guidance?',
            firstIcon: Icons.help_center),
        SizedBox(
          height: 10,
        ),
        SettingsListile(
            mainTitle: 'Terms and Conditions',
            mainSubtitle: 'Read',
            firstIcon: Icons.sticky_note_2_sharp),
      ],
    );
  }
}

class SettingsListile extends StatelessWidget {
  const SettingsListile(
      {super.key,
      required this.mainTitle,
      required this.mainSubtitle,
      required this.firstIcon});
  final String mainTitle;
  final String mainSubtitle;
  final IconData firstIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // set the background color
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2), // set the border color
          width: 1.0, // set the border width
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        horizontalTitleGap: 20,
        iconColor: AppColors.primary,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              firstIcon,
              size: 45,
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
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsListile2 extends StatefulWidget {
  SettingsListile2(
      {super.key,
      required this.mainTitle,
      required this.mainSubtitle,
      required this.firstIcon});
  final String mainTitle;
  final String mainSubtitle;
  final IconData firstIcon;

  @override
  State<SettingsListile2> createState() => _SettingsListile2State();
}

class _SettingsListile2State extends State<SettingsListile2> {
  bool toggleSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // set the background color
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2), // set the border color
          width: 1.0, // set the border width
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        horizontalTitleGap: 20,
        iconColor: AppColors.primary,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              widget.firstIcon,
              size: 45,
            ),
          ],
        ),
        title: Text(
          widget.mainTitle,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.textColor,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            widget.mainSubtitle,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: AppColors.textColor.withOpacity(0.7),
            ),
          ),
        ),
        trailing: GestureDetector(
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primary,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(1000),
              ),
              child: CupertinoSwitch(
                value: toggleSwitch,
                onChanged: (bool value) {
                  setState(() {
                    toggleSwitch = value;
                  });
                },
                activeColor: AppColors.primary.withOpacity(0.5),
                trackColor: Colors.white,
                thumbColor: AppColors.secondary,
              )),
        ),
      ),
    );
  }
}
