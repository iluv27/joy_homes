import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';

Widget buildReviewWidget(ReviewSection reviewSection) {
  return ReviewSection(review: reviewSection.review);
}

List<ReviewSection> reviewSections = [];

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
