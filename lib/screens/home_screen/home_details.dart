import 'package:flutter/material.dart';
import '../screen_constants.dart';
import 'package:joy_homes/theme.dart';

class HomeDetailsScreen extends StatefulWidget {
  const HomeDetailsScreen({super.key});

  @override
  State<HomeDetailsScreen> createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.textColor,
                )),
            title: 'House Info',
            height: 60),
        body: SlideContainerExample());
  }
}

class SlideContainerExample extends StatefulWidget {
  @override
  _SlideContainerExampleState createState() => _SlideContainerExampleState();
}

class _SlideContainerExampleState extends State<SlideContainerExample>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  bool isContainerVisible = true;

  @override
  void initState() {
    super.initState();
  }

  void _handleButtonClick(int index) {
    setState(() {
      if (selectedIndex != index) {
        selectedIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: OutlinedButton.icon(
                  onPressed: () {
                    _handleButtonClick(0);

                    // Handle onPressed event for outlined button
                  },
                  icon: const Icon(
                    Icons.info_outline,
                    color: AppColors.primary,
                    size: 20,
                  ), // Add desired icon
                  label: Text(
                    'Details',
                    style: TextStyle(
                        color: selectedIndex == 0
                            ? Colors.white
                            : AppColors.textColor,
                        fontSize: 16),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor:
                        selectedIndex == 0 ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: BorderSide(
                      color: selectedIndex == 0
                          ? AppColors.secondary
                          : AppColors.secondary,
                    ),
                    backgroundColor: selectedIndex == 0
                        ? AppColors.secondary
                        : Colors.transparent,
                    minimumSize: const Size(150, 45),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    _handleButtonClick(1);

                    // Handle onPressed event for filled button
                  },
                  icon: const Icon(
                    Icons.share_location,
                    size: 20,
                    color: AppColors.primary,
                  ), // Add desired icon
                  label: Text(
                    'Locate',
                    style: TextStyle(
                        fontSize: 16,
                        color: selectedIndex == 1
                            ? Colors.white
                            : AppColors.textColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: BorderSide(
                      color: selectedIndex == 1
                          ? AppColors.secondary
                          : AppColors.secondary,
                    ),
                    backgroundColor:
                        selectedIndex == 1 ? AppColors.secondary : Colors.white,
                    minimumSize: const Size(150, 45),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Stack(
              children: [
                selectedIndex == 0 ? const DetailsPage() : const LocatePage()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: const Center(
        child: Text('Main Content'),
      ),
    );
  }
}

class LocatePage extends StatefulWidget {
  const LocatePage({super.key});

  @override
  State<LocatePage> createState() => _LocatePageState();
}

class _LocatePageState extends State<LocatePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
