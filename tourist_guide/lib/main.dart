import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_guide/core/utils/user_manager.dart';
import 'package:tourist_guide/ui/auth/login.dart';
import 'package:tourist_guide/ui/governorate/governorate_details.dart';
import 'package:tourist_guide/ui/home/home.dart';
import 'package:tourist_guide/ui/auth/signup.dart';
import 'package:tourist_guide/ui/home/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserManager().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Suwannaphum',
        ),
        home: HomeScreen(),
        routes: {
          '/login': (context) => const Login(),
          '/signup': (context) => const Signup(),
          '/splash': (context) => const SplashScreen(),
          '/home': (context) => const HomeScreen(),
          // '/details': (context) => DetailsScreen(),
          '/governate_detials': (context) => GovernorateDetails()
        },
      ),
    );
  }
}
