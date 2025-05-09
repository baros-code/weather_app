import 'package:flutter/material.dart';

import '../../../../../core/presentation/controller.dart';
import '../../../../shared/utils/build_context_ext.dart';

class SettingsPageController extends Controller<Object> {
  SettingsPageController(
    super.logger,
    super.popupManager,
  );

  @override
  void onStart() {
    // TODO: implement onStart
    super.onStart();
  }

  void changeLanguage(String languageCode) {
    context.localizationProvider.setLocale(Locale(languageCode));
    
  }
}
