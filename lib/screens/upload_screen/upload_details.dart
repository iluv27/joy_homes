import 'package:flutter/material.dart';
import 'package:joy_homes/screens/upload_screen/upload_constants.dart';
import 'package:joy_homes/screens/upload_screen/upload_locate.dart';
import 'package:joy_homes/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:joy_homes/main.dart';
import 'upload_popUp.dart';

class UploadDetails extends StatelessWidget {
  UploadDetails({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Provider.of<AuthenticationProvider>(context, listen: false)
              .identity ==
          'user') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return RegisterWidget();
          },
        );
      }
    });

    return Scaffold(
        appBar: AppBar(
          leadingWidth: 40,
          leading: IconButton(
              padding: EdgeInsets.only(left: 20),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.textColor,
              )),
          title: Text('Go back'),
          centerTitle: false,
        ),
        body: UploadDetailsEntry());
  }
}

class UploadDetailsEntry extends StatefulWidget {
  const UploadDetailsEntry({Key? key});

  @override
  State<UploadDetailsEntry> createState() => _UploadDetailsEntryState();
}

class _UploadDetailsEntryState extends State<UploadDetailsEntry> {
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.75,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.75,
                  child: CarouselSlider(
                    carouselController: _controller,
                    options: CarouselOptions(
                      aspectRatio: 16 / 12,
                      viewportFraction: 1,
                    ),
                    items: selectedImages
                        .map(
                          (item) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(item),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment(0, -0.1),
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          UploadDetailsForm(),
        ],
      ),
    );
  }
}

class UploadDetailsForm extends StatefulWidget {
  const UploadDetailsForm({super.key});

  @override
  State<UploadDetailsForm> createState() => _UploadDetailsFormState();
}

class _UploadDetailsFormState extends State<UploadDetailsForm> {
  ScrollController? scrollController;

  final _formKey = GlobalKey<FormState>();

  TextEditingController tagLine = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController rentController = TextEditingController();
  String rentPerWhat = 'Year';
  String? rent;

  int bedroom = 1;
  int bathroom = 1;
  int toilet = 1;
  int waterHeater = 0;
  int wardrobe = 0;
  int balcony = 0;
  String fences = 'Yes';
  String parkingSpace = 'Yes';
  String availability = 'Yes';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            InputField(
              inputTitle: 'Tag line',
              textEditingController: tagLine,
              onInputChanged: ((value) {
                value = tagLine.text;
              }),
              innerText: '2 bedroom flat',
              validatorText: 'Please enter your email',
            ),
            DescriptionTextField(controller: descriptionController),
            RentTextField(
              controller: rentController,
              onValueChanged: (value) {
                setState(() {
                  // Handle the input value here
                  rentController.text = value;
                });
              },
              onSelectedValueChanged: (selectedValue) {
                // Handle the selected value here
                setState(() {
                  rentPerWhat = selectedValue;
                });
              },
            ),
            SizedBox(
              height: 30,
            ),

            // THIS IS THE FIRST ROW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CountFormField(
                    selectedValue: bedroom,
                    labelText: 'Bedroom',
                    initialValue: 1,
                    minValue: 0,
                    maxValue: 10,
                    onCountChanged: (value) {
                      setState(() {
                        bedroom = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CountFormField(
                    selectedValue: bathroom,
                    labelText: 'Bathroom',
                    initialValue: 1,
                    minValue: 0,
                    maxValue: 10,
                    onCountChanged: (value) {
                      setState(() {
                        bathroom = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CountFormField(
                    selectedValue: toilet,
                    labelText: 'Toilet',
                    initialValue: 1,
                    minValue: 0,
                    maxValue: 10,
                    onCountChanged: (value) {
                      setState(() {
                        toilet = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),

            // THIS IS THE SECOND ROW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CountFormField(
                    selectedValue: waterHeater,
                    labelText: 'Water Heater',
                    initialValue: 0,
                    minValue: 0,
                    maxValue: 10,
                    onCountChanged: (value) {
                      setState(() {
                        waterHeater = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CountFormField(
                    selectedValue: wardrobe,
                    labelText: 'Wardrobe',
                    initialValue: 0,
                    minValue: 0,
                    maxValue: 10,
                    onCountChanged: (value) {
                      setState(() {
                        wardrobe = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CountFormField(
                    selectedValue: balcony,
                    labelText: 'Balcony',
                    initialValue: 0,
                    minValue: 0,
                    maxValue: 10,
                    onCountChanged: (value) {
                      setState(() {
                        balcony = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),

            // WATER HEATER AND PARKING SPACE CODE

            Row(
              children: [
                Expanded(
                    child: ToggleDetailsButtons(
                  onSelectedValueChanged: (value) {
                    setState(() {
                      fences = value;
                    });
                  },
                  sizedBoxWidth: 5,
                  toggleTitle: 'Fences',
                )),
                SizedBox(
                  width: 25,
                ),
                Expanded(
                    child: ToggleDetailsButtons(
                  onSelectedValueChanged: (value) {
                    setState(() {
                      parkingSpace = value;
                    });
                  },
                  toggleTitle: 'Parking Space',
                  sizedBoxWidth: 5,
                )),
              ],
            ),
            SizedBox(
              height: 30,
            ),

            // AVAILABE SPACE CODE
            ToggleDetailsButtons(
                onSelectedValueChanged: (value) {
                  setState(() {
                    availability = value;
                  });
                },
                sizedBoxWidth: 10,
                toggleTitle: 'Is this apartment currently available?'),

            const SizedBox(height: 40),
            BottomNavButton(
              formKey: _formKey,
              bottomFunctionality: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Send data to the server
                }

                // CONVERTING RENT TO PRICES

                String formatPrice(int price) {
                  if (price >= 1000000) {
                    double formattedPrice = price / 1000000;
                    return '${formattedPrice.toStringAsFixed(formattedPrice.truncateToDouble() == formattedPrice ? 0 : 1)}M';
                  } else if (price >= 1000) {
                    double formattedPrice = price / 1000;
                    return '${formattedPrice.toStringAsFixed(formattedPrice.truncateToDouble() == formattedPrice ? 0 : 1)}K';
                  } else {
                    return price.toString();
                  }
                }

                // rent = '${rentController.text}/$rentPerWhat';

                int price = int.parse(rentController.text);

                rent = '${formatPrice(price)}/$rentPerWhat';

                try {
                  await Provider.of<HouseProvider>(context, listen: false)
                      .setHouseDetails(
                          tagLine: tagLine.text,
                          description: descriptionController.text,
                          rent: rent,
                          bedroom: bedroom,
                          bathroom: bathroom,
                          toilet: toilet,
                          waterHeater: waterHeater,
                          wardrobe: wardrobe,
                          balcony: balcony,
                          fence: fences,
                          parkingSpace: parkingSpace,
                          availability: availability);

                  await Provider.of<HouseProvider>(context, listen: false)
                      .saveHouseImages(selectedImages);
                } catch (e) {
                  print('this is the house upload error: $e');
                }

                Navigator.push(context, MaterialPageRoute(builder: (Context) {
                  return UploadLocate();
                }));
              },
              buttonTitle: 'Next',
              buttonIcon: Icon(Icons.navigate_next),
            ),
          ],
        ),
      ),
    );
  }
}
