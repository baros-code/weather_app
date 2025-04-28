import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/build_context_ext.dart';
import 'weather_label_card.dart';

class WeatherDetailsView extends StatelessWidget {
  const WeatherDetailsView({
    super.key,
    required this.name,
    required this.temperature,
    required this.weatherIconUrl,
    required this.humidity,
    required this.windSpeed,
    required this.visibility,
    required this.windDirection,
  });

  final String? name;
  final String temperature;
  final String weatherIconUrl;
  final String humidity;
  final String windSpeed;
  final String visibility;
  final String windDirection;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (name != null)
          RichText(
            text: TextSpan(
              text: 'Weather in ',
              style: context.textTheme.titleMedium,
              children: [
                TextSpan(
                  text: name,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        CachedNetworkImage(
          imageUrl: weatherIconUrl,
          fit: BoxFit.cover,
          width: 160,
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Text(
          temperature,
          style: context.textTheme.headlineMedium,
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            WeatherLabelCard(
              label: 'Humidity',
              value: humidity,
            ),
            const SizedBox(width: 8),
            WeatherLabelCard(
              label: 'Wind',
              value: windSpeed,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            WeatherLabelCard(
              label: 'Visibility',
              value: visibility,
            ),
            const SizedBox(width: 8),
            WeatherLabelCard(
              label: 'Wind Direction',
              value: windDirection,
            ),
          ],
        ),
      ],
    );
  }
}
