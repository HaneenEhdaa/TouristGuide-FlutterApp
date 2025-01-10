import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourist_guide/core/utils/user_manager.dart';
import 'package:tourist_guide/ui/profile/edit_profile.dart';
import 'package:tourist_guide/ui/profile/widgets/profile_item.dart';
import '../../core/colors/colors.dart';
import '../../data/models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

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
            vertical: 40.h,
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Align(
              alignment: Alignment.center,
              child: Text("My Profile",
                  style:
                       TextStyle(fontSize: 78.sp, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal:  47.w,
                  vertical: 30.h
                  ),
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
                            borderRadius: BorderRadius.all(Radius.circular(150.0.r)),
                            border: Border.all(
                                color: kMainColor,
                                width: 18.w,
                                style: BorderStyle.solid)),
                        child: CircleAvatar(
                            radius: 130.r,

                            backgroundImage: _image != null
                                ? FileImage(_image!)
                                : AssetImage("assets/images/profile.png")),
                      ),
                    ),
                  ),
                  Text( user.name,
                      style:
                          TextStyle(fontSize: 50.sp, fontWeight: FontWeight.bold)),
                  Text( user.email,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 45.sp,
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
              txt:  user.name,
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
              txt:  user.password,
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
              txt:  user.phone,
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
                //UserManager.logout();
              },
            ),
          ]),
        ),
      ),
    );


  }

}