// ignore_for_file: must_be_immutable
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_guide/core/colors/colors.dart';
import 'package:tourist_guide/core/widgets/favorite_btn.dart';
import 'package:tourist_guide/core/widgets/landmark_card.dart';
import 'package:tourist_guide/data/models/landmark_model.dart';
import 'package:tourist_guide/data/places_data/places_data.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  //using SingleTickerProvider mixin to use on animation controller.

  late final AnimationController _controller; // Controller for fade animations
  late final List<Animation<double>> _fadeAnimations; // List of fade animations

  @override
  void initState() {
    super.initState();

    // Initializing animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    // Creating a sequence of fade animations with staggered intervals.
    _fadeAnimations = List.generate(
      4,
      (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index * 0.25,
            (index + 1) * 0.25,
            curve: Curves.easeIn,
          ),
        ),
      ),
    );

    // Starting the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Retrieving landmark data passed via arguments
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    LandMark landMark = arguments["landMark"];

    return Scaffold(
      body: Padding(
        padding: REdgeInsets.symmetric(
          // Responsive padding
          horizontal: 15,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.h,
              ),
              FadeTransition(
                  opacity: _fadeAnimations[0],
                  child: _coverImage(context, landMark)), // Cover image section
              SizedBox(
                height: 16.h,
              ),
              FadeTransition(
                  opacity: _fadeAnimations[1],
                  child: _placeDetails(landMark)), // Place details section
              SizedBox(
                height: 16.h,
              ),
              FadeTransition(
                opacity: _fadeAnimations[2],
                child: Text(
                  textAlign: TextAlign.center,
                  landMark.description!, // Displaying the landmark description
                  overflow: TextOverflow.fade,
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),
                ),
              ),
              PlacesData()
                      .nearbyPlaces(landMark)
                      .isNotEmpty // Conditional rendering of Nearby places

                  ? FadeTransition(
                      opacity: _fadeAnimations[3],
                      child: _nearbyPlaces(landMark))
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for displaying landmark details
  Widget _placeDetails(LandMark landMark) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              landMark.name,
              style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.place,
              color: kMainColor,
            ),
            Text(
              landMark.governorate,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                  color: kMainColor),
            ),
            Spacer(),
            Icon(
              Icons.star,
              color: kMainColor,
              size: 30,
            ),
            Text(
              landMark.rate,
              style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }

  // Widget for displaying the cover image with a carousel slider
  Widget _coverImage(BuildContext context, LandMark landMark) {
    return Stack(
      children: [
        SizedBox(
          height: 400.h,
          child: CarouselSlider.builder(
              itemCount: landMark.imgPath.length,
              itemBuilder: (context, index, realIndex) => ClipRRect(
                    borderRadius: BorderRadius.circular(34),
                    child: Image(
                      image: landMark.imgPath[index].image,
                      fit: BoxFit.cover,
                      height: 400.h,
                      width: double.infinity,
                    ),
                  ),
              options: CarouselOptions(
                  autoPlay: true, // Automatic sliding
                  autoPlayInterval: const Duration(seconds: 3),
                  viewportFraction: 1,
                  height: 400.h)),
        ),
        _backButton(context), // Back button widget
        Positioned(
            right: 15,
            bottom: 10,
            child: FavoriteButton(
                place: landMark,
                isFromFav:
                    false)), //using Favorite button created in widgets folder.
      ],
    );
  }

  // Widget for back navigation button
  Widget _backButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Image.asset(
        'assets/images/arrowBack.png',
        width: 100.w,
        height: 100.h,
      ),
    );
  }

  // Widget for displaying nearby Places.
  Widget _nearbyPlaces(LandMark landmark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          height: 30.h,
        ),
        Text(
          'Nearby Places',
          style: TextStyle(
              fontSize: 20.sp, fontWeight: FontWeight.bold, color: kMainColor),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 250.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: PlacesData().nearbyPlaces(landmark).length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 200.w,
                child: LandmarkCard(
                  place: PlacesData().nearbyPlaces(landmark)[index],
                  isFromFav: false,
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
