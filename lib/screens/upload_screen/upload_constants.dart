import 'package:flutter/material.dart';
import 'package:joy_homes/theme.dart';
import 'upload_details.dart';
import 'dart:io';

final List<File> selectedImages = [];

class AppBarWidget2 extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;

  final double? leadingWidth1;
  final bool showForwardIcon; // New property

  const AppBarWidget2({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.leadingWidth1,
    this.showForwardIcon = true, // Default value is true
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: title,
      leading: leading,
      leadingWidth: leadingWidth1,
      actions: [
        if (showForwardIcon) // Conditionally show the forward icon
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UploadDetails();
                }));
              },
              child: Icon(
                Icons.forward,
                color: AppColors.smallIcons,
                size: 30,
              ),
            ),
          ),
      ],
      bottom: PreferredSize(
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}

// THIS IS THE INPUT FIELDS
// ignore: must_be_immutable
class InputField extends StatelessWidget {
  InputField(
      {Key? key,
      required this.innerText,
      required this.validatorText,
      this.onInputChanged,
      this.textEditingController,
      required this.inputTitle})
      : super(key: key);

  final String inputTitle;
  final String innerText;
  final String validatorText;
  final Function(String)? onInputChanged;
  TextEditingController? textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            inputTitle,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textColor),
          ),
          SizedBox(
            height: 8,
          ),
          TextFormField(
            maxLength: 50,
            controller: textEditingController,
            onChanged: onInputChanged,
            cursorWidth: 1.5,
            cursorHeight: 20,
            cursorColor: AppColors.primary,
            style: const TextStyle(color: AppColors.textColor, fontSize: 16),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: AppColors.textColor),
              counterText: '0/50',
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              hintText: innerText,
              hintStyle: TextStyle(color: AppColors.textColor.withOpacity(0.3)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primary.withOpacity(0.8),
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primary.withOpacity(0.3),
                  width: 1.0,
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(66, 235, 62, 62),
                  width: 1.0,
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(66, 235, 62, 62),
                  width: 1.0,
                ),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return validatorText;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class DescriptionTextField extends StatelessWidget {
  final TextEditingController controller;

  const DescriptionTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        TextFormField(
          textAlignVertical: TextAlignVertical.top,
          textAlign: TextAlign.justify,
          cursorColor: AppColors.secondary,
          cursorWidth: 1,
          expands: true,
          controller: controller,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          maxLength: 200,
          decoration: InputDecoration(
            hintText: 'Write a short decription',
            hintStyle: TextStyle(color: AppColors.textColor.withOpacity(0.3)),
            constraints: BoxConstraints.tightFor(height: 100),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: AppColors.primary.withOpacity(0.8),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: AppColors.primary.withOpacity(0.3),
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: AppColors.primary.withOpacity(0.3),
              ),
            ),
            counterText: '0/200', // Disable the default character counter
          ),
          style:
              TextStyle(fontSize: 16, color: AppColors.textColor, height: 1.3),
        ),
      ],
    );
  }
}

class RentTextField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>
      onValueChanged; // Callback for handling input value
  final ValueChanged<String>
      onSelectedValueChanged; // Callback for handling selected value

  const RentTextField({
    required this.controller,
    required this.onValueChanged,
    required this.onSelectedValueChanged,
  });

  @override
  State<RentTextField> createState() => _RentTextFieldState();
}

class _RentTextFieldState extends State<RentTextField> {
  int selectedIndex = 0;

