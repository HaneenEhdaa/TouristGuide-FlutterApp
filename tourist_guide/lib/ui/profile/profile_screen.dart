import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourist_guide/core/utils/user_manager.dart';
import 'package:tourist_guide/core/widgets/custom_button.dart';

import '../../core/colors/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: const Text('Profile Screen')),
        SizedBox(height: 0.2.sh),
        // ElevatedButton(
        //   onPressed: () async {
        //     final prefs = await SharedPreferences.getInstance();
        //     await prefs.setBool('isLoggedIn', false);
        //     if (!mounted) return;
        //     Navigator.pushNamed(context, '/login');
        //   },
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: kMainColor,
        //     padding: const EdgeInsets.symmetric(
        //       vertical: 12,
        //       horizontal: 16,
        //     ),
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(40),
        //     ),
        //     elevation: 0,
        //   ),
        //   child: const Text(
        //     'Log out',
        //     style: TextStyle(
        //       fontSize: 16,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),

        CustomButton(
          text: 'Log out',
          onPressed: () => _logout(),
          width: 0.2.sh,
        ),
      ],
    );
  }

  void _logout() async {
    UserManager.logout();
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', (Route<dynamic> route) => false);
  }
}
