import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_guide/core/widgets/governorate_card.dart';
import 'package:tourist_guide/data/models/governorate_model.dart';
import 'package:tourist_guide/data/places_data/governorate_data.dart';

class GovernorateScreen extends StatelessWidget {
  const GovernorateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 8.h),
          Text(
            'Governorates',
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 0.03.sh),
          Expanded(
            child: Container(
              // padding: EdgeInsets.symmetric(vertical: 16.h),
              child: GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: GovernorateData.governorateList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.60,
                  ),
                  itemBuilder: (context, index) => GovernorateCard(
                        governorate: GovernorateData.governorateList[index],
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
