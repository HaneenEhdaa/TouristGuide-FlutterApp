import 'package:flutter/material.dart';
import 'package:tourist_guide/core/colors/colors.dart';
import 'package:tourist_guide/core/utils/size_config.dart';
import 'package:tourist_guide/core/widgets/landmark_card.dart';
import 'package:tourist_guide/data/models/landmark_model.dart';

class PlacesScreen extends StatelessWidget {
  const PlacesScreen({super.key});

  static List<LandMark> kLandmarks = [
    LandMark(
      id: '0',
      imgPath: 'assets/images/card_bg.png',
      name: 'Place 1',
      governorate: 'Gocernorate 1',
      rate: '5.0',
      fav: false,
    ),
    LandMark(
      id: '1',
      imgPath: 'assets/images/card_bg.png',
      name: 'Place 2',
      governorate: 'Governorate 2',
      rate: '5.0',
      fav: false,
    ),
    LandMark(
      id: '2',
      imgPath: 'assets/images/card_bg.png',
      name: 'Place 3',
      governorate: 'Governorate 3',
      rate: '4.8',
      fav: false,
    ),
    LandMark(
      id: '3',
      imgPath: 'assets/images/card_bg.png',
      name: 'Place 4',
      governorate: 'Governorate 4',
      rate: '4.9',
      fav: false,
    ),
    LandMark(
      id: '4',
      imgPath: 'assets/images/card_bg.png',
      name: 'Place 5',
      governorate: 'Governorate 5',
      rate: '4.9',
      fav: false,
    ),
    LandMark(
      id: '5',
      imgPath: 'assets/images/card_bg.png',
      name: 'Place 6',
      governorate: 'Governorate 6',
      rate: '4.9',
      fav: false,
    ),
  ];

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
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizeConfig().vSpace(0.5),
              Text(
                'Discover best places to go to vacation 😍',
                style: const TextStyle(fontSize: 16, color: kLightBlack),
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
          SizeConfig().vSpace(2),
          Text(
            'Suggested Places',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizeConfig().vSpace(1),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.zero,
              itemCount: kLandmarks.length ~/ 2,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.67,
              ),
              itemBuilder: (context, index) =>
                  LandmarkCard(place: kLandmarks[index]),
            ),
          ),
        ],
      ),
    );
  }

// Displays a list of popular places (which is the reverse order of kPlaces) in
// a horizontal scrolling list. The PlaceCard widget is used for each place in the list.
  Widget _popularPlaces() {
    List<LandMark> popularPlaces = kLandmarks.reversed.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizeConfig().vSpace(2),
        Text(
          'Popular Places',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizeConfig().vSpace(1),
        SizedBox(
          height: SizeConfig.defaultSize! * 30,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: (kLandmarks.length) - (kLandmarks.length ~/ 2),
            itemBuilder: (context, index) {
              return LandmarkCard(place: popularPlaces[index]);
            },
          ),
        ),
        SizeConfig().vSpace(0.4),
      ],
    );
  }
}
