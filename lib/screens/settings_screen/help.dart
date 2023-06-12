// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:joy_homes/screens/upload_screen/upload_constants.dart';
import 'package:joy_homes/theme.dart';
import 'settings_constants.dart';

class HelpCenterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFAFAFA),
      appBar: AppBarWidget2(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.navigate_before_rounded,
              color: AppColors.textColor,
              size: 36,
            ),
          ),
        ),
        leadingWidth1: 40,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'Help Center',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        showForwardIcon: selectedImages.isNotEmpty,
      ),
      body: _HelpCenterPage(),
    );
  }
}

class _HelpCenterPage extends StatefulWidget {
  @override
  __HelpCenterPageState createState() => __HelpCenterPageState();
}

class __HelpCenterPageState extends State<_HelpCenterPage> {
  String _selectedCategory = 'General';
  String _selectedSubCategory = '';

  List<String> _categories = ['General', 'Account', 'Payments', 'Technical'];

  Map<String, List<String>> _subCategories1 = {
    'General': ['', 'Feedback', 'Suggestions', 'Other'],
    'Account': ['', 'Login Issues', 'Profile Management', 'Account Deletion'],
    'Payments': ['', 'Payment Methods', 'Billing Issues', 'Refunds'],
    'Technical': ['', 'App Crashes', 'Performance Issues', 'Bug Report'],
  };

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Perform form submission
      // You can handle the form data here and take necessary actions
      // For example, send an email to the support team with the form details
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form submitted successfully')),
      );
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'If you have any questions or need assistance, please fill out the form below and we will get back to you as soon as possible. Alternatively, you can also reach us via email or phone call, and we will respond within the next 24 hours.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fill the Form Below',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 24),
                  DropDownButton(
                    categories: _categories,
                    selectedCategory: _selectedCategory,
                    changed: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  if (_selectedCategory.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Subcategory',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        DropDownButton(
                            changed: (String? value) {
                              setState(() {
                                _selectedSubCategory = value!;
                              });
                            },
                            categories:
                                _subCategories1[_selectedCategory]!.toList(),
                            selectedCategory: _selectedSubCategory),
                      ],
                    ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _messageController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your message';
                      }
                      return null;
                    },
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DropDownButton extends StatefulWidget {
  DropDownButton(
      {super.key,
      required this.categories,
      required this.selectedCategory,
      this.changed});

  final List<String> categories;
  String selectedCategory;
  Function(String?)? changed;

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      iconSize: 40,
      iconEnabledColor: AppColors.textColor.withOpacity(0.5),
      hint: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Text(
          'Category',
          style: TextStyle(
            color: AppColors.textColor.withOpacity(0.3),
            fontSize: 16,
          ),
        ),
      ),
      value: widget.selectedCategory,
      onChanged: widget.changed,
      items: widget.categories.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        },
      ).toList(),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: AppColors.primary, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: AppColors.secondary, width: 1),
        ),
      ),
    );
  }
}
