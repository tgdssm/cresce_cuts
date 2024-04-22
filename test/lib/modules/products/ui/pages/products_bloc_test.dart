import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vale_vantagens/core/errors/base_error.dart';
import 'package:vale_vantagens/core/result/result.dart';
import 'package:vale_vantagens/core/state_management/states/error_state.dart';
import 'package:vale_vantagens/core/state_management/states/initial_state.dart';
import 'package:vale_vantagens/core/state_management/states/loading_state.dart';
import 'package:vale_vantagens/core/state_management/states/success_state.dart';
import 'package:vale_vantagens/modules/products/domain/entities/entities.dart';
import 'package:vale_vantagens/modules/products/domain/usecases/get_products_usecase.dart';
import 'package:vale_vantagens/modules/products/ui/pages/products_bloc.dart';

class GetProductsUseCaseMock extends Mock implements GetProductsUseCase {}

void main() {
  group('Products bloc test', () {
    late GetProductsUseCase useCase;

    setUp(() {
      useCase = GetProductsUseCaseMock();
    });

    test('success', () async {
      final bloc = ProductsBloc(useCase);

      when(() => useCase()).thenAnswer(
        (_) async => Result<BaseError, List<ProductEntity>>(
          success: [],
        ),
      );

      expectLater(
        bloc.stream,
        emitsInOrder(
          [
            isA<InitialState>(),
            isA<LoadingState>(),
            isA<SuccessState<List<ProductEntity>>>(),
          ],
        ),
      );
    });

    test('error', () async {
      final bloc = ProductsBloc(useCase);

      when(() => useCase()).thenAnswer(
        (_) async => Result<BaseError, List<ProductEntity>>(
          failure: BaseError('Error'),
        ),
      );

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
