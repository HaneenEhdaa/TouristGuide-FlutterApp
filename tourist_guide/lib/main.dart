import 'package:flutter/material.dart';
import 'package:tourist_guide/core/utils/size_config.dart';
import 'package:tourist_guide/ui/home/home.dart';
import 'package:tourist_guide/views/auth/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Suwannaphum',
      ),
      home: Signup(),
    );
  }
}
