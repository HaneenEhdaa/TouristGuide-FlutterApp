import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_guide/core/colors/colors.dart';
import 'package:tourist_guide/core/widgets/landmark_card.dart';
import 'package:tourist_guide/data/places_data/places_data.dart';

class PlacesScreen extends StatelessWidget {
  const PlacesScreen({super.key});

// The main UI of the PlacesScreen is built with padding and two main components:
// the header and body. The header displays a personalized greeting, and the body
// contains two sections for places.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1.sh - 75,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [_header(), _body()],
            ),
          ),
        ),
      ),
    );
  }

// Displays a greeting message with the user's first name retrieved from shared preferences.
// Displays the user's profile picture. If no image path is saved, a default logo image is shown.
  Widget _header() {
    return SafeArea(
      child: SizedBox(
        height: 0.07.sh,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, User 👋',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Discover best places to go to vacation 😍',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: kLightBlack,
                  ),
                ),
              ],
            ),
            ClipOval(
              child: Container(
                height: 0.05.sh,
                width: 0.05.sh,
                color: kGrey,
                child: Image.asset(
                  'assets/images/card_bg.png',
                  fit: BoxFit.fill,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

// The body contains two main sections: suggested places and popular places.
  Widget _body() {
    return Expanded(
      child: Column(
        children: [
          _suggestedPlaces(),
          _popularPlaces(),
        ],
      ),
    );
  }

// Displays a list of suggested places in a grid. It uses a GridView.builder to
// show the places in a 2-column grid. Each place is shown using the PlaceCard widget.
  Widget _suggestedPlaces() {
    return SizedBox(
      height: 0.53.sh - 75,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 0.01.sh),
          Text(
            'Suggested Places',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 0.01.sh),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.zero,
              itemCount: PlacesData().suggestedPlaces().length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.65),
              itemBuilder: (context, index) =>
                  LandmarkCard(place: PlacesData().suggestedPlaces()[index]),
            ),
          ),
        ],
      ),
    );
  }

// Displays a list of popular places (which is the reverse order of kPlaces) in
// a horizontal scrolling list. The PlaceCard widget is used for each place in the list.
  Widget _popularPlaces() {
    return SizedBox(
      height: 0.41.sh - 75,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 0.01.sh),
          Text(
            'Popular Places',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 0.01.sh),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: PlacesData().popularPlaces().length,
              itemBuilder: (context, index) {
                return LandmarkCard(place: PlacesData().popularPlaces()[index]);
              },
            ),
          ),
          SizedBox(height: 0.005.sh),
        ],
      ),
    );
  }
}
