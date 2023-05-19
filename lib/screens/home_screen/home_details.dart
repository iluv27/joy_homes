// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../screen_constants.dart';
import 'package:joy_homes/theme.dart';

class HomeDetailsScreen extends StatefulWidget {
  const HomeDetailsScreen({super.key});

  @override
  State<HomeDetailsScreen> createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.textColor,
                )),
            title: 'House Info',
            height: 60),
        body: const HouseInfoToggle());
  }
}

class HouseInfoToggle extends StatefulWidget {
  const HouseInfoToggle({super.key});

  @override
  _HouseInfoToggleState createState() => _HouseInfoToggleState();
}

class _HouseInfoToggleState extends State<HouseInfoToggle>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  bool isContainerVisible = true;

  @override
  void initState() {
    super.initState();
  }

  void _handleButtonClick(int index) {
    setState(() {
      if (selectedIndex != index) {
        selectedIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: OutlinedButton.icon(
                  onPressed: () {
                    _handleButtonClick(0);

                    // Handle onPressed event for outlined button
                  },
                  icon: const Icon(
                    Icons.info_outline,
                    color: AppColors.primary,
                    size: 20,
                  ), // Add desired icon
                  label: Text(
                    'Details',
                    style: TextStyle(
                        color: selectedIndex == 0
                            ? Colors.white
                            : AppColors.textColor,
                        fontSize: 16),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor:
                        selectedIndex == 0 ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: BorderSide(
                      color: selectedIndex == 0
                          ? AppColors.secondary
                          : AppColors.secondary,
                    ),
                    backgroundColor: selectedIndex == 0
                        ? AppColors.secondary
                        : Colors.transparent,
                    minimumSize: const Size(150, 45),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    _handleButtonClick(1);

                    // Handle onPressed event for filled button
                  },
                  icon: const Icon(
                    Icons.share_location,
                    size: 20,
                    color: AppColors.primary,
                  ), // Add desired icon
                  label: Text(
                    'Locate',
                    style: TextStyle(
                        fontSize: 16,
                        color: selectedIndex == 1
                            ? Colors.white
                            : AppColors.textColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: BorderSide(
                      color: selectedIndex == 1
                          ? AppColors.secondary
                          : AppColors.secondary,
                    ),
                    backgroundColor:
                        selectedIndex == 1 ? AppColors.secondary : Colors.white,
                    minimumSize: const Size(150, 45),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Stack(
              children: [
                selectedIndex == 0 ? const DetailsPage() : const LocatePage()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
            height: 260,
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
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 110,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.secondary,
                  width: 1.0,
                ),
                bottom: BorderSide(
                  color: AppColors.secondary,
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
                  alignment: Alignment.bottomCenter,
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
                )
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

class LocatePage extends StatefulWidget {
  const LocatePage({super.key});

  @override
  State<LocatePage> createState() => _LocatePageState();
}

class _LocatePageState extends State<LocatePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
