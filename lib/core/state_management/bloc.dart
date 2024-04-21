import 'dart:async';

abstract class Bloc<T> {
  final StreamController<T> _outputState;
  Stream<T> get state => _outputState.stream;

  Bloc(T initialState) : _outputState = StreamController<T>() {
    emit(initialState);
    onInit();
  }

  void onInit() {}

  void emit(T event) {
    if (!_outputState.isClosed) {
      _outputState.sink.add(event);
    }
  }

  void dispose() {
    _outputState.close();
  }
}
