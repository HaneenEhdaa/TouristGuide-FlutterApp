import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourist_guide/core/widgets/custom_button.dart';
import 'package:tourist_guide/core/widgets/custom_snack_bar.dart';
import 'package:tourist_guide/core/widgets/custom_text_form_field.dart';
import 'package:tourist_guide/ui/auth/signup.dart';
import 'package:tourist_guide/ui/home/welcome_screen.dart';

import '../../core/colors/colors.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    checkStoredData(); // This will print all stored data
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
      // Wrap the body in AnimatedBuilder to rebuild when animation value changes
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
                      'Welcome Back! 😍',
                      style: TextStyle(
                        color: CupertinoColors.black,
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: verticalSpacing * 0.5),
                  Text(
                    'Happy to see you again! Please enter your email and password to login to your account.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: screenWidth * 0.03,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: verticalSpacing * 1.5),
                  //CustomTextField widget for Full Name

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

                  //CustomTextField widget for Confirm Password

                  SizedBox(height: verticalSpacing * 2),
                  //CustomButton widget for Sign Up
                  CustomButton(
                    text: 'Log In',
                    fontSize: screenWidth * 0.04, // 4% of screen width
                    onPressed: _login,
                    height: buttonHeight,
                    width: screenWidth * 0.9, // 90% of screen width
                  ),
                  SizedBox(height: verticalSpacing * 1.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?'),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()));
                          },
                          child: Text(
                            '  Sign Up',
                            style: TextStyle(color: kMainColor),
                          )),
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

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Show loading indicator
        CustomSnackBar.showInfo(
          context: context,
          message: 'Logging in...',
          duration: const Duration(milliseconds: 1000),
        );

        // Add a small delay to show the loading message
        await Future.delayed(const Duration(milliseconds: 500));

        final prefs = await SharedPreferences.getInstance();

        final usersString = prefs.getString('users_list');
        if (usersString == null) {
          CustomSnackBar.showWarning(
            context: context,
            message: 'No registered users found. Please sign up first.',
            duration: const Duration(seconds: 3),
          );
          return;
        }

        List<Map<String, dynamic>> usersList =
            List<Map<String, dynamic>>.from(json.decode(usersString));

        final user = usersList.firstWhere(
          (user) =>
              user['email'].toString().toLowerCase() ==
                  _emailController.text.toLowerCase() &&
              user['password'] == _passwordController.text,
          orElse: () => {},
        );

        if (user.isEmpty) {
          CustomSnackBar.showError(
            context: context,
            message: 'Invalid email or password. Please try again.',
            duration: const Duration(seconds: 3),
          );
          return;
        }

        await prefs.setString('current_user', json.encode(user));
        await prefs.setBool('isLoggedIn', true);

        if (!mounted) return;

        // // Show personalized success message
        // CustomSnackBar.showCustom(
        //   context: context,
        //   message: 'Welcome back, ${user['name']}! 👋',
        //   backgroundColor: kMainColor,
        //   icon: Icons.celebration,
        //   duration: const Duration(seconds: 2),
        //   fontSize: 18,
        //   fontWeight: FontWeight.bold,
        // );

        await Future.delayed(const Duration(milliseconds: 800));

        if (!mounted) return;

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const WelcomeScreen(),
          ),
        );
      } catch (e) {
        CustomSnackBar.showCustom(
          context: context,
          message: 'Oops! Something went wrong',
          backgroundColor: Colors.red,
          icon: Icons.error_outline,
          duration: const Duration(seconds: 3),
        );

        // Log the error for debugging
        print('Login error: $e');
      }
    } else {
      CustomSnackBar.showWarning(
        context: context,
        message: 'Please check your input and try again',
        duration: const Duration(seconds: 2),
      );
    }
  }

  Future<void> checkStoredData() async {
    final prefs = await SharedPreferences.getInstance();

    print('\nStored Data Check:');
    print('Email: ${prefs.getString('email')}');
    print('Password: ${prefs.getString('password')}');
    print('UserData: ${prefs.getString('userData')}');
    print('IsRegistered: ${prefs.getBool('isRegistered')}');
    print('IsLoggedIn: ${prefs.getBool('isLoggedIn')}');
  }

  Future<Map<String, dynamic>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final currentUserString = prefs.getString('currentUser');
    if (currentUserString != null) {
      return json.decode(currentUserString);
    }
    return null;
  }
}
