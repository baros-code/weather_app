import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/controlled_view.dart';
import '../../../../shared/data/services/location_service.dart';
import '../../../../shared/presentation/widgets/base_page.dart';
import '../../../../shared/utils/build_context_ext.dart';
import '../controllers/forecast_controller.dart';
import '../cubit/weather_cubit.dart';
import '../widgets/daily_weather_card.dart';

class ForecastPage extends ControlledView<ForecastController, Address> {
  ForecastPage({
    super.key,
    super.params,
  });

  @override
  Widget build(BuildContext context) {
    return BasePage(
      backButtonEnabled: true,
      title: Text(
        'Weekly Forecast',
        style: context.textTheme.headlineSmall,
      ),
      body: _Body(controller),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body(this.controller);

  final ForecastController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BlocBuilder<WeatherCubit, WeatherState>(
            buildWhen: (previous, current) =>
                current is WeeklyForecastLoading ||
                current is WeeklyForecastLoaded ||
                current is WeeklyForecastError,
            builder: (context, state) {
              if (state is WeeklyForecastLoading) {
                return Expanded(
                  child: const Center(child: CircularProgressIndicator()),
                );
              } else if (state is WeeklyForecastLoaded) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.forecast.length,
                    itemBuilder: (context, index) {
                      final forecast = state.forecast[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: DailyWeatherCard(
                          forecast,
                          onTap: () => controller.showWeatherDetails(forecast),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is WeeklyForecastError) {
                return Center(child: Text('state.error'));
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
