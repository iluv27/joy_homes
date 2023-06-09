// ignore_for_file: must_be_immutable, unused_import

import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';
import 'screens/search_screen/search.dart';
import 'screens/favourites.dart';
import 'screens/home_screen/home.dart';
import 'screens/settings_screen/settings.dart';
import 'screens/upload_screen/upload.dart';
import 'signUp_Screens/register.dart';
import 'signUp_Screens/log_in.dart';
import 'signUp_Screens/sign_up.dart';
import 'profile/profile_main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: const MainMenuScreen()),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            titleTextStyle: TextStyle(
                color: AppColors.textColor,
                fontSize: 22,
                fontWeight: FontWeight.w600),
            toolbarHeight: 60),
      ),
    );
  }
}

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  //Nav Bar Congig....

  final ValueNotifier<int> pageIndex = ValueNotifier(0);

  int selectedIndex = 0;

  static List<Widget> pages = [
    const HomeScreen(),
    const SearchScreen(),
    const UploadScreen(),
    FavouriteScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ValueListenableBuilder(
          valueListenable: pageIndex,
          builder: ((context, value, child) {
            return pages[value];
          })),
      bottomNavigationBar: _BottomBarItems(
        onItemSelected: (selectedIndex) {
          pageIndex.value = selectedIndex;
        },
      ),
    );
  }
}

class _BottomBarItems extends StatefulWidget {
  const _BottomBarItems({this.onItemSelected});

  final ValueChanged<int>? onItemSelected;

  @override
  State<_BottomBarItems> createState() => _BottomBarItemsState();
}

class _BottomBarItemsState extends State<_BottomBarItems> {
  int selIndex = 0;

  void handleItemSelected(int index) {
    setState(() {
      selIndex = index;
    });

    widget.onItemSelected!(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Material(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
            color: const Color(0XFFFFFFFF),
          ),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BottomBarItem(
                selectedIndex: 0,
                icon: Icons.house,
                text: 'Home',
                onTap: handleItemSelected,
                isSelected: selIndex == 0,
              ),
              BottomBarItem(
                selectedIndex: 1,
                icon: Icons.search_rounded,
                text: 'Search',
                onTap: handleItemSelected,
                isSelected: selIndex == 1,
              ),
              BottomBarItem(
                selectedIndex: 2,
                icon: Icons.add_box_outlined,
                text: 'Upload',
                onTap: handleItemSelected,
                isSelected: selIndex == 2,
              ),
              BottomBarItem(
                selectedIndex: 3,
                icon: Icons.favorite_border_outlined,
                text: 'Faves',
                onTap: handleItemSelected,
                isSelected: selIndex == 3,
              ),
              BottomBarItem(
                selectedIndex: 4,
                icon: Icons.tune_outlined,
                text: 'Settings',
                onTap: handleItemSelected,
                isSelected: selIndex == 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomBarItem extends StatelessWidget {
  BottomBarItem(
      {super.key,
      required this.icon,
      required this.text,
      required this.selectedIndex,
      this.onTap,
      this.isSelected = false});

  ValueChanged<int>? onTap;
  int selectedIndex;
  String text;
  IconData icon;
  bool isSelected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (() {
        onTap!(selectedIndex);
      }),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.secondary : AppColors.textColor,
            size: isSelected ? 24 : 23,
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            text,
            style: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.textColor,
                fontSize: 12),
          ),
        ],
      ),
    );
  }
}
