// ignore_for_file: unused_field, must_be_immutable

import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';
import 'review_terms.dart';

class ReviewPage extends StatefulWidget {
  ReviewPage({super.key});

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int starRating = 0;
  String reviewContent = '';

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
      reviewSections.insert(0, newReviewSection); // Insert at index 0
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                child: Form(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 0,
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 1; i <= 5; i++)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      starRating = i;
                                    });
                                  },
                                  child: Icon(
                                    i <= starRating
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: AppColors.textColor,
                                    size: 30,
                                  ),
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
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.justify,
                          cursorColor: AppColors.secondary,
                          decoration: InputDecoration(
                            enabled: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 0,
                            ),
                            hintText: 'Give a review',
                            suffixIcon: Icon(
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
                                color: AppColors.primary.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
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
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
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
                itemCount: reviewSections.length,
                itemBuilder: (context, index) {
                  return reviewSections[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
