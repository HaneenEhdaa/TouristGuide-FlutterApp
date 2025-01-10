import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_guide/core/widgets/landmark_card.dart';
import 'package:tourist_guide/data/models/landmark_model.dart';
import 'package:tourist_guide/data/places_data/places_data.dart';

class GovernorateDetails extends StatelessWidget {
  static const routeName = '/governate_detials';
  List<LandMark> landmarks= [];
  GovernorateDetails({super.key});

  List<LandMark> getLandmarks(String gov) {
    List<LandMark> list = PlacesData.kLandmarks
        .where((landmark) => landmark.governorate.toLowerCase() == gov.toLowerCase())
        .toList();
    print(list);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    String argument = ModalRoute.of(context)!.settings.arguments as String;
    landmarks = getLandmarks(argument);
    return Scaffold(
        appBar: AppBar(
          title: Text('Land Marks in ${argument}',
            style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),),
        ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(child: LandmarkCard(place: landmarks[0], isFromFav: false)),
            Expanded(child: LandmarkCard(place: landmarks[1], isFromFav: false))
          ],
        ),
      ),
    );
  }

}
