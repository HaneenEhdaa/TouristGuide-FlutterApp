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
  List<LandMark> Fav_list = PlacesData().favoritePlaces();

  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Favorite Places"),
              backgroundColor: Colors.white,
            ),
            body: PlacesData().favoritePlaces().isEmpty
                ? _noFav()
                : SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: PlacesData().favoritePlaces().length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: index == 0 ? 10.w : 0, right: 10.w),
                                child: FavCard(
                                  place: Fav_list[index],
                                  refresh: () => setState(() {
                                    Fav_list = PlacesData().favoritePlaces();
                                  }),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
            backgroundColor: Colors.white,
          );
        });
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
