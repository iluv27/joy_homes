import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFFAFAFA),
        appBar: AppBar(
          title: const Text('Apartments'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.primary, // set border color
                    width: 1.5, // set border width
                  ),
                  shape: BoxShape.circle, // set container shape to circle
                ),
                child: const CircleAvatar(
                  maxRadius: 22,
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.person,
                    color: AppColors.textColor,
                    size: 26,
                  ),
                ),
              ),
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(8.0),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.secondary,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.only(top: 15.0),
          child: HouseContainer(),
        ),
      ),
    );
  }
}

class HouseContainer extends StatelessWidget {
  const HouseContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: const [
        HouseItem(),
        HouseItem(),
        HouseItem(),
      ],
    );
  }
}

class HouseItem extends StatelessWidget {
  const HouseItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/house1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 20,
                right: 10,
                height: 100,
                child: Column(
                  children: const [
                    Icon(
                      Icons.favorite,
                      size: 50,
                      color: Colors.white,
                    ),
                    Text(
                      '200',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  height: 100,
                  width: double.infinity,
                  color: AppColors.textColor.withOpacity(0.8),
                  child: Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    color: Colors.white.withOpacity(0.7),
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Wuse II, Beside supermarket',
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.7)),
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
                      Positioned(
                        bottom: 0,
                        height: null,
                        width: MediaQuery.of(context).size.width * 0.94,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
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
                              children: const [
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
                              children: const [
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
                              children: const [
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
    );
  }
}
