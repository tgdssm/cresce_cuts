import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vale_vantagens/commons/models/discount_model.dart';
import 'package:vale_vantagens/core/errors/base_error.dart';
import 'package:vale_vantagens/core/result/result.dart';
import 'package:vale_vantagens/core/state_management/states/error_state.dart';
import 'package:vale_vantagens/core/state_management/states/initial_state.dart';
import 'package:vale_vantagens/core/state_management/states/loading_state.dart';
import 'package:vale_vantagens/core/state_management/states/success_state.dart';
import 'package:vale_vantagens/commons/entities/entities.dart';
import 'package:vale_vantagens/modules/register_discount/domain/usecases/register_discount_usecase.dart';
import 'package:vale_vantagens/modules/register_discount/ui/pages/register_discount_bloc.dart';

class RegisterDiscountUseCaseMock extends Mock
    implements RegisterDiscountUseCase {}

final entity = DiscountEntity(
  id: '1',
  name: 'test',
  description: 'test',
  discountType: DiscountType.price,
  image: 'test',
  price: 0.0,
  activationDate: DateTime.now(),
  inactivationDate: DateTime.now(),
);

void main() {
  group('Register discount bloc test', () {
    late RegisterDiscountUseCase useCase;

    setUp(() {
      useCase = RegisterDiscountUseCaseMock();
      registerFallbackValue(entity);
    });

    test('success', () async {
      final bloc = RegisterDiscountBloc(useCase);

      when(() => useCase(any())).thenAnswer(
        (_) async => Result<BaseError, bool>(
          success: true,
        ),
      );

      await bloc.register(entity, () {});

      expectLater(
        bloc.stream,
        emitsInOrder(
          [
            isA<InitialState>(),
            isA<LoadingState>(),
            isA<SuccessState<bool>>(),
          ],
        ),
      );
    });

    test('error', () async {
      final bloc = RegisterDiscountBloc(useCase);

      when(() => useCase(any())).thenAnswer(
        (_) async => Result<BaseError, bool>(
          failure: BaseError('Error'),
        ),
      );

      await bloc.register(entity, () {});

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
