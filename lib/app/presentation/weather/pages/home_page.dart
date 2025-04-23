import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/controlled_view.dart';
import '../controllers/home_controller.dart';
import '../cubit/cubit/weather_cubit.dart';

class HomePage extends ControlledView<HomeController, Object> {
  HomePage({
    super.key,
    super.params,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Weather App'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Current Weather',
                ),
                // Add your weather data display here
              ],
            ),
          ),
        );
      },
    );
  }
}
