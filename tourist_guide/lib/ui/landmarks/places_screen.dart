import 'package:flutter/material.dart';
import 'package:tourist_guide/core/colors/colors.dart';
import 'package:tourist_guide/core/utils/size_config.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [_header(), _body()],
        ),
      ),
    );
  }

// Displays a greeting message with the user's first name retrieved from shared preferences.
// Displays the user's profile picture. If no image path is saved, a default logo image is shown.
  Widget _header() {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, User 👋',
                style: TextStyle(
                  fontSize: SizeConfig.defaultSize! * 2.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizeConfig().vSpace(0.5),
              Text(
                'Discover best places to go to vacation 😍',
                style: TextStyle(
                  fontSize: SizeConfig.defaultSize! * 1.6,
                  color: kLightBlack,
                ),
              ),
            ],
          ),
          ClipOval(
            child: Container(
              height: SizeConfig.defaultSize! * 5,
              width: SizeConfig.defaultSize! * 5,
              color: kGrey,
              child: Image.asset(
                'assets/images/card_bg.png',
                fit: BoxFit.fill,
              ),
            ),
          )
        ],
      ),
    );
  }

// The body contains two main sections: suggested places and popular places.
  Widget _body() {
    return Expanded(
      child: Column(
        children: [
          _suggestedkPlaces(),
          _popularPlaces(),
        ],
      ),
    );
  }

// Displays a list of suggested places in a grid. It uses a GridView.builder to
// show the places in a 2-column grid. Each place is shown using the PlaceCard widget.
  Widget _suggestedkPlaces() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizeConfig().vSpace(1),
          Text(
            'Suggested Places',
            style: TextStyle(
              fontSize: SizeConfig.defaultSize! * 1.8,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizeConfig().vSpace(1),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.zero,
              itemCount: PlacesData().suggestedPlaces().length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: SizeConfig.defaultSize! * 0.067,
              ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizeConfig().vSpace(1),
        Text(
          'Popular Places',
          style: TextStyle(
            fontSize: SizeConfig.defaultSize! * 1.8,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizeConfig().vSpace(1),
        SizedBox(
          height: SizeConfig.screenHeight! / 3.5,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: PlacesData().popularPlaces().length,
            itemBuilder: (context, index) {
              return LandmarkCard(place: PlacesData().popularPlaces()[index]);
            },
          ),
        ),
        SizeConfig().vSpace(0.4),
      ],
    );
  }
}
