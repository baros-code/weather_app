import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../app/shared/presentation/widgets/toast_card.dart';

abstract class PopupManager {
  void showToastMessage(
    BuildContext context,
    String text, {
    Duration duration = const Duration(milliseconds: 3200),
  });

  Future<void> showFullScreenPopup(BuildContext context, Widget content);
}

class PopupManagerImpl implements PopupManager {
  @override
  void showToastMessage(
    BuildContext context,
    String text, {
    Duration duration = const Duration(milliseconds: 3200),
  }) {
    FToast()
      ..init(context)
      ..removeQueuedCustomToasts()
      ..showToast(
        toastDuration: duration,
        gravity: ToastGravity.CENTER,
        child: ToastCard(text),
      );
  }

  @override
  Future<void> showFullScreenPopup(BuildContext context, Widget content) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(
        context,
      ).modalBarrierDismissLabel,
      barrierColor: Colors.black26,
      transitionBuilder: (_, anim1, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(anim1),
          child: child,
        );
      },
      pageBuilder: (_, __, ___) {
        return SafeArea(
          left: false,
          top: false,
          right: false,
          bottom: false,
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.zero,
              child: content,
            ),
          ),
        );
      },
    );
  }
}
