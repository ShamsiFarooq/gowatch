import 'dart:async';

class Debouncer {
  final Duration delay;
  Timer? _timer;
  Debouncer(this.delay);

  void run(void Function() fn) {
    _timer?.cancel();
    _timer = Timer(delay, fn);
  }

  void dispose() => _timer?.cancel();
}
