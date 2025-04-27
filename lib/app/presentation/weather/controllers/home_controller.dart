import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/controller.dart';
import '../cubit/cubit/weather_cubit.dart';

class HomeController extends Controller<Object> {
  HomeController(
    super.logger,
    super.popupManager,
  );

  late final WeatherCubit _weatherCubit;

  @override
  void onStart() {
    super.onStart();
    _weatherCubit = context.read<WeatherCubit>();
    _weatherCubit.getCurrentWeather('New York');
  }

  void getCurrentWeather(String cityName) {
    if (cityName.isEmpty) {
      return;
    }
    _weatherCubit.getCurrentWeather(cityName);
  }
}
