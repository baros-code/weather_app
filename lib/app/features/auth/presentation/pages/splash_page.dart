import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/controlled_view.dart';
import '../../../../shared/presentation/cubit/cubit/device_location_cubit.dart';
import '../../../../shared/utils/build_context_ext.dart';
import '../controllers/splash_controller.dart';

class SplashPage extends ControlledView<SplashController, Object> {
  SplashPage({
    super.key,
    super.params,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeviceLocationCubit, DeviceLocationState>(
      listener: (context, state) => controller.handleLocationStates(state),
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.colorScheme.primaryContainer,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to Weather App',
                  style: context.textTheme.headlineSmall,
                ),
                if (state is DeviceLocationLoading) CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }
}
