import 'package:flutter_test/flutter_test.dart';
import 'package:vale_vantagens/core/state_management/bloc.dart';
import 'package:vale_vantagens/core/state_management/states/base_state.dart';
import 'package:vale_vantagens/core/state_management/states/error_state.dart';
import 'package:vale_vantagens/core/state_management/states/initial_state.dart';
import 'package:vale_vantagens/core/state_management/states/loading_state.dart';

class BlocMock extends Bloc<BaseState> {
  BlocMock() : super(InitialState());
}

void main() {
  group('Bloc Tests', () {
    late Bloc<BaseState> bloc;

    setUp(() {
      bloc = BlocMock();
    });

    tearDown(() {
      bloc.dispose();
    });

    test('Bloc emits a new state', () async {
      bloc.emit(LoadingState());
      bloc.emit(const ErrorState('Error'));

      expectLater(
        bloc.stream,
        emitsInOrder(
          [
            isA<InitialState>(),
            isA<LoadingState>(),
            isA<ErrorState>(),
          ],
        ),
      );
    });
  });
}
