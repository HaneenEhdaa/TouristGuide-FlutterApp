import 'package:flutter/material.dart';
import 'package:tourist_guide/core/widgets/governorate_card.dart';
import 'package:tourist_guide/data/models/governorate_model.dart';
import 'package:tourist_guide/data/places_data/governorate_data.dart';

class GovernorateScreen extends StatelessWidget {
  const GovernorateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: GovernorateData.governorateList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.65),
        itemBuilder: (context, index) =>
            GovernorateCard(governorate: GovernorateData.governorateList[index],
            )
      ),
    );
  }
}
