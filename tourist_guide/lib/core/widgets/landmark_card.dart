import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_guide/core/colors/colors.dart';
import 'package:tourist_guide/core/utils/user_manager.dart';
import 'package:tourist_guide/data/models/landmark_model.dart';
import 'package:tourist_guide/data/places_data/places_data.dart';

class LandmarkCard extends StatefulWidget {
  final LandMark place;
  const LandmarkCard({super.key, required this.place});

  @override
  State<LandmarkCard> createState() => _LandmarkCardState();
}

class _LandmarkCardState extends State<LandmarkCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtil().screenWidth / 2 - 8,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Stack(
          children: [
            _cardImg(widget.place.imgPath),
            Padding(
              padding: EdgeInsets.all(10.0.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _favorite(widget.place.id, widget.place.fav),
                  const Expanded(child: SizedBox()),
                  _aboutPlace(
                    widget.place.name,
                    widget.place.governorate,
                    widget.place.rate,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

// Displays the image of the place inside a ClipRRect widget with a rounded border.
// Tapping on the image navigates to the place details page.
  Widget _cardImg(String imgPath) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/details', arguments: widget.place);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          imgPath,
          height: 1.sh,
          width: 1.sw,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

// Displays the favorite icon, allowing users to mark/unmark a place as a favorite.
// Updates the favorite status both in the local list and in shared preferences.
  Widget _favorite(String placeId, bool fav) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ClipOval(
          child: Container(
            width: 0.05.sh,
            height: 0.05.sh,
            decoration: detailsBoxTheme(15),
            child: Center(
              child: IconButton(
                icon: Icon(
                  fav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  size: 0.025.sh,
                ),
                color: kMainColor,
                onPressed: () {
                  setState(() {
                    PlacesData.kLandmarks[int.parse(placeId)].fav = !fav;
                    List<String> favPlaces = UserManager().getFavPlaces();
                    !fav ? favPlaces.add(placeId) : favPlaces.remove(placeId);
                    UserManager().setFavPlaces(ids: favPlaces);
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

// Displays the name, governorate, and rating of the place in a card format,
// with appropriate icons for location and rating.
  Widget _aboutPlace(String name, String gov, String rate) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        height: 0.09.sh,
        width: ScreenUtil().screenWidth - 12,
        decoration: detailsBoxTheme(15),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Icon(
                        Icons.place_rounded,
                        color: kLightBlack,
                        size: 0.020.sh,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          gov,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: kLightBlack,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: kLightBlack,
                      size: 0.020.sh,
                      // 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rate,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: kLightBlack,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration detailsBoxTheme(double borderRadius) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      color: kWhite,
    );
  }
}
