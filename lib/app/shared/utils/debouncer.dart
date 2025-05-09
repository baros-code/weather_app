import 'dart:async';

class Debouncer {
  Debouncer(this.duration);

  final Duration duration;
  Timer? _timer;

  void run(void Function() action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(duration, action);
  }

  void cancel() {
    _timer?.cancel();
  }
}
