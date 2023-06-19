import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';

// ignore: must_be_immutable

class ListTileBar extends StatelessWidget {
  const ListTileBar(
      {super.key,
      required this.iconData,
      this.onTapped,
      required this.listTitle});

  final Function()? onTapped;
  final IconData iconData;
  final String listTitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        trailing: Icon(
          iconData,
          color: AppColors.textColor.withOpacity(0.6),
          size: 22,
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            listTitle,
            style: TextStyle(color: AppColors.textColor.withOpacity(0.8)),
          ),
        ),
        onTap: onTapped);
  }
}
