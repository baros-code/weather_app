import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../shared/presentation/widgets/custom_card.dart';
import '../../../../shared/utils/build_context_ext.dart';
import '../../../../shared/utils/date_time_ext.dart';
import '../../domain/entities/daily_forecast.dart';

class DailyWeatherCard extends StatelessWidget {
  const DailyWeatherCard(this.dailyForecast, {required this.onTap, super.key});

  final DailyForecast dailyForecast;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: onTap,
      backgroundColor: context.colorScheme.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                dailyForecast.date.dayName(),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onPrimary,
                ),
              ),
              Text(
                dailyForecast.date.monthNameAndDay(),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
          Text(
            dailyForecast.temperatureLabel,
            style: context.textTheme.headlineSmall?.copyWith(
              color: context.colorScheme.onPrimary,
            ),
          ),
          CachedNetworkImage(
            imageUrl: dailyForecast.weatherIconUrl,
          ),
        ],
      ),
    );
  }
}
