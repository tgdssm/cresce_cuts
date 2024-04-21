import 'package:vale_vantagens/core/state_management/states/base_state.dart';

class ErrorState implements BaseState {
  final String? message;
  final int? code;

  const ErrorState(this.message, [this.code]);
}