import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';

class ReviewSection extends StatelessWidget {
  final String userName;
  final int starRating;
  final String reviewContent;

  ReviewSection(
      {required this.userName,
      required this.starRating,
      required this.reviewContent});

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
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < starRating ? Icons.star : Icons.star_border,
                      color: Colors.black,
                      size: 18,
                    );
                  }),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              reviewContent,
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

class ReviewPage extends StatelessWidget {
  final ReviewSection reviewSection;

  ReviewPage({required this.reviewSection, this.index});

  final double? index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Review'),
        ),
        body: Column(
          children: [
            Expanded(
              child: TextField(),
            ),
            Expanded(
              child: ListView(),
            ),
          ],
        ));
  }
}

// onPressed: () {
//               // Navigate to review page and pass the full review content
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ReviewPage(
//                     reviewSection: this,
//                   ),
//                 ),
//               );
//             },