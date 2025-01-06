import 'package:flutter/material.dart';
import 'package:tourist_guide/core/colors/colors.dart';
import 'package:tourist_guide/core/utils/size_config.dart';
import 'package:tourist_guide/data/models/landmark_model.dart';

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
      width: SizeConfig.screenWidth! - 12,
      height: SizeConfig.defaultSize! * 36,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Stack(
          children: [
            _cardImg(widget.place.imgPath),
            Padding(
              padding: const EdgeInsets.all(10.0),
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
        // Get.toNamed('/details', arguments: widget.place);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          imgPath,
          height: SizeConfig.defaultSize! * 36,
          width: SizeConfig.screenWidth! - 8,
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
        const Expanded(child: SizedBox()),
        ClipOval(
          child: Container(
            width: SizeConfig.defaultSize! * 4,
            height: SizeConfig.defaultSize! * 4,
            decoration: detailsBoxTheme(15),
            child: IconButton(
              icon: Icon(
                fav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                size: 25,
              ),
              color: kMainColor,
              onPressed: () {
                // setState(() {
                //   kPlaces[int.parse(placeId)].fav = !fav;
                //   //
                //   List<String> favPlaces = SharedPrefs().getFavPlaces();
                //   !fav ? favPlaces.add(placeId) : favPlaces.remove(placeId);
                //   SharedPrefs().setFavPlaces(ids: favPlaces);
                // });
              },
            ),
          ),
        ),
      ],
    );
  }

// Displays the name, governorate, and rating of the place in a card format,
// with appropriate icons for location and rating.
  Widget _aboutPlace(String name, String gov, String rate) {
    debugPrint('name: $name, gov: $gov, rate: $rate');
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        height: SizeConfig.defaultSize! * 6,
        // width: SizeConfig.defaultSize! * 22,
        width: SizeConfig.screenWidth! - 12,
        decoration: detailsBoxTheme(15),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
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
                      const Icon(
                        Icons.place_rounded,
                        color: kLightBlack,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          gov,
                          style: const TextStyle(
                            fontSize: 14,
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
                    const Icon(
                      Icons.star_rounded,
                      color: kLightBlack,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rate,
                      style: const TextStyle(fontSize: 18, color: kLightBlack),
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
