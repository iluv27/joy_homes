import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';

TextStyle headingStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: AppColors.textColor,
);

TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textColor.withOpacity(0.8),
    height: 1.3);

Align heading(String text) {
  return Align(
    alignment: Alignment.topLeft,
    child: Text(
      text,
      style: headingStyle,
      textAlign: TextAlign.justify,
    ),
  );
}

Align body(String text) {
  return Align(
    alignment: Alignment.topLeft,
    child: Text(
      text,
      style: bodyStyle,
      textAlign: TextAlign.justify,
    ),
  );
}

// BULLET LIST STYLE
class BulletText extends StatelessWidget {
  final String text;

  const BulletText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 6),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.secondary,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: body(text),
        ),
      ],
    );
  }
}
