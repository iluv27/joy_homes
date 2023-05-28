import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'upload_constants.dart';
import 'package:joy_homes/theme.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const UploadImages();
  }
}

class UploadImages extends StatefulWidget {
  const UploadImages({Key? key}) : super(key: key);

  @override
  _UploadImagesState createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {
  void pickPhotos() async {
    List<XFile>? photosList = await ImagePicker().pickMultiImage(
      imageQuality: 100, // Set initial image quality to 100 (no compression)
    );

    // ignore: unnecessary_null_comparison
    if (photosList != null && photosList.isNotEmpty) {
      List<File> newImages = [];
      for (int i = 0; i < photosList.length; i++) {
        File imageFile = File(photosList[i].path);

        // Compress the image
        Uint8List? compressedBytes =
            await FlutterImageCompress.compressWithFile(
          imageFile.path,
          quality: 90, // Set the desired image quality (adjust as needed)
          minHeight: 1024 *
              1024, // Set the maximum file size in bytes (1MB in this case)
        );

        // Create a new File with the compressed bytes
        File compressedImage = File(imageFile.path);
        await compressedImage.writeAsBytes(compressedBytes!);

        newImages.add(compressedImage);
      }

      setState(() {
        selectedImages.addAll(newImages);
      });
    }
  }

  Widget buildSelectedImages() {
    return Container(
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 0.8,
        children: selectedImages.map((File image) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: FileImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImages.remove(image);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(3),
                    child: Icon(
                      Icons.delete,
                      size: 12,
                      color: const Color.fromARGB(255, 231, 108, 99),
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget2(
          preferredSize1: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.secondary.withOpacity(0.4),
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              'Upload Screen',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          height: 60,
          showForwardIcon: selectedImages.isNotEmpty,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Stack(
            children: [
              buildSelectedImages(),
              selectedImages.isEmpty
                  ? Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.textColor.withOpacity(
                                  0.1), // Adjust the opacity for a more blended shadow effect
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Please click the button below to select images of a home. Long press an image to select more than one.',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor,
                              fontSize: 16,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  : Visibility(visible: false, child: Container()),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {
                      pickPhotos();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fixedSize: const Size(200, 50),
                    ),
                    child: Text(
                      'Select Images',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}




//  if (imageList != null) {
//       List<File> compressedImages = [];
//       for (XFile imageFile in imageList) {
//         final tempDir = await getTemporaryDirectory();
//         // ignore: unused_local_variable
//         final path = tempDir.path;
//         final File compressedImageFile = File(imageFile.path);
//         compressedImages.add(compressedImageFile);
//       }
//       setState(() {
//         selectedImages.addAll(compressedImages);
//       });
//     }



  // Future<void> showRegistrationPrompt(BuildContext context) async {
  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Registration Required'),
  //         content: Text('You need to be registered to upload images.'),
  //         actions: [
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  //   ElevatedButton(
  //           onPressed: () {
  //             pickImages();
  //             // Check if user is registered here
  //             // bool isRegistered = false; // Replace with your registration logic
  //             // if (isRegistered) {
  //             //   pickImages();
  //             // } else {
  //             //   showRegistrationPrompt(context);
  //             // }
  //           },
  //           child: Text('Select Images'),
  //         ),