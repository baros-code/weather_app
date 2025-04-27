import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/controller.dart';
import '../../../../shared/data/services/location_service.dart';
import '../cubit/weather_cubit.dart';

class HomeController extends Controller<Address> {
  HomeController(
    super.logger,
    super.popupManager,
  );

  late final WeatherCubit _weatherCubit;
  late final Address? currentAddress;

  @override
  void onStart() {
    super.onStart();
    currentAddress = params;
    _weatherCubit = context.read<WeatherCubit>();
    _weatherCubit.getCurrentWeather(currentAddress?.city ?? 'New York');
  }

  void getCurrentWeather(String cityName) {
    if (cityName.isEmpty) {
      return;
    }
    _weatherCubit.getCurrentWeather(cityName);
  }
}
