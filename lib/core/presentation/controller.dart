import 'package:flutter/material.dart';

import '../utils/logger.dart';
import '../utils/popup_manager.dart';

abstract class Controller<TParams extends Object> {
  Controller(
    this.logger,
    this.popupManager,
  );

  /// Logger instance to be used in lifecycle events.
  @protected
  final Logger logger;

  /// PopupManager instance to be used for showing/hiding popups.
  @protected
  final PopupManager popupManager;

  /// The corresponding page's BuildContext.
  @protected
  late BuildContext context;

  /// Optional parameters that can be passed during navigation.
  @protected
  late TParams? params;

  /// An interface that is implemented by the corresponding page's state
  /// to be used by controllers such as AnimationController, TabController etc.
  @protected
  late TickerProvider vsync;

  /// Indicates if the corresponding page is active on screen.
  @protected
  bool get isActive => _isActive;

  /// Indicates if the corresponding page is built and active.
  @protected
  bool get isReady => _isReady && _isActive;

  /// Whether the corresponding page should be alive and keep its state.
  @protected
  bool get keepViewAlive => false;

  /// Called when the corresponding page is activated on start or resume.
  @protected
  @mustCallSuper
  void onActivate() {
    _isActive = true;
  }

  /// Called once when the corresponding page is initialized.
  @protected
  @mustCallSuper
  void onStart() {
    logger.info(
      '${_getHashCodeString()} - onStart',
      callerType: runtimeType,
    );
    _isActive = true;
  }

  /// Called after the corresponding page's build is finished.
  @protected
  @mustCallSuper
  void onReady() {
    _isReady = true;
  }

  /// Called when the corresponding page is visible back from pause.
  @protected
  @mustCallSuper
  void onResume() {
    logger.info(
      '${_getHashCodeString()} - onResume',
      callerType: runtimeType,
    );
    _isActive = true;
  }

  /// Called when the corresponding page goes invisible
  /// and running in the background.
  @protected
  @mustCallSuper
  void onPause() {
    logger.info(
      '${_getHashCodeString()} - onPause',
      callerType: runtimeType,
    );
    _isActive = false;
  }

  /// Called when the corresponding page is disposed. The difference between
  /// onStop and onClose is that onClose is called when the app is detached but
  /// onStop means the corresponding page is popped from the navigation stack.
  @protected
  @mustCallSuper
  void onStop() {
    logger.info(
      '${_getHashCodeString()} - onStop',
      callerType: runtimeType,
    );
    _isActive = false;
  }

  /// Called when the app is detached which usually happens when
  /// back button is pressed.
  @protected
  @mustCallSuper
  void onClose() {
    logger.info(
      '${_getHashCodeString()} - onClose',
      callerType: runtimeType,
    );
    _isReady = false;
  }

  /// Called when the corresponding page is deactivated on pause or close.
  @protected
  @mustCallSuper
  void onDeactivate() {
    _isActive = false;
  }

  /// Called when back button is pressed.
  @protected
  @mustCallSuper
  Future<bool> onBackRequest() {
    logger.info(
      '${_getHashCodeString()} - onBackRequest',
      callerType: runtimeType,
    );
    return Future.value(true);
  }

  // Helpers
  String _getHashCodeString() {
    return '0x${hashCode.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }
  // - Helpers

  // Fields
  bool _isActive = false;
  bool _isReady = false;
  // - Fields
}
