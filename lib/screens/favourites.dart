import 'package:flutter/material.dart';
import 'package:joy_homes/screens/screen_constants.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({super.key});

  final List favouriteContainer = [
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
          appBar: const AppBarWidget(title: 'Favourites', height: 60),
          body: Container(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: const FavContainer())),
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
          width: MediaQuery.of(context).size.width * 0.34,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset:
                      const Offset(0, 1), // changes the position of the shadow
                ),
              ]),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    '2 Room Apartment',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          height: 120,
          width: MediaQuery.of(context).size.width * 0.34,
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


//  GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               mainAxisSpacing: 10,
//               crossAxisSpacing: 10,
//               childAspectRatio: 0.8,
//             ),
//             itemCount: favouriteContainer.length,
//             itemBuilder: (context, index) {
//               return Container(height: 200, child: favouriteContainer[index]);
//             },
//           ),
//         ),