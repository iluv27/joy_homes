import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:math' as math;
import 'package:provider/provider.dart';
import 'package:joy_homes/main.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  // ignore: unused_field
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _sizeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String? identity;
  String? contactPreference;
  String? verificationMode;
  String? verificationImageUrl;
  File? uploadedFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFAFAFA),
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
          ),
        ),
        title: Text('Go back'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verify Identity',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SimpleDropdownButton(
              dropdownItems: ['Landlord', 'House Agent'],
              hintValue: 'Owner?',
              selectedValue: identity,
              onChanged: (value) async {
                setState(() {
                  identity = value; // Update the selected value
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            SimpleDropdownButton(
              dropdownItems: ['Mail', 'Phone No.'],
              hintValue: 'Contact Preference',
              helperText: 'This is how an interested tenant will contact you.',
              selectedValue: contactPreference,
              onChanged: (value) {
                setState(() {
                  contactPreference = value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            SimpleDropdownButton(
              dropdownItems: [
                'Driver\'s License',
                'NIN',
                'International Passport'
              ],
              hintValue: 'Mode of Verification',
              selectedValue: verificationMode,
              onChanged: (value) {
                setState(() {
                  verificationMode = value;
                });
              },
            ),
            SizedBox(
              height: 30,
            ),
            UploadButton(
              uploadedFile: uploadedFile,
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    if (uploadedFile != null) {
                      verificationImageUrl =
                          await Provider.of<AuthenticationProvider>(context,
                                  listen: false)
                              .uploadImageToFirebaseStorage(uploadedFile!);

                      // await Provider.of<AuthenticationProvider>(context,
                      //         listen: false)
                      //     .saveVerificationDataToFirestore(
                      //         verificationImageURL: verificationImageUrl,
                      //         verificationMode1: verificationMode.toString(),
                      //         identity1: identity.toString(),
                      //         contactPreference1: contactPreference.toString());
                    }

                    await Provider.of<AuthenticationProvider>(context,
                            listen: false)
                        .updateUserOwner(
                            identity!, verificationMode!, contactPreference!);

                    // Provider.of<AuthenticationProvider>(context, listen: false)
                    //     .contactPreference = contactPreference;

                    // Provider.of<AuthenticationProvider>(context, listen: false)
                    //     .verificationMode = verificationMode;
                  } catch (e) {
                    print('Updating error is this: $e');
                  }

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Verification Successful'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DrawingAnimation(),
                            Text('Successful'),
                          ],
                        ),
                        actions: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 35.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                          builder: ((BuildContext) {
                                    return MainMenuScreen();
                                  })));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  fixedSize: const Size(200, 50),
                                ),
                                child: Text('Continue',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  fixedSize: const Size(200, 50),
                ),
                child: Text(
                  'Verify',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// DROPDOWN BUTTON CODE

// ignore: must_be_immutable
class SimpleDropdownButton extends StatefulWidget {
  String? selectedValue;
  final String hintValue;
  final List<String> dropdownItems;
  final String? helperText;
  final ValueChanged<String?>? onChanged; // Callback function

  SimpleDropdownButton({
    Key? key,
    required this.dropdownItems,
    this.selectedValue,
    this.helperText,
    required this.hintValue,
    this.onChanged, // Pass the callback function
  }) : super(key: key);

  @override
  _SimpleDropdownButtonState createState() => _SimpleDropdownButtonState();
}

class _SimpleDropdownButtonState extends State<SimpleDropdownButton> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0),
        border: InputBorder.none,
        helperText: widget.helperText,
      ),
      child: DropdownButtonHideUnderline(
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            border: Border.all(
              color: AppColors.primary.withOpacity(0.8),
              width: 1,
            ),
          ),
          child: DropdownButton<String>(
            padding: EdgeInsets.only(left: 15),
            isExpanded: true,
            iconSize: 42,
            iconEnabledColor: AppColors.textColor.withOpacity(0.5),
            elevation: 1,
            borderRadius: BorderRadius.circular(5),
            underline: null,
            value: widget.selectedValue,
            onChanged: (newValue) {
              setState(() {
                selectedValue = newValue;
              });
              widget.onChanged?.call(newValue); // Trigger the callback function
            },
            items: widget.dropdownItems.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(fontSize: 16, color: AppColors.textColor),
                ),
              );
            }).toList(),
            hint: Text(
              widget.hintValue,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textColor.withOpacity(0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// UPLOAD DOCUMENT CODE

// ignore: must_be_immutable
class UploadButton extends StatefulWidget {
  File? uploadedFile;

  UploadButton({Key? key, this.uploadedFile
      // Pass the callback function
      })
      : super(key: key);
  @override
  _UploadButtonState createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  Future<void> _uploadDocument() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        widget.uploadedFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: _uploadDocument,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            color: AppColors.primary.withOpacity(0.3),
            width: 1.0,
          ),
        ),
        fixedSize: MaterialStateProperty.all(Size.fromHeight(120)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.upload,
            color: AppColors.smallIcons,
          ),
          SizedBox(width: 8.0),
          if (widget.uploadedFile != null)
            Flexible(
              child: Text(
                widget.uploadedFile!.path.split('/').last,
                overflow: TextOverflow.ellipsis,
              ),
            )
          else
            Text(
              'Upload Document',
              style: TextStyle(color: AppColors.smallIcons, fontSize: 15),
            ),
        ],
      ),
    );
  }
}

// Drawing Animation
class DrawingAnimation extends StatefulWidget {
  @override
  _DrawingAnimationState createState() => _DrawingAnimationState();
}

class _DrawingAnimationState extends State<DrawingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _drawingAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _drawingAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 1.0),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final double drawingValue = _drawingAnimation.value;

        return CustomPaint(
          painter: DrawingPainter(drawingValue),
          child: child,
        );
      },
      child: Icon(
        Icons.check_circle_outline,
        color: Colors.green,
        size: 80,
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final double drawingValue;

  DrawingPainter(this.drawingValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 4;

    final startAngle = math.pi / 4;
    final endAngle = -math.pi / 2;

    final sweepAngle = startAngle + (endAngle - startAngle) * drawingValue;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerY, centerX), radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) =>
      drawingValue != oldDelegate.drawingValue;
}
