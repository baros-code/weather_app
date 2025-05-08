import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/build_context_ext.dart';
import 'weather_label_card.dart';

class WeatherDetailsView extends StatelessWidget {
  const WeatherDetailsView({
    super.key,
    this.name,
    required this.temperature,
    required this.weatherIconUrl,
    required this.humidity,
    required this.windSpeed,
    required this.visibility,
    required this.windDirection,
    this.minTemperature,
    this.maxTemperature,
  });

  final String? name;
  final String temperature;
  final String weatherIconUrl;
  final String humidity;
  final String windSpeed;
  final String visibility;
  final String windDirection;
  final String? minTemperature;
  final String? maxTemperature;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (name != null)
          RichText(
            text: TextSpan(
              text: context.localizations.weather_in,
              style: context.textTheme.titleMedium,
              children: [
                TextSpan(
                  text: ' $name',
                  style: context.textTheme.titleMedium,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (minTemperature != null)
              Text(
                '${context.localizations.min}: $minTemperature',
                style: context.textTheme.titleMedium,
              ),
            const Spacer(),
            Text(
              temperature,
              style: context.textTheme.headlineMedium,
            ),
            const Spacer(),
            if (maxTemperature != null)
              Text(
                '${context.localizations.max}: $maxTemperature',
                style: context.textTheme.titleMedium,
              ),
          ],
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: WeatherLabelCard(
                label: context.localizations.humidity,
                value: humidity,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: WeatherLabelCard(
                label: context.localizations.wind,
                value: windSpeed,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: WeatherLabelCard(
                label: context.localizations.visibility,
                value: visibility,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: WeatherLabelCard(
                label: context.localizations.wind_direction,
                value: windDirection,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
