import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_guide/core/utils/user_manager.dart';
import 'package:tourist_guide/ui/auth/login.dart';
import 'package:tourist_guide/ui/home/home.dart';
import 'package:tourist_guide/ui/auth/signup.dart';
import 'package:tourist_guide/ui/home/splash.dart';

import 'package:tourist_guide/ui/landmarks/details_screen.dart';
import 'package:tourist_guide/ui/profile/edit_profile.dart';
import 'package:tourist_guide/ui/profile/profile_screen.dart';

import 'ui/home/welcome_screen.dart';

void main() async {
  
  runApp(ScreenUtilInit(
    designSize: const Size(1080, 1920),//Design size of your Figma File
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
    
   return const MyApp();}
    ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    UserManager().init();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Suwannaphum',
      ),
      home: ProfileScreen(),
      routes: {
        '/login': (context) => const Login(),
        '/signup': (context) => const Signup(),
        '/welcome': (context) => const WelcomeScreen(),
        '/home': (context) => const HomeScreen(),
        '/details': (context) =>  DetailsScreen(),
      },
    );
  }
}

