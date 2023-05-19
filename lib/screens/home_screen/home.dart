// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../screen_constants.dart';
import 'home_constants.dart';

Map<String, List<String>> imageMap = {
  'Category 1': [
    'house1.jpg',
    'house2.jpg',
    'house3.jpg',
  ],
  'Category 2': [
    'house4.jpg',
    'house1.jpg',
    'house2.jpg',
  ],
};

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
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
          title: 'Apartments',
          height: 60,
        ),
        body: const HouseContainer(),
      ),
    );
  }
}

class HouseContainer extends StatelessWidget {
  const HouseContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        HouseItem(),
        HouseItem(),
        HouseItem(),
      ],
    );
  }
}

class HouseItem extends StatefulWidget {
  const HouseItem({
    super.key,
  });

  @override
  State<HouseItem> createState() => _HouseItemState();
}

class _HouseItemState extends State<HouseItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 35.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const HomeDetailsScreen();
            }));
          },
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/house1.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      const Positioned(
                        top: 20,
                        right: 10,
                        height: 100,
                        child: Column(
                          children: [
                            Icon(
                              Icons.favorite,
                              size: 50,
                              color: Colors.white,
                            ),
                            Text(
                              '200',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          height: 100,
                          width: double.infinity,
                          color: AppColors.textColor.withOpacity(0.8),
                          child: Stack(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'A 2 Bedroom Apartment',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.near_me,
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            size: 16,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Wuse II, Beside supermarket',
                                            style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.7)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    '₦ 750K/Year',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),

                              //Bottom 4 Items
                              const Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.bed,
                                          color: AppColors.smallIcons,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '2 beds',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.pool,
                                          color: AppColors.smallIcons,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '1 pool',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.room_service,
                                          color: AppColors.smallIcons,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '2 rooms',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.lightbulb,
                                          color: AppColors.smallIcons,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '24/7',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}
