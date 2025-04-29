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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.localizations.welcome_weather_app,
              style: context.textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
