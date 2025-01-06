import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourist_guide/core/colors/colors.dart';
import 'package:tourist_guide/views/auth/login.dart';
import 'package:tourist_guide/views/auth/signup.dart';

import '../home.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_snack_bar.dart';
import '../widgets/custom_text_form_field.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _Signup();
}

class _Signup extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  @override

  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive sizes
    final verticalSpacing = screenHeight * 0.03; // 3% of screen height
    final horizontalPadding = screenWidth * 0.04; // 4% of screen width
    final titleFontSize = screenWidth * 0.08; // 8% of screen width
    final buttonHeight = screenHeight * 0.08; // 8% of screen height

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
                  SizedBox(height: verticalSpacing * 1.5),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Sign up !',
                      style: TextStyle(
                        color: CupertinoColors.black,
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: verticalSpacing * 0.5),
                  Text(
                    'Welcome! Please enter your Name, email and password to create your account.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: screenWidth * 0.03,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: verticalSpacing * 1.5),
                  //CustomTextField widget for Full Name
                  CustomTextField(
                    labelText: 'Full Name',
                    hintText: 'Enter your full name',
                    prefixIcon: Icons.person,
                    controller: _nameController,
                    fieldType: 'name',
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(height: verticalSpacing),
                  //CustomTextField widget for Email
                  CustomTextField(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: Icons.email,
                    controller: _emailController,
                    fieldType: 'email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: verticalSpacing),
                  //CustomTextField widget for Password
                  CustomTextField(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: Icons.lock,
                    controller: _passwordController,
                    fieldType: 'password',
                    isPassword: true,
                  ),
                  SizedBox(height: verticalSpacing),
                  //CustomTextField widget for Confirm Password
                  CustomTextField(
                    labelText: 'Confirm Password',
                    hintText: 'Confirm your password',
                    prefixIcon: Icons.lock_outline,
                    controller: _confirmPasswordController,
                    fieldType: 'confirmPassword',
                    isPassword: true,
                    passwordController: _passwordController,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: verticalSpacing),
                  CustomTextField(
                    labelText: 'Phone Number (optional)',
                    hintText: 'Enter your phone number',
                    prefixIcon: CupertinoIcons.phone,
                    controller: _phoneNumberController,
                    fieldType: 'phone',
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: verticalSpacing * 2),
                  //CustomButton widget for Sign Up
                  CustomButton(
                    text: 'Sign Up',
                    fontSize: screenWidth * 0.04, // 4% of screen width
                    onPressed: _submitForm,
                    height: buttonHeight,
                    width: screenWidth * 0.9,
                    // 90% of screen width
                  ),
                  SizedBox(height: verticalSpacing*1.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Have an account?',style: TextStyle(color: Colors.black),),
                      GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                          },
                          child:
                          Text('  Log in',style: TextStyle(color: kMainColor),
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final prefs = await SharedPreferences.getInstance();

        // Check for existing users
        List<Map<String, dynamic>> usersList = [];
        String? existingUsersString = prefs.getString('users_list');

        if (existingUsersString != null) {
          // Parse existing users
          usersList = List<Map<String, dynamic>>.from(
              json.decode(existingUsersString)
          );

          // Check for duplicate email
          if (usersList.any((user) => user['email'].toString().toLowerCase() ==
              _emailController.text.toLowerCase())) {
            if (!mounted) return;

            CustomSnackBar.showError(
              context: context,
              message: 'This email is already registered',
            );
            return;
          }else if (usersList.any((user) => user['phone'].toString().toLowerCase() ==
              _phoneNumberController.text.toLowerCase())) {
            if (!mounted) return;

            CustomSnackBar.showError(
              context: context,
              message: 'This phone number is already registered',
            );
            return;
          }
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

        // Save updated users list
        await prefs.setString('users_list', json.encode(usersList));

        // Save current user for session
        await prefs.setString('current_user', json.encode(newUser));
        await prefs.setBool('isLoggedIn', true);

        print('Users List: ${prefs.getString('users_list')}');
        print('Current User: ${prefs.getString('current_user')}');

        if (!mounted) return;

        CustomSnackBar.showSuccess(
          context: context,
          message: 'Registration successful!',
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );

      } catch (e) {
        print('Error during registration: $e');
        CustomSnackBar.showError(
          context: context,
          message: 'Registration failed: ${e.toString()}',
        );
      }
    }
  }
}
