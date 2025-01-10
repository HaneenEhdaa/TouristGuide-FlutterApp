import 'package:flutter/cupertino.dart';
import 'package:tourist_guide/data/models/governorate_model.dart';

class GovernorateData {
  static List<Governorate> governorateList = [
    Governorate(
        imgPath: [Image.asset('assets/images/sphinx2.jpg')],
        name: 'Giza'
    ),
    Governorate(
        imgPath: [Image.asset('assets/images/sphinx2.jpg')],
        name: 'Cairo'
    ),
    Governorate(
        imgPath: [Image.asset('assets/images/sphinx2.jpg')],
        name: 'Luxor'
    )
  ];
}
