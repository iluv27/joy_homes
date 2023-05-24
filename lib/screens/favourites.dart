// ignore_for_file: avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:joy_homes/screens/screen_constants.dart';
import 'package:joy_homes/theme.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({super.key});

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
    const FavContainer(),
    const FavContainer(),
    const FavContainer(),
    const FavContainer(),
    const FavContainer(),
    const FavContainer(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFFAFAFA),
        appBar: AppBarWidget(
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
                mainAxisSpacing: 0,
                crossAxisSpacing: 14,
                childAspectRatio: 0.6,
                mainAxisExtent: 200),
            itemCount: favouriteContainer.length,
            // ignore: non_constant_identifier_names
            itemBuilder: (BuildContext, index) {
              return SizedBox(child: favouriteContainer[index]);
            },
          ),
        ),
      ),
    );
  }
}

class FavContainer extends StatelessWidget {
  const FavContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 170,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(
                      0, 0.3), // changes the position of the shadow
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  child: Text(
                    '2 Room Apartment',
                    style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₦ 750K/Year',
                      style: TextStyle(
                          color: AppColors.textColor.withOpacity(0.8),
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
                    ),
                    const Icon(
                      Icons.favorite,
                      size: 22,
                      color: Colors.red,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          height: 110,
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
      ],
    );
  }
}
