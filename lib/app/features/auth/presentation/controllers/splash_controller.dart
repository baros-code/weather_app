import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      Navigator.pushNamed(
        context,
        AppRouter.homePage,
        arguments: state.address,
      );
    } else if (state is DeviceLocationError) {
      Navigator.pushNamed(context, AppRouter.homePage);
    }
  }
}
