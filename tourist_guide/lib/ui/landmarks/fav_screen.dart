import 'package:tourist_guide/core/widgets/fav_card.dart';
import 'package:tourist_guide/data/models/landmark_model.dart';
import 'package:tourist_guide/data/places_data/places_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<LandMark> favList = PlacesData().favoritePlaces();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PlacesData().favoritePlaces().isEmpty
            ? _noFav()
            : SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    Center(
                      child: Text(
                        "Favorite Places",
                        style: TextStyle(
                            fontSize: 28.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16.r),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: PlacesData().favoritePlaces().length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: index == 0 ? 10.w : 0, right: 10.w),
                              child: FavCard(
                                place: favList[index],
                                refresh: () => setState(() {
                                  favList = PlacesData().favoritePlaces();
                                }),
                              ),
                            );
                          },
                        ),
                      ),
                    ), 
                  ],
                ),
              ),
      ),
    );
  }

  Widget _noFav() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_outline,
            color: Color.fromARGB(170, 222, 114, 84),
            size: 150,
          ),
          Text(
            "Add Your Favorite Places",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18.sp,
            ),
          )
        ],
      ),
    );
  }
}
