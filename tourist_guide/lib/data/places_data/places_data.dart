import 'package:tourist_guide/core/utils/user_manager.dart';
import 'package:tourist_guide/data/models/landmark_model.dart';

class PlacesData {
  static List<String> favPlaces = UserManager().getFavPlaces();

  static List<LandMark> kLandmarks = [
    LandMark(
        id: '0',
        imgPath: 'assets/images/card_bg.png',
        name: 'Place 1',
        governorate: 'Governorate 1',
        rate: '5.0',
        fav: favPlaces.contains('0') ? true : false,
        description: '''
This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...
'''),
    LandMark(
        id: '1',
        imgPath: 'assets/images/card_bg.png',
        name: 'Place 2',
        governorate: 'Governorate 2',
        rate: '5.0',
        fav: favPlaces.contains('1') ? true : false,
        description: '''
This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...
'''),
    LandMark(
        id: '2',
        imgPath: 'assets/images/card_bg.png',
        name: 'Place 3',
        governorate: 'Governorate 3',
        rate: '4.8',
        fav: favPlaces.contains('2') ? true : false,
        description: '''
This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...
'''),
    LandMark(
        id: '3',
        imgPath: 'assets/images/card_bg.png',
        name: 'Place 4',
        governorate: 'Governorate 4',
        rate: '4.9',
        fav: favPlaces.contains('3') ? true : false,
        description: '''
This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...
'''),
    LandMark(
        id: '4',
        imgPath: 'assets/images/card_bg.png',
        name: 'Place 5',
        governorate: 'Governorate 5',
        rate: '4.9',
        fav: favPlaces.contains('4') ? true : false,
        description: '''
This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...
'''),
    LandMark(
        id: '5',
        imgPath: 'assets/images/card_bg.png',
        name: 'Place 6',
        governorate: 'Governorate 6',
        rate: '4.9',
        fav: favPlaces.contains('5') ? true : false,
        description: '''
This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...This is Test Description...
'''),
  ];

  List<LandMark> suggestedPlaces() {
    List<LandMark> suggestedPlaces = [];
    for (int i = 0; i < kLandmarks.length; i++) {
      if (i.isEven) {
        suggestedPlaces.add(kLandmarks[i]);
      }
    }
    return suggestedPlaces;
  }

  List<LandMark> popularPlaces() {
    List<LandMark> popularPlaces = [];
    for (int i = 0; i < kLandmarks.length; i++) {
      if (i.isOdd) {
        popularPlaces.add(kLandmarks[i]);
      }
    }
    return popularPlaces;
  }

  List<LandMark> favoritePlaces() {
    List<LandMark> favoritePlaces = [];
    for (int i = 0; i < kLandmarks.length; i++) {
      if (kLandmarks[i].fav) {
        favoritePlaces.add(kLandmarks[i]);
      }
    }
    return favoritePlaces;
  }
}
