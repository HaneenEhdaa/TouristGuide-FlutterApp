import 'package:flutter/material.dart';

class Governorate {
  late String id;
  late List<Image> imgPath;
  late String name;
  late String? description;
// Constructor to create a Place object from a list of shared preferences data.
  Governorate({
    required this.id,
    required this.imgPath,
    required this.name,
    this.description
  });

}
