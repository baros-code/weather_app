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
      width: 180,
      backgroundColor: context.colorScheme.primary,
      child: Column(
        children: [
          Text(
            label,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onPrimary,
            ),
          ),
          Text(
            value,
            style: context.textTheme.titleLarge?.copyWith(
              color: context.colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
