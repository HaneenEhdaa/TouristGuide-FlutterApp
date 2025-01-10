import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourist_guide/core/utils/user_manager.dart';
=======
import 'package:shared_preferences/shared_preferences.dart';
>>>>>>> 0faaec3378b09d848f5be0c0b8cf71ea103dc48a

import '../../core/colors/colors.dart';
import '../../data/models/user_model.dart';
import 'edit_profile.dart';
import 'widgets/profile_item.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
<<<<<<< HEAD
  var user = User(email: "", id: "", name: "", password: "", phone: "");
  Future<void> _getData() async {
    final prefs = await SharedPreferences.getInstance();
    final existingUsersString = prefs.getString('current_user');
    if (existingUsersString != null) {
      Map<String, dynamic> map = jsonDecode(existingUsersString);

      user = User.fromJson(map);
    }
    setState(() {});
  }

  File? _image;
  Future<void> _pickImage() async {
    if (_image == null) {
      // pick image from gallery
      final XFile? pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        // Get the  image directory
        final directory = await getApplicationDocumentsDirectory();

        // save it
        final String path = '${directory.path}/${pickedFile.name}';

        // copy img to new path
        final File savedImg = await File(pickedFile.path).copy(path);
        //  final prefs = await SharedPreferences.getInstance();
        //   prefs.setString('img' ,_image!.path );

        setState(() {
          // _image = File(pickedFile.path);
          _image = savedImg;
        });
      }
    }
    // else {
    //   final prefs = await SharedPreferences.getInstance();
    //   String ? img = prefs.getString('img');
    //   _image =File(img!) ;

    //   setState(() {
    //   });
    // }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 15.h,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Align(
              alignment: Alignment.center,
              child: Text("My Profile",
                  style:
                      TextStyle(fontSize: 29.sp, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    child: InkWell(
                      onTap: () {
                        _pickImage();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(60.0.r)),
                            border: Border.all(
                                color: kMainColor,
                                width: 8.w,
                                style: BorderStyle.solid)),
                        child: CircleAvatar(
                            radius: 50.r,
                            backgroundImage: _image != null
                                ? FileImage(_image!)
                                : AssetImage("assets/images/profile.png")),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Text(user.name,
                          style: TextStyle(
                              fontSize: 21.sp, fontWeight: FontWeight.bold))),
                  Text(user.email,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            // reusable widget to implement the Row item
            ProfileItem(
              isObscure: true,
              txt: user.name,
              icon: Icons.person_2_outlined,
              fun: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProfile(
                            name: user.name,
                            email: user.email,
                            password: user.password,
                            phone: user.phone,
                          ))),
            ),
            ProfileItem(
              isObscure: true,
              txt: user.email,
              icon: Icons.email_outlined,
              fun: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProfile(
                            name: user.name,
                            email: user.email,
                            password: user.password,
                            phone: user.phone,
                          ))),
            ),
            ProfileItem(
              txt: user.password,
              isObscure: false,
              icon: Icons.lock_open_outlined,
              fun: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProfile(
                            name: user.name,
                            email: user.email,
                            password: user.password,
                            phone: user.phone,
                          ))),
            ),
            ProfileItem(
              isObscure: true,
              txt: user.phone,
              icon: Icons.phone_android_outlined,
              fun: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProfile(
                            name: user.name,
                            email: user.email,
                            password: user.password,
                            phone: user.phone,
                          ))),
            ),
            ProfileItem(
              isObscure: true,
              txt: "Log out",
              icon: Icons.logout_outlined,
              fun: () {
                _logout();
              },
            ),
          ]),
=======
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: const Text('Profile Screen'),
        ),
        SizedBox(height: 200),
        ElevatedButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isLoggedIn', false);
            if (!mounted) return;
            Navigator.pushNamed(context, '/login');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kMainColor,
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Log out',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
>>>>>>> 0faaec3378b09d848f5be0c0b8cf71ea103dc48a
        ),
      ),
    );
  }
}
