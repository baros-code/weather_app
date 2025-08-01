import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_scroll_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../core/presentation/controlled_view.dart';
import '../../../../shared/presentation/widgets/base_page.dart';
import '../../../../shared/utils/build_context_ext.dart';
import '../../../../shared/utils/theme_provider.dart';
import '../controllers/settings_page_controller.dart';

class SettingsPage extends ControlledView<SettingsPageController, Object> {
  SettingsPage({
    super.key,
    super.params,
  });

  @override
  Widget build(BuildContext context) {
    return BasePage(
      backButtonEnabled: true,
      title: Text(context.localizations.settings),
      body: _Body(controller),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body(this.controller);

  final SettingsPageController controller;

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        Provider.of<ThemeProvider>(context, listen: true).isDarkMode;
    return Column(
      children: [
        _ThemeModeToggle(isDarkMode: isDarkMode),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => _showLanguagePicker(context),
          child: Text(context.localizations.change_language),
        ),
      ],
    );
  }

  void _showLanguagePicker(BuildContext context) {
    showMaterialScrollPicker<String>(
      context: context,
      title: context.localizations.choose_language,
      items: ['English', 'Spanish'],
      selectedItem: 'English',
      onChanged: (value) {
        if (value == 'English') {
          controller.changeLanguage('en');
        }
        if (value == 'Spanish') {
          controller.changeLanguage('es');
        }
      },
    );
  }
}

class _ThemeModeToggle extends StatelessWidget {
  const _ThemeModeToggle({
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: [!isDarkMode, isDarkMode],
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.light_mode),
              Text(context.localizations.light_mode),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.dark_mode),
              Text(context.localizations.dark_mode),
            ],
          ),
        ),
      ],
      onPressed: (index) {
        if (index == 0) {
          Provider.of<ThemeProvider>(context, listen: false)
              .setThemeMode(ThemeMode.light);
        } else {
          Provider.of<ThemeProvider>(context, listen: false)
              .setThemeMode(ThemeMode.dark);
        }
      },
    );
  }
}
