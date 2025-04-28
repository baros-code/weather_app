import 'package:flutter/material.dart';

import '../../../../../core/presentation/controlled_view.dart';
import '../../../../shared/utils/build_context_ext.dart';
import '../controllers/splash_controller.dart';

class SplashPage extends ControlledView<SplashController, Object> {
  SplashPage({
    super.key,
    super.params,
  });

  @override
  Widget build(BuildContext context) {
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
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
