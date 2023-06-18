// ignore_for_file: must_be_immutable,

import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';
import 'screens/search_screen/search.dart';
import 'screens/favourites.dart';
import 'screens/home_screen/home.dart';
import 'screens/settings_screen/settings.dart';
import 'screens/upload_screen/upload.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthenticationProvider(),
      child: MaterialApp(
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
      ),
    );
  }
}

class AuthenticationProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _currentUser;
  User? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;
  String? firstName;
  String? lastName;

  String getUserInitials() {
    final String? firstInitial =
        firstName?.isNotEmpty == true ? firstName![0] : null;
    final String? lastInitial =
        lastName?.isNotEmpty == true ? lastName![0] : null;
    return '$firstInitial $lastInitial';
  }

  void user() {
    final user = _currentUser;
    if (user != null) {
      firstName = user.displayName?.split(' ')[0];
      lastName = user.displayName?.split(' ')[1];
      // ignore: unused_local_variable
      final userInitials = getUserInitials();
    }
  }

  void login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _currentUser = userCredential.user;

      notifyListeners();
    } catch (e) {
      print('Sign in error: $e');
    }
  }

  void logout() {
    // Add your logout logic here
    _currentUser = null;

    notifyListeners();
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
    HomeScreen(),
    SearchScreen(),
    const UploadScreen(),
    FavouriteScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<AuthenticationProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.isLoggedIn) {
            return ValueListenableBuilder(
                valueListenable: pageIndex,
                builder: ((context, value, child) {
                  return pages[value];
                }));
          } else {
            return ValueListenableBuilder(
                valueListenable: pageIndex,
                builder: ((context, value, child) {
                  return pages[value];
                }));
          }
        },
      ),
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
