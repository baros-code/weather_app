import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../../core/network/api_manager_helpers.dart';
import '../../../../../core/presentation/controlled_view.dart';
import '../../../../shared/presentation/widgets/base_page.dart';
import '../../../../shared/presentation/widgets/custom_search_bar.dart';
import '../../../../shared/utils/build_context_ext.dart';
import '../../../../shared/utils/theme_provider.dart';
import '../controllers/home_controller.dart';
import '../cubit/weather_cubit.dart';
import '../widgets/weather_details_view.dart';

class HomePage extends ControlledView<HomeController, Object> {
  HomePage({
    super.key,
    super.params,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return BasePage(
          resizeToAvoidBottomInset: false,
          title: Text(context.localizations.weather_app),
          actions: [
            IconButton(
              onPressed: () => context.themeProvider.toggleThemeMode(),
              icon: const Icon(Icons.brightness_4),
            ),
            IconButton(
              onPressed: controller.toggleLanguage,
              icon: const Icon(Icons.language),
            ),
          ],
          body: _Body(controller),
        );
      },
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
                hintText: context.localizations.search_for_city,
                onChange: controller.getCurrentWeather,
              ),
              const SizedBox(height: 16),
              _CurrentWeatherSection(state),
              const Spacer(),
              ElevatedButton(
                onPressed: state is CurrentWeatherLoaded
                    ? controller.goToForecastPage
                    : controller.showToastMessage,
                child: Text(context.localizations.view_forecast_7_days),
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
          child: Center(
            child: Text(
              context.localizations.city_not_found,
              style: context.textTheme.titleMedium,
            ),
          ),
        );
      }
      return Expanded(
        child: Center(
          child: Text(
            context.localizations.error_loading_data,
            style: context.textTheme.titleMedium,
          ),
        ),
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
