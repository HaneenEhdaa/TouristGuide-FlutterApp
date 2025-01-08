import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_guide/core/colors/colors.dart';
import 'package:tourist_guide/core/utils/user_manager.dart';
import 'package:tourist_guide/data/models/landmark_model.dart';
import 'package:tourist_guide/data/places_data/places_data.dart';

class FavoriteButton extends StatefulWidget {
  LandMark place;
  FavoriteButton({super.key, required this.place});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

// Displays the favorite icon, allowing users to mark/unmark a place as a favorite.
// Updates the favorite status both in the local list and in shared preferences.
class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ClipOval(
          child: Container(
            width: 0.05.sh,
            height: 0.05.sh,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(48),
              color: kWhite,
            ),
            child: Center(
              child: IconButton(
                icon: Icon(
                  widget.place.fav
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  size: 0.025.sh,
                ),
                color: kMainColor,
                onPressed: () {
                  setState(() {
                    PlacesData.kLandmarks[int.parse(widget.place.id)].fav =
                        !widget.place.fav;
                    List<String> favPlaces = UserManager().getFavPlaces();
                    !widget.place.fav
                        ? favPlaces.add(widget.place.id)
                        : favPlaces.remove(widget.place.id);
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
}
