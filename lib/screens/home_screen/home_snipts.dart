import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';

class DetailHeadings extends StatelessWidget {
  const DetailHeadings({super.key, required this.detailHeading});

  final String detailHeading;

  @override
  Widget build(BuildContext context) {
    return Text(
      detailHeading,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    );
  }
}

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;

  ExpandableText({required this.text, this.maxLines = 2});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 16,
      height: 1.4,
      color: AppColors.textColor.withOpacity(0.8),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          firstChild: Text(
            widget.text,
            style: textStyle,
            maxLines: widget.maxLines,
            overflow: TextOverflow.ellipsis,
          ),
          secondChild: Text(
            widget.text,
            style: textStyle,
          ),
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Container(
                width: 100,
                height: 30,
                padding: const EdgeInsets.only(top: 8.0),
                child: isExpanded
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Read Less',
                            style: TextStyle(
                              color: Color.fromARGB(255, 13, 192, 82),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_up_rounded,
                            color: Color.fromARGB(255, 13, 192, 82),
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Read More',
                            style: TextStyle(
                              color: Color.fromARGB(255, 13, 192, 82),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.expand_more_rounded,
                            color: Color.fromARGB(255, 13, 192, 82),
                          ),
                        ],
                      )),
          ),
        ),
      ],
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
