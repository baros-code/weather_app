import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/controlled_view.dart';
import '../../utils/build_context_ext.dart';
import '../controllers/home_controller.dart';
import '../cubit/cubit/weather_cubit.dart';

class HomePage extends ControlledView<HomeController, Object> {
  HomePage({
    super.key,
    super.params,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.colorScheme.primaryContainer,
          appBar: AppBar(
            title: Text(
              context.localizations.helloWorld,
              style: context.textTheme.headlineSmall,
            ),
            backgroundColor: context.colorScheme.primaryContainer,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Current Weather',
                  style: context.textTheme.titleLarge,
                ),
                ElevatedButton(
                  onPressed: context.themeProvider.toggleThemeMode,
                  child: Text('Toggle theme'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      context.localizationProvider.setLocale(Locale('es')),
                  child: Text('Change language'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
