import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/network/api_manager_helpers.dart';
import '../../../../../core/presentation/controlled_view.dart';
import '../../../../shared/presentation/widgets/base_page.dart';
import '../../../../shared/presentation/widgets/custom_search_bar.dart';
import '../../../../shared/utils/build_context_ext.dart';
import '../controllers/home_controller.dart';
import '../cubit/weather_cubit.dart';
import '../widgets/weather_details_view.dart';

// TODO(Baran): Fix overflow when keyboard is open.
class HomePage extends ControlledView<HomeController, Object> {
  HomePage({
    super.key,
    super.params,
  });

  @override
  Widget build(BuildContext context) {
    return BasePage(
      resizeToAvoidBottomInset: false,
      title: Text('Weather App'),
      actions: [
        IconButton(
          onPressed: () => context.themeProvider.toggleThemeMode(),
          icon: const Icon(Icons.brightness_4),
        ),
        IconButton(
          onPressed: () =>
              context.localizationProvider.setLocale(const Locale('es')),
          icon: const Icon(Icons.language),
        ),
      ],
      body: _Body(controller),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body(this.controller);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      buildWhen: (previous, current) =>
          current is CurrentWeatherLoading ||
          current is CurrentWeatherLoaded ||
          current is CurrentWeatherError,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // TODO(Baran): Add suggestions as enhancement.
              CustomSearchBar(
                initialValue: controller.currentAddress.city,
                hintText: 'Search for a city',
                onChange: controller.getCurrentWeather,
              ),
              const SizedBox(height: 16),
              _CurrentWeatherSection(state),
              const Spacer(),
              ElevatedButton(
                onPressed: controller.goToForecastPage,
                child: Text('View Forecast (7 days)'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CurrentWeatherSection extends StatelessWidget {
  const _CurrentWeatherSection(this.state);

  final WeatherState state;

  @override
  Widget build(BuildContext context) {
    if (state is CurrentWeatherLoading) {
      return Expanded(child: const Center(child: CircularProgressIndicator()));
    }
    if (state is CurrentWeatherError) {
      if ((state as CurrentWeatherError).errorType == ApiErrorType.notFound) {
        return Expanded(
          child: const Center(child: Text('The city was not found')),
        );
      }
      return Expanded(
        child: const Center(child: Text('Error loading weather data')),
      );
    }
    if (state is CurrentWeatherLoaded) {
      final currentWeather = (state as CurrentWeatherLoaded).currentWeather;
      return WeatherDetailsView(
        name: currentWeather.name,
        temperature: currentWeather.temperatureLabel,
        weatherIconUrl: currentWeather.weatherIconUrl,
        humidity: currentWeather.humidityLabel,
        windSpeed: currentWeather.windSpeedLabel,
        visibility: currentWeather.visibilityLabel,
        windDirection: currentWeather.windDirectionLabel,
      );
    }
    return const SizedBox.shrink();
  }
}
