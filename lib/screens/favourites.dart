// ignore_for_file: avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:joy_homes/profile/profile_constants.dart';
import 'package:joy_homes/theme.dart';

// ignore: must_be_immutable
class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({
    super.key,
  });

  final List favouriteContainer = [
    const FavContainer(),
    const FavContainer(),
    const FavContainer(),
    const FavContainer(),
    const FavContainer(),
    const FavContainer(),
    const FavContainer(),
    const FavContainer(),
    const FavContainer(),
    const FavContainer(),
    const FavContainer(),
  ];

  void openEndDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0XFFFAFAFA),
        appBar: AppBarWidget(
            openEndDrawer: openEndDrawer,
            leadingWidth1: 0,
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
                'Favourites',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            height: 60),
        body: Container(
          padding: const EdgeInsets.only(top: 30, left: 18, right: 18),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 0.6,
                mainAxisExtent: 200),
            itemCount: favouriteContainer.length,
            // ignore: non_constant_identifier_names
            itemBuilder: (BuildContext, index) {
              return SizedBox(child: favouriteContainer[index]);
            },
          ),
        ),
        endDrawer: ProfileDetails(),
      ),
    );
  }
}

class FavContainer extends StatelessWidget {
  const FavContainer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 0.3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            height: 140,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/house1.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 0,
            child: IconButton(
              padding: EdgeInsets.zero,
              iconSize: 30,
              alignment: Alignment.center,
              onPressed: () {},
              icon: Icon(
                Icons.favorite,
                color: Color.fromARGB(255, 255, 10, 10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '2 Room Apartment',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '₦ 750K/Year',
                  style: TextStyle(
                    color: AppColors.textColor.withOpacity(0.8),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
