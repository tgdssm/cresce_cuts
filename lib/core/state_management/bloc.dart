import 'dart:async';

abstract class Bloc<T> {
  final StreamController<T> _outputState;
  late T _state;
  Stream<T> get stream => _outputState.stream;
  T get state => _state;

  Bloc(T initialState) : _outputState = StreamController<T>() {
    emit(initialState);
    _state = initialState;
    onInit();
  }

  void onInit() {}

  void emit(T event) {
    if (!_outputState.isClosed) {
      _outputState.sink.add(event);
      _state = event;
    }
  }

  void dispose() {
    _outputState.close();
  }
}
