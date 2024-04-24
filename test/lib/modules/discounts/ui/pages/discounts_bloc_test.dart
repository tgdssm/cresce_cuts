import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vale_vantagens/core/errors/base_error.dart';
import 'package:vale_vantagens/core/result/result.dart';
import 'package:vale_vantagens/core/state_management/states/error_state.dart';
import 'package:vale_vantagens/core/state_management/states/initial_state.dart';
import 'package:vale_vantagens/core/state_management/states/loading_state.dart';
import 'package:vale_vantagens/core/state_management/states/success_state.dart';
import 'package:vale_vantagens/commons/entities/entities.dart';
import 'package:vale_vantagens/modules/discounts/domain/usecases/get_discounts_usecase.dart';
import 'package:vale_vantagens/modules/discounts/ui/pages/discounts_bloc.dart';

class GetDiscountsUseCaseMock extends Mock implements GetDiscountsUseCase {}

void main() {
  group('discounts bloc test', () {
    late GetDiscountsUseCase useCase;

    setUp(() {
      useCase = GetDiscountsUseCaseMock();
    });

    test('success', () async {
      when(() => useCase()).thenAnswer(
        (_) async => Result<BaseError, List<DiscountEntity>>(
          success: [],
        ),
      );

      final bloc = DiscountsBloc(useCase);

      expectLater(
        bloc.stream,
        emitsInOrder(
          [
            isA<InitialState>(),
            isA<LoadingState>(),
            isA<SuccessState<List<DiscountEntity>>>(),
          ],
        ),
      );
    });

    test('error', () async {
      when(() => useCase()).thenAnswer(
        (_) async => Result<BaseError, List<DiscountEntity>>(
          failure: BaseError(''),
        ),
      );
      final bloc = DiscountsBloc(useCase);

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
