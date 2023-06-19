// ignore_for_file: unused_import, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../profile/profile_constants.dart';
import 'home_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

final List<String> imgList = [
  'https://cdn.pixabay.com/photo/2016/11/18/17/46/house-1836070_1280.jpg',
  'https://cdn.pixabay.com/photo/2016/11/18/17/20/living-room-1835923_1280.jpg',
  'https://cdn.pixabay.com/photo/2015/10/20/18/57/furniture-998265_1280.jpg',
  'https://cdn.pixabay.com/photo/2017/08/27/10/16/interior-2685521_1280.jpg',
  'https://cdn.pixabay.com/photo/2016/12/30/07/59/kitchen-1940174_1280.jpg',
  'https://cdn.pixabay.com/photo/2014/07/10/17/17/bedroom-389254_1280.jpg'
];

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, this.isLoggedIn = false});
  bool isLoggedIn;

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
          title: Image.asset(
            'assets/images/logo.png',
            scale: 6.7,
          ),
          height: 60,
        ),
        body: const HouseContainer(),
        endDrawer: ProfileDetails(),
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
  const HouseItem() : super();

  @override
  State<HouseItem> createState() => _HouseItemState();
}

class _HouseItemState extends State<HouseItem>
    with SingleTickerProviderStateMixin {
  final CarouselController _controller = CarouselController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  int _likeCount = 100;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    setState(() {
      if (_isLiked) {
        _likeCount -= 1;
        _animationController.reverse();
      } else {
        _likeCount += 1;
        _animationController.forward();
      }
      _isLiked = !_isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return const HomeDetailsScreen();
            }),
          );
        },
        onDoubleTap: _handleDoubleTap,
        child: Stack(
          children: [
            Container(
              child: CarouselSlider(
                carouselController: _controller,
                options: CarouselOptions(
                  aspectRatio: 16 / 16,
                  viewportFraction: 1,
                ),
                items: imgList
                    .map(
                      (item) => Container(
                        child: CachedNetworkImage(
                          imageUrl: item,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            child: Container(
                              color: Colors.white,
                            ),
                            baseColor: Colors.grey[400]!,
                            highlightColor: Colors.grey[100]!,
                            direction: ShimmerDirection.ltr,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                    top: 25,
                    right: 15,
                    height: 69,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: IconButton(
                            padding: EdgeInsets.all(0),
                            iconSize: 50,
                            alignment: Alignment.center,
                            onPressed: () {
                              _handleDoubleTap();
                            },
                            icon: Icon(
                              Icons.favorite,
                            ),
                            color: _animationController.isAnimating
                                ? Color.fromARGB(255, 255, 10, 10)
                                : Colors.white,
                          ),
                        ),
                        Text(
                          _likeCount.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          onPressed: () => _controller.previousPage(),
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () => _controller.nextPage(),
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
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
                                            color:
                                                Colors.white.withOpacity(0.7)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    '₦ 750K/Year',
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
                                        Icons.circle,
                                        color: const Color.fromARGB(
                                            255, 9, 255, 108),
                                        size: 14,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Available',
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.7)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),

                          //Bottom 4 Items
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
