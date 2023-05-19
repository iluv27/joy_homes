// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/house1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Image.asset(
                    'assets/images/house1.jpg',
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Image.asset('assets/images/house4.jpg'),
                  const SizedBox(
                    width: 20,
                  ),
                  Image.asset('assets/images/house2.jpg'),
                  const SizedBox(
                    width: 20,
                  ),
                  Image.asset('assets/images/house3.jpg'),
                  const SizedBox(
                    width: 20,
                  ),
                  Image.asset('assets/images/house4.jpg')
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 200,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.secondary.withOpacity(0.2),
                  width: 1.0,
                ),
                bottom: BorderSide(
                  color: AppColors.secondary.withOpacity(0.2),
                  width: 1.0,
                ),
              ),
            ),
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
                              color: AppColors.textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.near_me,
                              color: AppColors.secondary,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Wuse II, Beside supermarket',
                              style: TextStyle(
                                  color: AppColors.textColor.withOpacity(0.8)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Text(
                      '₦ 750K/Year',
                      style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),

                //Bottom 4 Items
                const Align(
                  alignment: Alignment.center,
                  widthFactor: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconContainer(
                            iconData: Icons.bed,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '2 beds',
                            style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconContainer(
                            iconData: Icons.pool,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '1 pool',
                            style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconContainer(
                            iconData: Icons.room_service,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '2 rooms',
                            style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconContainer(
                            iconData: Icons.lightbulb,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '24/7',
                            style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                              const Size(double.infinity, 45),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.contactColor),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Contact Agent',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          )),
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Information',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'It is a fully functioning two bedroom flat, all just to accommodate your needs. It has two bedrooms, 3 bathrooms (each with heaters)',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textColor.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Features',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 8),
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(left: 15, bottom: 20),
                  children: const [
                    FeaturesItems(
                      featuresListItem: 'Two Bedroom',
                    ),
                    FeaturesItems(
                      featuresListItem: 'Three Bathroom',
                    ),
                    FeaturesItems(
                      featuresListItem: 'One garage',
                    ),
                    FeaturesItems(
                      featuresListItem: 'A basement',
                    ),
                    FeaturesItems(
                      featuresListItem: 'A swimming pool',
                    ),
                    FeaturesItems(
                      featuresListItem: 'A heater for each bathroom',
                    ),
                    FeaturesItems(
                      featuresListItem: 'AC for each room',
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FeaturesItems extends StatelessWidget {
  const FeaturesItems({super.key, required this.featuresListItem});

  final String featuresListItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Row(
        children: [
          const Icon(
            Icons.circle,
            size: 8,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            featuresListItem,
            style: TextStyle(
                fontSize: 16, color: AppColors.textColor.withOpacity(0.8)),
          )
        ],
      ),
    );
  }
}

class IconContainer extends StatelessWidget {
  const IconContainer({super.key, required this.iconData});

  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 25,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary,
      ),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(
          iconData,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }
}
