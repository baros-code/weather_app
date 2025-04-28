import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/presentation/controller.dart';
import '../../../../shared/data/services/location_service.dart';
import '../../../../shared/utils/app_router.dart';
import '../cubit/weather_cubit.dart';

class HomeController extends Controller<Address> {
  HomeController(
    super.logger,
    super.popupManager,
  );

  late final WeatherCubit _weatherCubit;
  late Address currentAddress;

  @override
  void onStart() {
    super.onStart();
    currentAddress = params ?? Address.newYork();
    _weatherCubit = context.read<WeatherCubit>();
    _weatherCubit.getCurrentWeather(currentAddress.city);
  }

  void getCurrentWeather(String cityName) {
    if (cityName.isEmpty) {
      return;
    }
    _weatherCubit.getCurrentWeather(cityName);
    // Update the current address
    currentAddress = Address(city: cityName);
  }

  void goToForecastPage() {
    context.goNamed(AppRoutes.forecastRoute.name, extra: currentAddress);
  }
}
