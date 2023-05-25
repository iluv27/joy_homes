import 'package:flutter/material.dart';
import 'package:joy_homes/screens/screen_constants.dart';
import 'package:joy_homes/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileDetails();
  }
}

class ProfileDetails extends StatefulWidget {
  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarWidget(
          leadingWidth1: 36,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: IconButton(
              color: AppColors.textColor,
              icon: Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState!.openEndDrawer();
              },
            ),
          ),
          preferredSize1: PreferredSize(
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
          title: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              'Profile',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          height: 60),
      endDrawer: Directionality(
        textDirection: TextDirection.ltr,
        child: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text('John Doe'),
                accountEmail: Text('johndoe@example.com'),
                currentAccountPicture: CircleAvatar(
                  radius: 30,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/profilepic.jpg',
                          ),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    ),
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
      ),
      body: Container(
          // Your app content goes here
          ),
    );
  }
}

class ListTileBar extends StatelessWidget {
  const ListTileBar(
      {super.key,
      required this.iconData,
      this.onTapped,
      required this.listTitle});

  final Function()? onTapped;
  final IconData iconData;
  final String listTitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        trailing: Icon(
          iconData,
          color: AppColors.textColor.withOpacity(0.6),
          size: 22,
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            listTitle,
            style: TextStyle(color: AppColors.textColor.withOpacity(0.8)),
          ),
        ),
        onTap: onTapped);
  }
}
