import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/presentation/controller.dart';
import '../../../../shared/presentation/cubit/cubit/device_location_cubit.dart';
import '../../../../shared/utils/app_router.dart';

class SplashController extends Controller<Object> {
  SplashController(
    super.logger,
    super.popupManager,
  );

  late final DeviceLocationCubit _deviceLocationCubit;

  @override
  void onStart() {
    super.onStart();
    _deviceLocationCubit = context.read<DeviceLocationCubit>();
    _deviceLocationCubit.getCurrentAddress();
  }

  void handleLocationStates(DeviceLocationState state) {
    if (state is DeviceLocationLoaded) {
      context.goNamed(AppRoutes.homeRoute.name, extra: state.address);
    } else if (state is DeviceLocationError) {
      context.goNamed(AppRoutes.homeRoute.name);
    }
  }
}
