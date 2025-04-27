import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/network/api_manager_helpers.dart';
import '../../../../../core/presentation/controlled_view.dart';
import '../../../../shared/presentation/widgets/custom_search_bar.dart';
import '../../../../shared/utils/build_context_ext.dart';
import '../../../../shared/data/services/location_service.dart';
import '../controllers/home_controller.dart';
import '../cubit/weather_cubit.dart';

class HomePage extends ControlledView<HomeController, Address> {
  HomePage({
    super.key,
    super.params,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: context.colorScheme.primaryContainer,
      appBar: AppBar(
        backgroundColor: context.colorScheme.primaryContainer,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Weather App',
          style: context.textTheme.headlineSmall,
        ),
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
      ),
      body: SafeArea(child: _Body(controller)),
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
                initialValue: controller.currentAddress?.city,
                hintText: 'Search for a city',
                onChange: controller.getCurrentWeather,
              ),
              const SizedBox(height: 16),
              _CurrentWeatherSection(state),
              const Spacer(),
              ElevatedButton(
                child: Text('View Forecast (7 days)'),
                onPressed: () {},
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
      return const Center(child: CircularProgressIndicator());
    }
    if (state is CurrentWeatherError) {
      if ((state as CurrentWeatherError).errorType == ApiErrorType.notFound) {
        return const Center(child: Text('The city was not found'));
      }
      return const Center(child: Text('Error loading weather data'));
    }
    if (state is CurrentWeatherLoaded) {
      final currentWeather = (state as CurrentWeatherLoaded).currentWeather;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Location: ${currentWeather.name}',
            style: context.textTheme.titleLarge,
          ),
          Text(
            'Temperature: ${currentWeather.temperatureLabel},',
            style: context.textTheme.titleLarge,
          ),
          Text(
            'Weather: ${currentWeather.weatherDescription}',
            style: context.textTheme.titleLarge,
          ),
          Text(
            'Humidity: ${currentWeather.humidityLabel}',
            style: context.textTheme.titleLarge,
          ),
          Text(
            'Wind Speed: ${currentWeather.windSpeedLabel}',
            style: context.textTheme.titleLarge,
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
