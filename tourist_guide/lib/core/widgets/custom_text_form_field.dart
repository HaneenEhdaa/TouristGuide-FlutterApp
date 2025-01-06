// custom_text_field.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_picker/country_picker.dart';
import 'package:tourist_guide/core/colors/colors.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool isPassword;
  final TextEditingController? passwordController;
  final String fieldType;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.isPassword = false,
    this.passwordController,
    required this.fieldType,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  Country? _selectedCountry;
  bool _isPasswordFocused = false;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  final Map<String, bool> _passwordRequirements = {
    'Length': false,
    'Uppercase': false,
    'Lowercase': false,
    'Number': false,
    'Special': false,
  };

  @override
  void initState() {
    super.initState();
    _selectedCountry = CountryParser.parseCountryCode('EG');
    if (widget.fieldType == 'password') {
      _updatePasswordRequirements(widget.controller.text);
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _updatePasswordRequirements(String value) {
    setState(() {
      _passwordRequirements['Length'] = value.length >= 8;
      _passwordRequirements['Uppercase'] = value.contains(RegExp(r'[A-Z]'));
      _passwordRequirements['Lowercase'] = value.contains(RegExp(r'[a-z]'));
      _passwordRequirements['Number'] = value.contains(RegExp(r'[0-9]'));
      _passwordRequirements['Special'] =
          value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

      // Check if all requirements are met
      bool allRequirementsMet = _passwordRequirements.values.every((met) => met);

      // Remove overlay if all requirements are met
      if (allRequirementsMet && _overlayEntry != null) {
        Future.delayed(const Duration(milliseconds: 500), () {
          _removeOverlay();
        });
      }
    });
  }

  Widget _buildRequirement(String text, bool isMet) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: isMet ? 0.7 : 1.0,  // Fade out completed requirements
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                isMet ? Icons.check_circle : Icons.circle_outlined,
                size: 16,
                color: isMet ? kMainColor : Colors.grey,
                key: ValueKey(isMet),  // For animation
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: isMet ? kMainColor : Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _createOverlay() {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 250,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: const Offset(0, 60),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Password must contain:',
                    style: TextStyle(
                      color: kMainColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildRequirement('At least 8 characters', _passwordRequirements['Length']!),
                  _buildRequirement('At least one uppercase letter', _passwordRequirements['Uppercase']!),
                  _buildRequirement('At least one lowercase letter', _passwordRequirements['Lowercase']!),
                  _buildRequirement('At least one number', _passwordRequirements['Number']!),
                  _buildRequirement('At least one special character', _passwordRequirements['Special']!),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }




  void _showCountryPicker() {
    // Get screen dimensions
    final size = MediaQuery.of(context).size;
    final fontSize = (size.width * 0.04).clamp(14.0, 16.0);
    final flagSize = (size.width * 0.06).clamp(20.0, 25.0);
    final bottomSheetHeight = size.height * 0.7;

    showCountryPicker(
      context: context,
      showPhoneCode: true,
      searchAutofocus: true,
      showSearch: true,
      useRootNavigator: true,
      favorite: ['EG', 'SA', 'AE', 'US', 'GB'],
      countryListTheme: CountryListThemeData(
        flagSize: flagSize,
        backgroundColor: Colors.white,
        textStyle: TextStyle(fontSize: fontSize, color: Colors.black),
        bottomSheetHeight: bottomSheetHeight,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular((size.width * 0.05).clamp(16.0, 20.0)),
          topRight: Radius.circular((size.width * 0.05).clamp(16.0, 20.0)),
        ),
        searchTextStyle: TextStyle(
          color: kMainColor,
          fontSize: fontSize,
        ),
        inputDecoration: InputDecoration(
          counterStyle: TextStyle(color: kMainColor),
          labelText: 'Search',
          labelStyle: TextStyle(
            color: kMainColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
          hintText: 'Start typing to search',
          hintStyle: TextStyle(
            color: kMainColor.withOpacity(0.5),
            fontSize: fontSize * 0.9,
          ),
          prefixIcon: Icon(Icons.search, color: kMainColor),
          //suffixIcon: Icon(Icons.clear, color: kMainColor),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: kMainColor.withOpacity(0.2)),
            borderRadius: BorderRadius.circular((size.width * 0.05).clamp(16.0, 20.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kMainColor.withOpacity(0.2)),
            borderRadius: BorderRadius.circular((size.width * 0.05).clamp(16.0, 20.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kMainColor),
            borderRadius: BorderRadius.circular((size.width * 0.05).clamp(16.0, 20.0)),
          ),
          filled: true,
          fillColor: Colors.white,
          focusColor: kMainColor,
          contentPadding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04,
            vertical: size.height * 0.015,
          ),
        ),
      ),
      onSelect: (Country country) {
        setState(() {
          _selectedCountry = country;
          widget.controller.clear();
        });
      },
    );
  }

  String? _validateField(String? value) {
    switch (widget.fieldType) {
      case 'phone':
        if (value == null || value.isEmpty) {
          return null; // Optional field
        }

        String cleanNumber = value
            .replaceAll('+${_selectedCountry?.phoneCode}', '')
            .replaceAll(RegExp(r'[\s\-$$$$]'), '')
            .trim();

        if (cleanNumber.startsWith('0')) {
          cleanNumber = cleanNumber.substring(1);
        }

        switch (_selectedCountry?.countryCode) {
          case 'EG':
            if (!RegExp(r'^1[0125][0-9]{8}$').hasMatch(cleanNumber)) {
              return 'Please enter a valid Egyptian phone number';
            }
            break;
          default:
            if (cleanNumber.length < 7 || cleanNumber.length > 15) {
              return 'Please enter a valid phone number';
            }
        }
        return null;

      case 'name':
        if (value == null || value.isEmpty) {
          return 'Please enter your full name';
        }
        if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
          return 'Name should only contain letters';
        }
        if (value.length < 3) {
          return 'Name should be at least 3 characters';
        }
        if (!value[0].toUpperCase().contains(value[0])) {
          return 'First letter must be capitalized';
        }
        return null;

      case 'email':
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;

      case 'password':
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        }
        bool isValid = _passwordRequirements.values.every((requirement) => requirement);
        if (!isValid) {
          return 'Please meet all password requirements';
        }
        return null;

      case 'confirmPassword':
        if (value == null || value.isEmpty) {
          return 'Please confirm your password';
        }
        if (value != widget.passwordController?.text) {
          return 'Passwords do not match';
        }
        return null;

      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fontSize = (size.width * 0.04).clamp(13.0, 13.0);

    return CompositedTransformTarget(
      link: _layerLink,
      child: Focus(
        onFocusChange: (hasFocus) {
          if (widget.fieldType == 'password') {
            setState(() {
              _isPasswordFocused = hasFocus;
              if (hasFocus) {
                _createOverlay();
              } else {
                _removeOverlay();
              }
            });
          }
        },
        child: TextFormField(
          cursorColor: kMainColor,
          controller: widget.controller,
          style: TextStyle(fontSize: fontSize),
          onChanged: (value) {
            if (widget.fieldType == 'password') {
              _updatePasswordRequirements(value);
              if (_overlayEntry != null) {
                _overlayEntry!.markNeedsBuild();
              }
            }
          },
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.fieldType == 'phone'
                ? 'Enter phone number'
                : widget.hintText,
            labelStyle: TextStyle(
              color: kMainColor,
              fontSize: fontSize,
            ),
            prefixIcon: widget.fieldType == 'phone'
                ? GestureDetector(
              onTap: _showCountryPicker,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _selectedCountry?.flagEmoji ?? '🌍',
                      style: TextStyle(fontSize: fontSize * 1.2),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '+${_selectedCountry?.phoneCode ?? ''}',
                      style: TextStyle(
                        color: kMainColor,
                        fontSize: fontSize,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down, color: kMainColor),
                  ],
                ),
              ),
            )
                : Icon(widget.prefixIcon, color: kMainColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: kMainColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: const BorderSide(color: Colors.red),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: size.width * 0.06,
              vertical: size.height * 0.02,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: kMainColor,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            )
                : null,
          ),
          keyboardType: widget.fieldType == 'phone'
              ? TextInputType.phone
              : widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscureText: widget.isPassword ? _obscureText : false,
          validator: _validateField,
          inputFormatters: widget.fieldType == 'phone'
              ? [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
            PhoneNumberFormatter(),
          ]
              : null,
        ),
      ),
    );
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    String cleaned = newValue.text.replaceAll(RegExp(r'[\s\-$$$$]'), '');
    if (cleaned.startsWith('0')) {
      cleaned = cleaned.substring(1);
    }

    if (cleaned.length > 10) {
      cleaned = cleaned.substring(0, 10);
    }

    String formatted = '';
    for (int i = 0; i < cleaned.length; i++) {
      if (i == 3 || i == 6) {
        formatted += ' ';
      }
      formatted += cleaned[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}