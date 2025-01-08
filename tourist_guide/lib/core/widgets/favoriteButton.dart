import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_guide/core/colors/colors.dart';
import 'package:tourist_guide/core/utils/user_manager.dart';
import 'package:tourist_guide/data/places_data/places_data.dart';

class FavoriteButton extends StatefulWidget {
  bool fav;
  String placeId;
  FavoriteButton({super.key, required this.fav, required this.placeId});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

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
              borderRadius: BorderRadius.circular(15.r),
              color: kWhite,
            ),
            child: Center(
              child: IconButton(
                icon: Icon(
                  widget.fav
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  size: 0.025.sh,
                ),
                color: kMainColor,
                onPressed: () {
                  setState(() {
                    PlacesData.kLandmarks[int.parse(widget.placeId)].fav =
                        !widget.fav;
                    List<String> favPlaces = UserManager().getFavPlaces();
                    !widget.fav
                        ? favPlaces.add(widget.placeId)
                        : favPlaces.remove(widget.placeId);
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
