// ignore_for_file: must_be_immutable,

import 'dart:io';
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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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
  User? currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool get isLoggedIn => currentUser != null;
  String? firstName;
  String? lastName;
  String? displayName;
  String? userEmail;
  String? photoUrl;
  String? identity;
  String? contactPreference;
  String? verificationMode;
  String? verificationImageURL;
  GoogleSignInAccount? googleUser;

  // SETTING AGENT INFO
  Future<void> updateUserOwner(
    String identity1,
    String contactPreference1,
    String verificationMode1,
    String verificationImageURL1,
  ) async {
    if (currentUser != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser!.uid)
          .update({
        'identity': identity1,
        'contactPreference': contactPreference1,
        'verificationMode': verificationMode1,
        'verificationImageURL': verificationImageURL1,
      }).then((_) async {
        // Retrieve user data
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUser!.uid)
            .get()
            .then((snapshot) async {
          if (snapshot.exists) {
            displayName = snapshot.get('displayName');
            userEmail = snapshot.get('email');
            photoUrl = snapshot.get('photoUrl');
            identity = snapshot.get('identity');
            contactPreference = snapshot.get('contactPreference');
            verificationMode = snapshot.get('verificationMode');
            verificationImageURL = snapshot.get('verificationImageURL');
            // Copy user data to 'Agents' collection
          }
        }).catchError((error) {
          // Failed to retrieve user data
        });
      }).catchError((error) {
        // Failed to update 'Owner' field
      });
    }
  }

// UPLOAD IMAGE TO THE STORAGE
  Future<String> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      await ref.putFile(imageFile);
      String imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return '';
    }
  }

  // GOOGLE SIGN IN
  Future<void> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow.
      googleUser = await _googleSignIn.signIn();

      // Obtain the auth details from the request.
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential.
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in or sign up to Firebase with the Google credential.
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Access the authenticated user.
      currentUser = userCredential.user;

      if (googleUser != null) {
        await saveUserDataToFirestore(currentUser!, googleUser!);
        await getUserDataFromFirestore(currentUser!.uid);
      }

      if (currentUser != null) {
        // Check if it's a new user (sign-up) or an existing user (sign-in).

        // Retrieve user data from Firestore.
        await getUserDataFromFirestore(currentUser!.uid);
        await saveUserDataToFirestore(currentUser!, googleUser!);

        // User is signing up with Google for the first time.

        // Use the retrieved data as needed.
      }
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }

  Future<void> saveUserDataToFirestore(
      User user, GoogleSignInAccount googleUser) async {
    try {
      // ignore: unnecessary_null_comparison
      if (googleUser != null) {
        await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
          'displayName': googleUser.displayName,
          'email': googleUser.email,
          'photoUrl': googleUser.photoUrl,
          'identity': 'user',
          'verificationMode': '',
          'contactPreference': '',
          'verificationImageURL': '',
          // Add more fields as needed.
        });
      }
    } catch (e) {
      print('Error saving user data to Firestore: $e');
    }
  }

  Future<Map<String, dynamic>?> getUserDataFromFirestore(String uid) async {
    try {
      if (currentUser != null) {
        // Fetch user document from 'users' collection using UID
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUser!.uid)
            .get();

        if (snapshot.exists) {
          // Access user data from the document
          displayName = snapshot.get('displayName');
          userEmail = snapshot.get('email');
          photoUrl = snapshot.get('photoUrl');
          identity = snapshot.get('identity');

          verificationMode = snapshot.get('verificationMode');
          contactPreference = snapshot.get('contactPreference');
          verificationImageURL = snapshot.get('verificationImageURL');

          print('Display Name: $displayName');
          print('Email: $userEmail');
          print('photoUrl: $photoUrl');
          print('identity: $identity');

          // Do something with the user data
        }
      }
    } catch (e) {
      print('Error retrieving user data from Firestore: $e');
      return null;
    }
    return null;
  }

// REGISTER USER and store data in Firebase
  Future registerUser(
      String displayName, String phoneNo, String email, String password) async {
    try {
      // Create user account with email and password
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Generate unique user ID
      String uid = userCredential.user!.uid;

      currentUser = userCredential.user;

      // Store user data in Firebase
      await FirebaseFirestore.instance.collection('Users').doc(uid).set({
        'displayName': displayName,
        'phoneNo': phoneNo,
        'email': email,
        'password': password,
        'photoUrl': '',
        'identity': 'user',
        'verificationMode': '',
        'contactPreference': '',
        'verificationImageURL': '',

        // Add more fields as needed
      });
    } catch (e) {
      print('Error registering user: $e');
    }

    // ignore: unnecessary_null_comparison
  }

// GET USER'S INITIALS

  String getUserInitials() {
    if (displayName != null) {
      List<String> nameParts = displayName!.split(' ');

      firstName = nameParts.isNotEmpty ? nameParts[0] : '';
      lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

      final String? firstInitial = firstName!.isNotEmpty ? firstName![0] : null;
      final String? lastInitial = lastName!.isNotEmpty ? lastName![0] : null;

      return '$firstInitial $lastInitial';
    } else {
      // Handle the case when displayName is null
      return '';
    }
  }

// LOG IN USER
  Future login(String email, String password) async {
    try {
      // Sign in with email and password
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the authenticated user
      currentUser = userCredential.user;

      // ignore: unnecessary_null_comparison
      if (currentUser != null) {
        // Fetch user document from 'users' collection using UID
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUser!.uid)
            .get();

        if (snapshot.exists) {
          // Access user data from the document
          displayName = snapshot.get('displayName');
          userEmail = snapshot.get('email');
          photoUrl = snapshot.get('photoUrl');
          identity = snapshot.get('identity');
          contactPreference = snapshot.get('contactPreference');
          verificationMode = snapshot.get('verificationMode');
          verificationImageURL = snapshot.get('verificationImageURL');

          // Do something with the user data
          print('Display Name: $displayName');
          print('Email: $userEmail');
          print('identity: $identity');
        }
      }
    } catch (e) {
      print('Error logging in: $e');
    }
  }

// LOG OUT USER
  Future<void> logout() async {
    try {
      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();

      // Clear the user data
      currentUser = null;
      displayName = null;
      userEmail = null;

      notifyListeners();

      // Perform any additional actions after logging out
    } catch (e) {
      print('Error logging out: $e');
    }
  }

// SIGN OUT FROM GOOGLE
  Future<void> signOutFromGoogle() async {
    try {
      // Sign out from Google.
      await _googleSignIn.signOut();

      // Sign out from Firebase.
      await FirebaseAuth.instance.signOut();

      // Clear the user data.
      currentUser = null;
      displayName = null;
      userEmail = null;
      photoUrl = null;
      notifyListeners();
      // Perform any additional actions after logging out.
    } catch (e) {
      print('Error signing out: $e');
    }
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
