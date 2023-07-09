// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'home_snipts.dart';
import 'reviews/review.dart';
import 'reviews/review_terms.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';
import 'package:joy_homes/main.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final CarouselController _controller = CarouselController();
  int pageIndex = 0;
  bool toggleSwitch = true;

  List<Widget> getTopReviewSection(List<ReviewSection> reviewSections) {
    List<Widget> topReviewWidgets = [];

    if (reviewSections.isEmpty) {
      return topReviewWidgets;
    }

    List<ReviewSection> topReviews = List.from(reviewSections);
    topReviews
        .sort((a, b) => b.review.starRating.compareTo(a.review.starRating));
    topReviews = topReviews.take(3).toList();

    // Iterate over the top review sections and create widgets
    for (ReviewSection reviewSection in topReviews) {
      Widget reviewWidget = buildReviewWidget(reviewSection);
      // Replace with your own widget builder function

      setState(() {
        topReviewWidgets.insert(0, reviewWidget);
      });
    }

    return topReviewWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HouseProvider>(builder: (context, authProvider, child) {
      return Container(
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  child: CarouselSlider(
                    carouselController: _controller,
                    options: CarouselOptions(
                      aspectRatio: 16 / 11,
                      viewportFraction: 1,
                      onPageChanged: (index, _) {
                        setState(() {
                          pageIndex = index;
                        });
                      },
                    ),
                    items: authProvider.imageUrls
                        .map(
                          (item) => Container(
                            child: CachedNetworkImage(
                              imageUrl: item,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                child: Container(
                                  color: Colors.white,
                                ),
                                baseColor: Colors.grey[300]!,
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
                  height: 255,
                  child: Align(
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
                        ]),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                itemCount: authProvider.imageUrls.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        pageIndex = index;
                        _controller.animateToPage(pageIndex);
                      });
                    },
                    child: Container(
                      width: 80,
                      height: 100,
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: index == pageIndex
                              ? AppColors.primary
                              : Colors.grey,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Container(
                        child: CachedNetworkImage(
                          imageUrl: authProvider.imageUrls[index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            child: Container(
                              color: Colors.white,
                            ),
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            direction: ShimmerDirection.ltr,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // THE DETAILS SECTION
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
                                    color:
                                        AppColors.textColor.withOpacity(0.8)),
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
                                color: AppColors.textColor,
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
                                color: const Color.fromARGB(255, 4, 202, 83),
                                size: 14,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Available',
                                style: TextStyle(
                                    color:
                                        AppColors.textColor.withOpacity(0.8)),
                              ),
                            ],
                          ),
                        ],
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
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return _Popup();
                                },
                              );
                            },
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

            // THE INFORMATION SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailHeadings(detailHeading: 'Information'),
                  const SizedBox(height: 10),
                  ExpandableText(
                    text:
                        'It is a fully functioning two bedroom flat, all just to accommodate your needs. It has two bedrooms, 3 bathrooms (each with heaters). There is a spacious garage for 3 cars and a pool where both children and adults can swim.',
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),

            // THE FEATURES SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailHeadings(detailHeading: 'Features'),
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
            ),
            const SizedBox(
              height: 10,
            ),

            // THE REVIEW SECTION
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
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
              child: Wrap(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ReviewPage();
                          }));
                        },
                        child: DetailHeadings(
                          detailHeading: 'Reviews',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ReviewPage();
                          }));
                        },
                        child: Row(
                          children: [
                            Text(
                              'Edit',
                              style: TextStyle(
                                color: AppColors.textColor,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.rate_review_outlined,
                              size: 14,
                              color: AppColors.secondary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: getTopReviewSection(reviewSections),
                  ),
                ],
              ),
            ),

            //  THE AVAILABILITY LISTILE
            ListTile(
              leading: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(children: [
                  DetailHeadings(detailHeading: 'Availability'),
                  SizedBox(
                    width: 7,
                  ),
                  GestureDetector(
                    child: Container(
                        height: 25,
                        width: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.primary,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(1000),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: CupertinoSwitch(
                            value: toggleSwitch,
                            onChanged: (bool value) {
                              setState(() {
                                toggleSwitch = value;
                              });
                            },
                            activeColor: AppColors.secondary,
                            trackColor: Colors.white,
                            thumbColor: toggleSwitch
                                ? Colors.white
                                : AppColors.secondary,
                          ),
                        )),
                  ),
                ]),
              ),
              trailing: SizedBox(
                width: 60,
                child: Row(
                  children: [
                    Text(
                      'Edit',
                      style: TextStyle(
                        color: AppColors.textColor,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.border_color_outlined,
                      size: 16,
                      color: AppColors.secondary,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

class _Popup extends StatelessWidget {
  const _Popup();

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    // final popupHeight = screenHeight / 1.9;

    return Stack(
      children: [
        Container(
          color: Colors.black54,
        ),
        AlertDialog(
          title: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primary, // set border color
                      width: 1, // set border width
                    ),
                    shape: BoxShape.circle, // set container shape to circle
                  ),
                  child: CircleAvatar(
                    maxRadius: 50,
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.person,
                      color: AppColors.textColor,
                      size: 22,
                    ),
                  ),
                ),
              ),
              Text(
                'Mr John Will',
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1.4,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  '08023456789',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColor.withOpacity(0.7)),
                ),
              ),
            ],
          ),
          actions: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.contactColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    fixedSize: const Size(200, 50),
                  ),
                  child: Text('Call',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ],
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}
