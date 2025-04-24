// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

import '../../app/utils/service_locator.dart';
import 'controller.dart';

abstract class ControlledView<TController extends Controller<TParams>,
    TParams extends Object> extends StatefulWidget {
  ControlledView({
    super.key,
    required this.params,
  }) : controller = locator<TController>();

  /// Optional parameters that can be passed during navigation.
  final TParams? params;

  /// Controller of this page. It is to be used as a presentation logic holder.
  late final TController controller;

  /// Describes the widget to be constructed.
  @protected
  Widget build(BuildContext context);

  /// Called when the page is activated on start or resume.
  @protected
  @mustCallSuper
  void onActivate() {}

  /// Called once when the page is initialized.
  @protected
  @mustCallSuper
  void onStart() {}

  /// Called after build is finished.
  @protected
  @mustCallSuper
  void onPostBuild() {}

  /// Called when the page is visible back from pause.
  @protected
  @mustCallSuper
  void onResume() {}

  /// Called when the page goes invisible and running in the background.
  @protected
  @mustCallSuper
  void onPause() {}

  /// Called when the page is disposed. The difference between onStop and
  /// onClose is that onClose is called when the app is detached but
  /// onStop means the page is popped from the navigation stack.
  @protected
  @mustCallSuper
  void onStop() {}

  /// Called when the app is detached which usually happens when
  /// back button is pressed.
  @protected
  @mustCallSuper
  void onClose() {}

  /// Called when the page is deactivated on pause or close.
  @protected
  @mustCallSuper
  void onDeactivate() {}

  /// Called when back button is pressed.
  @protected
  @mustCallSuper
  Future<bool> onBackRequest() => Future.value(true);

  @override
  // ignore: library_private_types_in_public_api
  _ControlledViewState<TController> createState() {
    // Create the page state with all the callbacks.
    // ignore: no_logic_in_create_state
    return _ControlledViewState(
      controller,
      buildView: (context) {
        return TController == Controller
            ? build(context)
            // ignore: deprecated_member_use
            : WillPopScope(
                onWillPop: () async {
                  if (!controller.isActive) return Future.value(false);
                  return await onBackRequest() ==
                      await controller.onBackRequest();
                },
                child: build(context),
              );
      },
      onActivate: onActivate,
      onInitState: onStart,
      onPostBuild: onPostBuild,
      onResume: onResume,
      onPause: onPause,
      onDispose: onStop,
      onDetach: onClose,
      onDeactivate: onDeactivate,
    );
  }
}

// Page state that handles all the lifecycle events.
class _ControlledViewState<TController extends Controller>
    extends State<ControlledView>
    with
        WidgetsBindingObserver,
        TickerProviderStateMixin,
        AutomaticKeepAliveClientMixin {
  _ControlledViewState(
    this._controller, {
    required this.buildView,
    required this.onActivate,
    required this.onInitState,
    required this.onPostBuild,
    required this.onResume,
    required this.onPause,
    required this.onDispose,
    required this.onDetach,
    required this.onDeactivate,
  });

  final Controller _controller;
  final Widget Function(BuildContext context) buildView;
  final void Function() onActivate;
  final void Function() onInitState;
  final void Function() onPostBuild;
  final void Function() onResume;
  final void Function() onPause;
  final void Function() onDispose;
  final void Function() onDetach;
  final void Function() onDeactivate;

  @override
  bool get wantKeepAlive => _controller.keepViewAlive;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildView(context);
  }

  @override
  void initState() {
    super.initState();
    // Share BuildContext with the controller.
    _controller.context = context;
    // Pass optional params to the controller.
    _controller.params = widget.params;
    // Set ticker provider for the controller.
    _controller.vsync = this;
    onActivate();
    _controller.onActivate();
    onInitState();
    _controller.onStart();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPostBuild();
      _controller.onReady();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        onDeactivate();
        _controller.onDeactivate();
        break;
      case AppLifecycleState.resumed:
        onActivate();
        _controller.onActivate();
        onResume();
        _controller.onResume();
        break;
      case AppLifecycleState.paused:
        onPause();
        _controller.onPause();
        break;
      case AppLifecycleState.detached:
        onDetach();
        _controller.onClose();
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.onStop();
    onDispose();
    super.dispose();
  }
}
