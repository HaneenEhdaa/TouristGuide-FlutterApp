// widgets/custom_snack_bar.dart
import 'package:flutter/material.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

class CustomSnackBar {
  // Helper method to get responsive dimensions
  static double _getResponsiveDimension(BuildContext context, double percentage) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    return screenWidth * percentage;
  }

  // Helper method to get responsive font size
  static double _getResponsiveFontSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = (screenWidth * 0.04).clamp(baseSize - 2, baseSize + 4);
    return fontSize;
  }

  // Helper method to get responsive padding
  static EdgeInsets _getResponsivePadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return EdgeInsets.symmetric(
      horizontal: (screenWidth * 0.04).clamp(12.0, 24.0),
      vertical: (screenWidth * 0.02).clamp(8.0, 16.0),
    );
  }

  // Helper method to get responsive border radius
  static double _getResponsiveBorderRadius(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return (screenWidth * 0.05).clamp(16.0, 24.0);
  }

  // Success SnackBar
  static void showSuccess({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    final fontSize = _getResponsiveFontSize(context, 16);
    final borderRadius = _getResponsiveBorderRadius(context);

    AnimatedSnackBar.material(
      message,
      type: AnimatedSnackBarType.success,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      duration: duration,
      borderRadius: BorderRadius.circular(borderRadius),

    ).show(context);
  }

  // Error SnackBar
  static void showError({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    final fontSize = _getResponsiveFontSize(context, 16);
    final borderRadius = _getResponsiveBorderRadius(context);

    AnimatedSnackBar.material(
      message,
      type: AnimatedSnackBarType.error,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      duration: duration,
      borderRadius: BorderRadius.circular(borderRadius),

    ).show(context);
  }

  // Warning SnackBar
  static void showWarning({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    final fontSize = _getResponsiveFontSize(context, 16);
    final borderRadius = _getResponsiveBorderRadius(context);

    AnimatedSnackBar.material(
      message,
      type: AnimatedSnackBarType.warning,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      duration: duration,
      borderRadius: BorderRadius.circular(borderRadius),

    ).show(context);
  }

  // Info SnackBar
  static void showInfo({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    final fontSize = _getResponsiveFontSize(context, 16);
    final borderRadius = _getResponsiveBorderRadius(context);

    AnimatedSnackBar.material(
      message,
      type: AnimatedSnackBarType.info,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      duration: duration,
      borderRadius: BorderRadius.circular(borderRadius),

    ).show(context);
  }

  // Custom SnackBar with more customization options
  static void showCustom({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    required IconData icon,
    Duration duration = const Duration(seconds: 3),
    Color textColor = Colors.white,
    double? fontSize,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    final responsiveFontSize = fontSize ?? _getResponsiveFontSize(context, 16);
    final responsivePadding = _getResponsivePadding(context);
    final borderRadius = _getResponsiveBorderRadius(context);
    final iconSize = _getResponsiveDimension(context, 0.06).clamp(20.0, 28.0);
    final containerWidth = _getResponsiveDimension(context, 0.9); // 90% of screen width

    AnimatedSnackBar(
      builder: (context) {
        return Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: containerWidth,
              minWidth: containerWidth * 0.5,
            ),
            padding: responsivePadding,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: textColor,
                  size: iconSize,
                ),
                SizedBox(width: _getResponsiveDimension(context, 0.02)),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                      color: textColor,
                      fontSize: responsiveFontSize,
                      fontWeight: fontWeight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      duration: duration,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
    ).show(context);
  }

  // Optional: Add a method for handling different screen orientations
  static MobileSnackBarPosition _getSnackBarPosition(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait
        ? MobileSnackBarPosition.bottom
        : MobileSnackBarPosition.top;
  }
}