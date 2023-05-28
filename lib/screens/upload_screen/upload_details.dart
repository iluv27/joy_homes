import 'package:flutter/material.dart';
import 'package:joy_homes/screens/upload_screen/upload_constants.dart';
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
  const UploadDetailsEntry({super.key});

  @override
  State<UploadDetailsEntry> createState() => _UploadDetailsEntryState();
}

class _UploadDetailsEntryState extends State<UploadDetailsEntry> {
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.75,
          child: Stack(children: [
            Container(
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
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: Stack(children: [
                Align(
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
                      ]),
                ),
              ]),
            ),
          ]),
        ),
        UploadDetailsForm()
      ],
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
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 1,
      child: ListView(
        controller: scrollController,
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
              child: Column(
                children: [
                  InputField(
                    textEditingController: email,
                    onInputChanged: ((value) {
                      value = email.text;
                    }),
                    innerText: '2 bedroom flat',
                    validatorText: 'Please enter your email',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Send data to the server
                      }
                    },
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
                        Text('Log in',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
