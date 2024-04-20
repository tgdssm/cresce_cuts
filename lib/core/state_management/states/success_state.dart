import 'package:vale_vantagens/core/state_management/states/base_state.dart';

class SuccessState<T> implements BaseState {
  final T data;

  const SuccessState(this.data);
}
