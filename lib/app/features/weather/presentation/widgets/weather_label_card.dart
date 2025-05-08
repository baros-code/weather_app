import 'package:flutter/material.dart';

import '../../../../shared/presentation/widgets/custom_card.dart';
import '../../../../shared/utils/build_context_ext.dart';

class WeatherLabelCard extends StatelessWidget {
  const WeatherLabelCard({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        children: [
          Text(
            label,
            style: context.textTheme.bodyMedium,
          ),
          Text(
            value,
            style: context.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
