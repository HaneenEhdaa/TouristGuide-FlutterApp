import 'package:flutter/material.dart';

// A utility class to manage screen dimensions and adapt UI to various screen sizes.
class SizeConfig {
  // Static variables to store screen width, height, a default size, and screen orientation.
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  // Method to initialize screen properties based on the given BuildContext.
  void init(BuildContext context) {
    // Fetch and store the screen's width and height.
    screenWidth = MediaQuery.sizeOf(context).width;
    screenHeight = MediaQuery.sizeOf(context).height;

    // Fetch and store the current screen orientation (landscape or portrait).
    orientation = MediaQuery.of(context).orientation;

    // Calculate a default size value based on the screen orientation.
    // In landscape mode, use the height; in portrait mode, use the width.
    defaultSize = orientation == Orientation.landscape
        ? screenHeight! * .024
        : screenWidth! * .024;

    // Print the default size value to the console for debugging purposes.
    debugPrint('=====\ndefaultSize = $defaultSize\n=====');
  }

  Widget vSpace(double space) {
    return SizedBox(height: defaultSize! * space);
  }

  Widget hSpace(double space) {
    return SizedBox(width: defaultSize! * space);
  }
}