  void _handleButtonClick(int index) {
    setState(() {
      if (selectedIndex != index) {
        selectedIndex = index;
        String selectedValue = index == 0 ? 'Year' : 'Month';
        widget.onSelectedValueChanged.call(selectedValue);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rent',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                height: 50,
                child: TextFormField(
                  onChanged: (value) {
                    widget.onValueChanged(value);
                  },
                  cursorColor: AppColors.secondary,
                  cursorWidth: 1,
                  controller: widget.controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefix: Text(
                      '₦  ',
                      style: TextStyle(
                          color: AppColors.contactColor.withOpacity(0.6)),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.primary.withOpacity(0.8),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.primary.withOpacity(0.3),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.primary.withOpacity(0.3),
                      ),
                    ),
                  ),
                  style: TextStyle(
                      fontSize: 16, color: AppColors.textColor, height: 1.3),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  '/',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    _handleButtonClick(0);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor:
                        selectedIndex == 0 ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: BorderSide(
                      color: selectedIndex == 0
                          ? AppColors.primary
                          : AppColors.primary.withOpacity(0.3),
                    ),
                    backgroundColor: selectedIndex == 0
                        ? AppColors.primary
                        : Colors.transparent,
                    minimumSize: const Size(150, 45),
                  ),
                  child: Text(
                    'Year',
                    style: TextStyle(
                        color: selectedIndex == 0
                            ? Colors.white
                            : AppColors.textColor,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    _handleButtonClick(1);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor:
                        selectedIndex == 1 ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: BorderSide(
                      color: selectedIndex == 1
                          ? AppColors.primary
                          : AppColors.primary.withOpacity(0.3),
                    ),
                    backgroundColor: selectedIndex == 1
                        ? AppColors.primary
                        : Colors.transparent,
                    minimumSize: const Size(150, 45),
                  ),
                  child: Text(
                    'Month',
                    style: TextStyle(
                        color: selectedIndex == 1
                            ? Colors.white
                            : AppColors.textColor,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class CountFormField extends StatefulWidget {
  final String labelText;
  final int initialValue;
  final int minValue;
  final int maxValue;
  int selectedValue;
  final ValueChanged<int>? onCountChanged;

  CountFormField({
    required this.labelText,
    required this.initialValue,
    required this.minValue,
    required this.maxValue,
    required this.selectedValue,
    this.onCountChanged,
  });

  @override
  _CountFormFieldState createState() => _CountFormFieldState();
}

class _CountFormFieldState extends State<CountFormField> {
  late TextEditingController _controller;

  bool _isValueSelected = false;

  @override
  void initState() {
    super.initState();
    widget.selectedValue = widget.initialValue;
    _isValueSelected = false;
    _controller = TextEditingController(text: widget.selectedValue.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementCount() {
    setState(() {
      widget.selectedValue = (widget.selectedValue < widget.maxValue)
          ? widget.selectedValue + 1
          : widget.selectedValue;
      _controller.text = widget.selectedValue.toString();
      _isValueSelected = true;
      if (widget.onCountChanged != null) {
        widget.onCountChanged!(widget.selectedValue);
      }
    });
  }

  void _decrementCount() {
    setState(() {
      widget.selectedValue = (widget.selectedValue > widget.minValue)
          ? widget.selectedValue - 1
          : widget.selectedValue;
      _controller.text = widget.selectedValue.toString();
      _isValueSelected = true;
      if (widget.onCountChanged != null) {
        widget.onCountChanged!(widget.selectedValue);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 18,
      color: _isValueSelected ? AppColors.textColor : Colors.grey,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            border: Border.all(
              color: _isValueSelected
                  ? AppColors.primary.withOpacity(0.7)
                  : AppColors.primary.withOpacity(0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  onChanged: widget.onCountChanged != null
                      ? (value) {
                          if (int.tryParse(value) != null) {
                            setState(() {
                              widget.selectedValue = int.parse(value);
                            });
                            widget.onCountChanged!(widget.selectedValue);
                          }
                        }
                      : null,
                  keyboardType: TextInputType.number,
                  style: textStyle, // Apply the textStyle
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  readOnly: true,
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      visualDensity:
                          VisualDensity(horizontal: -4.0, vertical: -4.0),
                      onPressed: _incrementCount,
                      icon: Icon(
                        Icons.arrow_drop_up_rounded,
                        size: 40,
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      visualDensity:
                          VisualDensity(horizontal: -4.0, vertical: -4.0),
                      onPressed: _decrementCount,
                      icon: Icon(
                        Icons.arrow_drop_down_rounded,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ToggleDetailsButtons extends StatefulWidget {
  const ToggleDetailsButtons(
      {super.key,
      required this.toggleTitle,
      required this.sizedBoxWidth,
      required this.onSelectedValueChanged});

  final String toggleTitle;
  final double sizedBoxWidth;
  final ValueChanged<String> onSelectedValueChanged;

  @override
  State<ToggleDetailsButtons> createState() => _ToggleDetailsButtonsState();
}

class _ToggleDetailsButtonsState extends State<ToggleDetailsButtons> {
  int selectedIndex = 0;

  void _handleButtonClick(int index) {
    setState(() {
      if (selectedIndex != index) {
        selectedIndex = index;
        String selectedValue = index == 0 ? 'Yes' : 'No';
        widget.onSelectedValueChanged.call(selectedValue);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.toggleTitle,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    _handleButtonClick(0);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor:
                        selectedIndex == 0 ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: BorderSide(
                      color: selectedIndex == 0
                          ? AppColors.primary
                          : AppColors.primary.withOpacity(0.3),
                    ),
                    backgroundColor: selectedIndex == 0
                        ? AppColors.primary
                        : Colors.transparent,
                    minimumSize: const Size(150, 45),
                  ),
                  child: Text(
                    'Yes',
                    style: TextStyle(
                        color: selectedIndex == 0
                            ? Colors.white
                            : AppColors.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: widget.sizedBoxWidth,
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    _handleButtonClick(1);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor:
                        selectedIndex == 1 ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: BorderSide(
                      color: selectedIndex == 1
                          ? AppColors.primary
                          : AppColors.primary.withOpacity(0.3),
                    ),
                    backgroundColor: selectedIndex == 1
                        ? AppColors.primary
                        : Colors.transparent,
                    minimumSize: const Size(150, 45),
                  ),
                  child: Text(
                    'No',
                    style: TextStyle(
                        color: selectedIndex == 1
                            ? Colors.white
                            : AppColors.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// BOTTOM NAV BUTTON
class BottomNavButton extends StatelessWidget {
  BottomNavButton(
      {super.key,
      required GlobalKey<FormState> formKey,
      required this.bottomFunctionality,
      required this.buttonTitle,
      required this.buttonIcon})
      : _formKey = formKey;

  // ignore: unused_field
  final GlobalKey<FormState> _formKey;

  final Function()? bottomFunctionality;
  final String buttonTitle;
  final Widget buttonIcon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: bottomFunctionality,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        fixedSize: const Size(double.infinity, 55),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            buttonTitle,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 5.0),
          buttonIcon,
        ],
      ),
    );
  }
}
