// widgets/custom_button.dart
import 'package:flutter/material.dart';
import 'package:tourist_guide/core/colors/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final double? fontSize;
  final double? borderRadius;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.fontSize,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final size = MediaQuery.of(context).size;

    // Default responsive values
    final defaultWidth = size.width * 0.85;    // 85% of screen width
    final defaultHeight = size.height * 0.06;   // 6% of screen height
    final defaultFontSize = size.width * 0.04;  // 4% of screen width
    final defaultBorderRadius = size.width * 0.05; // 5% of screen width

    // Use provided values or defaults
    final buttonWidth = width ?? defaultWidth;
    final buttonHeight = height ?? defaultHeight;
    final buttonFontSize = fontSize ?? defaultFontSize;
    final buttonBorderRadius = borderRadius ?? defaultBorderRadius;

    return SizedBox(
      width: buttonWidth.clamp(
          size.width * 0.3,  // min: 30% of screen width
          size.width * 0.9   // max: 90% of screen width
      ),
      height: buttonHeight.clamp(
          size.height * 0.05,  // min: 5% of screen height
          size.height * 0.08   // max: 8% of screen height
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: kMainColor,
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.012,  // 1.2% of screen height
              horizontal: size.width * 0.04    // 4% of screen width
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: buttonFontSize.clamp(
                size.width * 0.03,  // min: 3% of screen width
                size.width * 0.05   // max: 5% of screen width
            ),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}