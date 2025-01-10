import 'package:tourist_guide/core/colors/colors.dart';
import 'package:tourist_guide/core/widgets/landmark_card.dart';
import 'package:tourist_guide/data/models/landmark_model.dart';
import 'package:tourist_guide/data/places_data/places_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesScreen extends StatefulWidget {
  final void Function(int)? onNavigate;
  const FavoritesScreen({super.key, this.onNavigate});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late List<LandMark> favPlaces;

  @override
  void initState() {
    super.initState();
    favPlaces = PlacesData().favoritePlaces();
  }

  void _removeFromFav(LandMark landmark) {
    setState(() {
      favPlaces.remove(landmark);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Favorite Places", style: TextStyle(fontSize: 18.sp)),
              PlacesData().favoritePlaces().isEmpty
                  ? _emptyFavWidget()
                  : _favWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyFavWidget() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_outline,
              color: kMainColor,
              size: 0.08.sh,
            ),
            SizedBox(height: 0.02.sh),
            GestureDetector(
              onTap: () {
                widget.onNavigate!(0);
              },
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "Your Favorite List is Empty! "),
                    TextSpan(
                      text: "Explore Places",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _favWidget() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 30.h, bottom: 30.h),
        scrollDirection: Axis.horizontal,
        itemCount: favPlaces.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: ScreenUtil().screenWidth - 0.1.sw,
            child: LandmarkCard(
              place: favPlaces[index],
              isFromFav: true,
              onRemove: _removeFromFav,
            ),
          );
        },
      ),
    );
  }
}
