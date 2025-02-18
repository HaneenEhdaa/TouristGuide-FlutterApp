import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourist_guide/ui/home/home.dart';
import '../../core/utils/user_manager.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_snack_bar.dart';
import '../../core/widgets/custom_text_form_field.dart';
import '../../data/models/user_model.dart';

class EditProfile extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String phone;
  const EditProfile(
      {super.key,
      required this.name,
      required this.email,
      required this.password,
      required this.phone});

  @override
  State<EditProfile> createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _phoneNumberController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _emailController.text = widget.email;
    _passwordController.text = widget.password;
    _phoneNumberController.text = widget.phone;
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive sizes
    final verticalSpacing = screenHeight * 0.03; // 3% of screen height
    final horizontalPadding = screenWidth * 0.04; // 4% of screen width

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalSpacing,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      _backButton(context),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Edit Profile !',
                            style: TextStyle(
                              color: CupertinoColors.black,
                              fontSize: 29.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Welcome! You can edit your Name, email or password.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  //CustomTextField widget for Full Name
                  CustomTextField(
                    labelText: 'Full Name',
                    hintText: 'Enter your full name',
                    prefixIcon: Icons.person,
                    controller: _nameController,
                    fieldType: 'name',
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(height: 24.h),
                  //CustomTextField widget for Email
                  CustomTextField(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: Icons.email,
                    controller: _emailController,
                    fieldType: 'email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 24.h),
                  //CustomTextField widget for Password
                  CustomTextField(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: Icons.lock,
                    controller: _passwordController,
                    fieldType: 'password',
                    isPassword: true,
                  ),
                  SizedBox(height: 24.h),
                  //CustomTextField widget for Confirm Password
                  CustomTextField(
                    labelText: 'Phone Number (optional)',
                    hintText: 'Enter your phone number',
                    prefixIcon: CupertinoIcons.phone,
                    controller: _phoneNumberController,
                    fieldType: 'phone',
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 24.h),
                  //CustomButton widget for Sign Up
                  CustomButton(
                    text: 'Save',
                    fontSize: 50.sp, // 4% of screen width
                    onPressed: () {
                      _saveEdits();
                    },
                    height: 56.h,
                    width: 0.9.sw,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Image.asset(
        'assets/images/arrowBack.png',
        width: 40.w,
        height: 40.h,
      ),
    );
  }

// func to save new edits by deleting the current user and save  new values to it
  Future<void> _saveEdits() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final prefs = await SharedPreferences.getInstance();
        final myUser = prefs.getString('current_user');
        if (myUser != null) {
          Map<String, dynamic> map = jsonDecode(myUser);

          var user1 = User.fromJson(map);
          // remove the current user
          UserManager.deleteUser(user1.id);
        }
        // Check for existing users
        List<Map<String, dynamic>> usersList = [];
        String? existingUsersString = prefs.getString('users_list');
        if (existingUsersString != null) {
          // Parse existing users
          usersList =
              List<Map<String, dynamic>>.from(json.decode(existingUsersString));
        }

        // Create new user data
        Map<String, dynamic> newUser = {
          'id': DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID
          'name': _nameController.text,
          'email': _emailController.text.toLowerCase(),
          'password': _passwordController.text,
          'phone': _phoneNumberController.text,
          'registrationDate': DateTime.now().toIso8601String(),
        };

        // Add new user to the list
        usersList.add(newUser);
        await prefs.setString('current_user', json.encode(newUser));
        if (!mounted) return;

        CustomSnackBar.showSuccess(
          context: context,
          message: 'Eidted successfully!',
        );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false,
        );
      } catch (e) {
        debugPrint('Error during Edit: $e');
        CustomSnackBar.showError(
          context: context,
          message: 'Edit failed: ${e.toString()}',
        );
      }
    }
  }
}
