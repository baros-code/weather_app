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

  void goToForecastPage() {
    if (currentAddress == null) {
      popupManager.showToastMessage(context, 'Please select a city first');
    }
    context.goNamed(AppRoutes.forecastRoute.name, extra: currentAddress);
  }
}
