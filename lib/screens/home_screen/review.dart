// ignore_for_file: unused_field, must_be_immutable

import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';
import 'package:joy_homes/screens/upload_screen/upload_constants.dart';

class ReviewPage extends StatefulWidget {
  ReviewPage({super.key});

  ReviewSection? _reviewSection;

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int starRating = 0;
  String reviewContent = '';
  List<ReviewSection> _reviewSections = [];

  void submitReview() {
    //  if (_formKey.currentState!.validate()) {
    //                         _formKey.currentState!.save();}
    final Review? review;
    review = Review(
      userName: 'John Doe', // You can customize the username here
      starRating: starRating,
      reviewContent: reviewContent,
    );
    final newReviewSection = ReviewSection(review: review);
    setState(() {
      _reviewSections.add(newReviewSection);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 40,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.navigate_before_rounded,
            color: AppColors.textColor,
            size: 36,
          ),
        ),
        title: Text(
          'Reviews',
          style: TextStyle(color: AppColors.textColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textColor.withOpacity(0.05),
                      blurRadius: 5,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Form(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 0,
                          child: SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CountFormField(
                                    labelText: 'Ratings',
                                    initialValue: 1,
                                    minValue: 1,
                                    maxValue: 5,
                                    onTapped: (value) {
                                      setState(() {
                                        starRating = int.tryParse(value) ?? 1;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                ),
                                Row(
                                  children: List.generate(5, (index) {
                                    final isSelected = index < starRating;
                                    return Icon(
                                      isSelected
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: isSelected
                                          ? Colors.black
                                          : Colors.grey,
                                      size: 20,
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          flex: 0,
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                reviewContent = value;
                              });
                            },
                            textAlignVertical: TextAlignVertical.top,
                            textAlign: TextAlign.justify,
                            cursorColor: AppColors.secondary,
                            decoration: InputDecoration(
                              enabled: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 0,
                              ),
                              hintText: 'Give a review',
                              suffix: Icon(
                                Icons.border_color_rounded,
                                size: 18,
                                color: AppColors.secondary,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 0.5,
                                  color: AppColors.secondary,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 0.5,
                                  color: AppColors.textColor.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: submitReview,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            fixedSize: const Size(200, 50),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person),
                              SizedBox(width: 10.0),
                              Text('Submit',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 2,
              child: ListView.builder(
                itemCount: _reviewSections.length,
                itemBuilder: (context, index) {
                  return _reviewSections[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewSection extends StatelessWidget {
  final Review review;

  const ReviewSection({required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: AppColors.textColor.withOpacity(0.05),
              blurRadius: 5,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review.userName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < review.starRating
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.black,
                      size: 18,
                    );
                  }),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              review.reviewContent,
              style: TextStyle(
                fontSize: 16,
                height: 1.4,
                color: AppColors.textColor.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Review {
  final String userName;
  final int starRating;
  final String reviewContent;

  Review({
    required this.userName,
    required this.starRating,
    required this.reviewContent,
  });
}
