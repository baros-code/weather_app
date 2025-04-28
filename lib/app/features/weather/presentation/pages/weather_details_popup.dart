import 'package:flutter/material.dart';

import '../../../../shared/presentation/widgets/base_page.dart';
import '../../../../shared/utils/build_context_ext.dart';
import '../../../../shared/utils/date_time_ext.dart';
import '../../domain/entities/daily_forecast.dart';
import '../widgets/weather_details_view.dart';

class WeatherDetailsPopup extends StatelessWidget {
  const WeatherDetailsPopup(this.forecast, {super.key});

  final DailyForecast forecast;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      backButtonEnabled: true,
      title: Text(
        '${forecast.date.monthNameAndDay()}, ${forecast.date.dayName()}',
        style: context.textTheme.headlineSmall,
      ),
      body: _Body(forecast),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body(this.forecast);

  final DailyForecast forecast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: WeatherDetailsView(
        name: null,
        temperature: forecast.temperatureLabel,
        weatherIconUrl: forecast.weatherIconUrl,
        humidity: forecast.humidityLabel,
        windSpeed: forecast.windSpeedLabel,
        visibility: forecast.visibilityLabel,
        windDirection: forecast.windDirectionLabel,
      ),
    );
  }
}
