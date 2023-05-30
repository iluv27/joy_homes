import 'package:flutter/material.dart';
import 'package:joy_homes/screens/upload_screen/upload_constants.dart';
import 'package:joy_homes/screens/upload_screen/upload_locate.dart';
import 'package:joy_homes/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';

class UploadDetails extends StatelessWidget {
  const UploadDetails({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: UploadDetailsEntry(),
    );
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: SingleChildScrollView(
        child: Padding(
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
                RentTextField(controller: rentController),
                SizedBox(
                  height: 30,
                ),

                // THIS IS THE FIRST ROW
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CountFormField(
                        labelText: 'Bedroom',
                        initialValue: 2,
                        minValue: 0,
                        maxValue: 10,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CountFormField(
                        labelText: 'Bathroom',
                        initialValue: 3,
                        minValue: 0,
                        maxValue: 10,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CountFormField(
                        labelText: 'Toilet',
                        initialValue: 1,
                        minValue: 0,
                        maxValue: 10,
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
                        labelText: 'Water Heater',
                        initialValue: 1,
                        minValue: 0,
                        maxValue: 10,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CountFormField(
                        labelText: 'Wardrobe',
                        initialValue: 1,
                        minValue: 0,
                        maxValue: 10,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CountFormField(
                        labelText: 'Balcony',
                        initialValue: 0,
                        minValue: 0,
                        maxValue: 10,
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
                      sizedBoxWidth: 5,
                      toggleTitle: 'Fences',
                    )),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                        child: ToggleDetailsButtons(
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
                    sizedBoxWidth: 10,
                    toggleTitle: 'Is this apartment currently available?'),

                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Send data to the server
                    }
                    Navigator.push(context,
                        MaterialPageRoute(builder: (Context) {
                      return UploadLocate();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fixedSize: const Size(double.infinity, 55),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Icon(Icons.navigate_next),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
