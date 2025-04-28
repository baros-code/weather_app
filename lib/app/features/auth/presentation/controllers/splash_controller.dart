import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/presentation/controller.dart';
import '../../../../shared/presentation/cubit/cubit/device_location_cubit.dart';
import '../../../../shared/utils/app_router.dart';
import '../cubit/auth_cubit.dart';

class SplashController extends Controller<Object> {
  SplashController(
    super.logger,
    super.popupManager,
  );

  late final AuthCubit _authCubit;
  late final DeviceLocationCubit _deviceLocationCubit;

  final StreamController<bool> _canNavigateToHome =
      StreamController<bool>.broadcast();

  Stream<bool> get canNavigateToHome => _canNavigateToHome.stream;

  // User session and device location are the two dependencies
  final List<bool> _initialDependencies = [false, false];

  @override
  void onStart() {
    super.onStart();
    _authCubit = context.read<AuthCubit>()..stream.listen(handleAuthStates);
    _deviceLocationCubit = context.read<DeviceLocationCubit>()
      ..stream.listen(handleLocationStates);
    _canNavigateToHome.stream.listen((canNavigate) {
      if (canNavigate && context.mounted) {
        context.goNamed(AppRoutes.homeRoute.name);
      }
    });
    _deviceLocationCubit.getCurrentAddress();
    _authCubit.getUserSession();
  }

  void handleAuthStates(AuthState state) {
    if (state is UserSessionLoaded) {
      _initialDependencies[0] = true;
      _canNavigateToHome.add(_initialDependencies.every((element) => element));
    } else if (state is UserSessionError) {
      _initialDependencies[0] = true;
      _canNavigateToHome.add(_initialDependencies.every((element) => element));
    }
  }

  void handleLocationStates(DeviceLocationState state) {
    if (state is DeviceLocationLoaded) {
      _initialDependencies[1] = true;
      _canNavigateToHome.add(_initialDependencies.every((element) => element));
    } else if (state is DeviceLocationError) {
      _initialDependencies[1] = true;
      _canNavigateToHome.add(_initialDependencies.every((element) => element));
    }
  }
}
