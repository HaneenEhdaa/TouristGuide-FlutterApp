import 'package:flutter/material.dart';
import 'package:tourist_guide/core/colors/colors.dart';


// custom resuable widget implements every row in profile
class ProfileItem extends StatelessWidget {
  String txt;
  IconData icon;
  Function() fun;
  bool? isObscure;
  ProfileItem(
      {super.key,
      required this.txt,
      required this.icon,
      required this.fun,
      this.isObscure});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fun,
      child: ListTile(
        title: Text(
            isObscure == true ? txt : '${txt.replaceAll(RegExp(r"."), "*")}'),
        leading: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kMainColor,
            ),
            child: Icon(
              icon,
              color: Colors.white,
            )),
        trailing: Icon(
          Icons.arrow_right,
          size: 30,
        ),
      ),
    );
  }
}
