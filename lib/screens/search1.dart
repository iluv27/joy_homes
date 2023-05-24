import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  RangeValues _currentRangeValues = const RangeValues(700000, 15000000);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0XFFFAFAFA),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset('assets/images/logo.png', scale: 4.5),
            ),
            Expanded(
              flex: 0,
              // ignore: avoid_unnecessary_containers
              child: Container(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 150,
                        child: SliderTheme(
                          data: const SliderThemeData(
                              trackHeight: 4,
                              overlayColor: AppColors.textColor),
                          child: RangeSlider(
                            inactiveColor: AppColors.primary,
                            activeColor: AppColors.secondary,
                            values: _currentRangeValues,
                            divisions: 5,
                            max: 50000000,
                            labels: RangeLabels(
                              _currentRangeValues.start.round().toString(),
                              _currentRangeValues.end.round().toString(),
                            ),
                            onChanged: (RangeValues values) {
                              setState(() {
                                _currentRangeValues = values;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.brown,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButton(
                              underline: Container(),
                              isExpanded: true,
                              iconSize: 40,
                              iconEnabledColor:
                                  AppColors.textColor.withOpacity(0.5),
                              hint: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  'State',
                                  style: TextStyle(
                                      color:
                                          AppColors.textColor.withOpacity(0.7),
                                      fontSize: 16),
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'option1',
                                  child: Text('Option 1'),
                                ),
                                DropdownMenuItem(
                                  value: 'option2',
                                  child: Text('Option 2'),
                                ),
                              ],
                              onChanged: (value) {
                                // Do something with the selected value
                              },
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 1.2,
                            color: AppColors.secondary,
                          ),
                          Expanded(
                            child: DropdownButton(
                              underline: Container(),
                              isExpanded: true,
                              iconSize: 42,
                              iconEnabledColor:
                                  AppColors.textColor.withOpacity(0.5),
                              hint: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  'Area',
                                  style: TextStyle(
                                      color:
                                          AppColors.textColor.withOpacity(0.7),
                                      fontSize: 16),
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'option3',
                                  child: Text('Option 3'),
                                ),
                                DropdownMenuItem(
                                  value: 'option4',
                                  child: Text('Option 4'),
                                ),
                              ],
                              onChanged: (value) {
                                // Do something with the selected value
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 47,
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primary,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                style:
                    const TextStyle(fontSize: 16, color: AppColors.textColor),
                cursorColor: AppColors.primary,
                cursorHeight: 20,
                cursorWidth: 1,
                decoration: InputDecoration(
                    prefix: const SizedBox(
                      width: 20,
                    ),
                    hintText: '2 bedroom apartment?',
                    border: InputBorder.none,
                    suffixIcon: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      width: 10,
                      child: IconButton(
                        icon: const Icon(Icons.search, color: Colors.white),
                        onPressed: () {},
                      ),
                    )),
              ),
            ),
            Expanded(flex: 2, child: Container())
          ],
        ),
      ),
    );
  }
}
