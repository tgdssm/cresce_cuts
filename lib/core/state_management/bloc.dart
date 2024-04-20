import 'dart:async';

abstract class Bloc<T> {
  final _outputState = StreamController<T>();
  Stream<T> get state => _outputState.stream;

  void emit(T event) {
    _outputState.sink.add(event);
  }

  void dispose() {
    _outputState.close();
  }
}
