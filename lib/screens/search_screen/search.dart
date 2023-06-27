// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:joy_homes/profile/profile_constants.dart';
import 'package:joy_homes/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:joy_homes/screens/upload_screen/upload_constants.dart';

final List<String> imgList = [
  'https://cdn.pixabay.com/photo/2016/11/18/17/46/house-1836070_1280.jpg',
  'https://cdn.pixabay.com/photo/2016/11/18/17/20/living-room-1835923_1280.jpg',
  'https://cdn.pixabay.com/photo/2015/10/20/18/57/furniture-998265_1280.jpg',
  'https://cdn.pixabay.com/photo/2017/08/27/10/16/interior-2685521_1280.jpg',
  'https://cdn.pixabay.com/photo/2016/12/30/07/59/kitchen-1940174_1280.jpg',
  'https://cdn.pixabay.com/photo/2016/12/30/07/59/kitchen-1940174_1280.jpg',
  'https://cdn.pixabay.com/photo/2016/12/30/07/59/kitchen-1940174_1280.jpg',
  'https://cdn.pixabay.com/photo/2016/12/30/07/59/kitchen-1940174_1280.jpg',
  'https://cdn.pixabay.com/photo/2016/12/30/07/59/kitchen-1940174_1280.jpg',
  'https://cdn.pixabay.com/photo/2016/12/30/07/59/kitchen-1940174_1280.jpg',
  'https://cdn.pixabay.com/photo/2016/12/30/07/59/kitchen-1940174_1280.jpg',
  'https://cdn.pixabay.com/photo/2016/12/30/07/59/kitchen-1940174_1280.jpg',
  'https://cdn.pixabay.com/photo/2014/07/10/17/17/bedroom-389254_1280.jpg'
];

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
  SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController price = TextEditingController();

  RangeValues _sliderValue = RangeValues(700000, 2000000);

  void openEndDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  late AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 300),
  );

  late Animation<Offset> _drawerAnimation = Tween<Offset>(
    begin: Offset(1.0, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInOut,
  ));

  @override
  void initState() {
    super.initState();
    _drawerAnimation;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SlideTransition(
        position: _drawerAnimation,
        child: Drawer(
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.88,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Filter',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(width: 5.0),
                                    Icon(
                                      Icons.filter_list_rounded,
                                      color: AppColors.secondary,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Price',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                RangeSlider(
                                  values: _sliderValue,
                                  divisions: 5,
                                  min: 200000.0,
                                  max: 3000000.0,
                                  onChanged: (RangeValues values) {
                                    setState(() {
                                      _sliderValue = values;
                                    });
                                  },
                                  activeColor: AppColors.secondary,
                                  inactiveColor:
                                      AppColors.primary.withOpacity(0.5),
                                  labels: RangeLabels(
                                    _sliderValue.start.round().toString(),
                                    _sliderValue.end.round().toString(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CountFormField(
                              labelText: 'Bathroom',
                              initialValue: 3,
                              minValue: 0,
                              maxValue: 10,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CountFormField(
                              labelText: 'Bedroom',
                              initialValue: 3,
                              minValue: 0,
                              maxValue: 10,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ToggleDetailsButtons(
                              sizedBoxWidth: 5,
                              toggleTitle: 'Parking Space',
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // if (_formKey.currentState!.validate()) {
                                //   _formKey.currentState!.save();
                                //   // Send data to the server
                                // }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                fixedSize: const Size(200, 50),
                              ),
                              child: Text(
                                '102 Results',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(
                              color: AppColors.textColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      endDrawer: ProfileDetails(),
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
              'Search',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          height: 60),
      body: SearchScreenDetails(
        scaffoldKey: _scaffoldKey,
        drawerAnimation: _drawerAnimation,
        animationController: _animationController,
      ),
    );
  }
}

// ignore: must_be_immutable
class SearchScreenDetails extends StatefulWidget {
  SearchScreenDetails(
      {super.key,
      required this.scaffoldKey,
      required this.drawerAnimation,
      required this.animationController});

  GlobalKey<ScaffoldState> scaffoldKey;

  Animation<Offset> drawerAnimation;

  AnimationController animationController;

  @override
  State<SearchScreenDetails> createState() => _SearchScreenDetailsState();
}

class _SearchScreenDetailsState extends State<SearchScreenDetails>
    with SingleTickerProviderStateMixin {
  void openProfileDrawer() {
    widget.scaffoldKey.currentState?.openDrawer();
    widget.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 47,
                margin: const EdgeInsets.only(
                    left: 25, top: 30, bottom: 30, right: 0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.secondary,
                    width: 0.6,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  style:
                      const TextStyle(fontSize: 16, color: AppColors.textColor),
                  cursorColor: AppColors.primary,
                  cursorHeight: 20,
                  cursorWidth: 1,
                  decoration: InputDecoration(
                      prefix: const SizedBox(
                        width: 20,
                      ),
                      hintText: '2 bedroom apartment?',
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon:
                            const Icon(Icons.search, color: AppColors.primary),
                        onPressed: () {},
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                iconSize: 40,
                icon: const Icon(Icons.more_vert,
                    color: Color.fromARGB(255, 115, 57, 16)),
                onPressed: () {
                  setState(() {
                    openProfileDrawer();
                  });
                },
              ),
            )
          ],
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: imgList.length,
              // ignore: non_constant_identifier_names
              itemBuilder: (BuildContext, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: CachedNetworkImage(
                      imageUrl: imgList[index],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.white,
                          ),
                        ),
                        baseColor: Colors.grey[400]!,
                        highlightColor: Colors.grey[100]!,
                        direction: ShimmerDirection.ltr,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
