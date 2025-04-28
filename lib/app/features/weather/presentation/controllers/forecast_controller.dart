import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/controller.dart';
import '../../../../shared/data/services/location_service.dart';
import '../../domain/entities/daily_forecast.dart';
import '../cubit/weather_cubit.dart';
import '../pages/weather_details_popup.dart';

class ForecastController extends Controller<Address> {
  ForecastController(
    super.logger,
    super.popupManager,
  );

  late final Address currentAddress;
  late WeatherCubit _weatherCubit;

  @override
  void onStart() {
    super.onStart();
    currentAddress = params!;
    _weatherCubit = context.read<WeatherCubit>();
    _weatherCubit.getWeeklyForecast(currentAddress.city);
  }

  void showWeatherDetails(DailyForecast forecast) {
    popupManager.showFullScreenPopup(context, WeatherDetailsPopup(forecast));
  }
}
