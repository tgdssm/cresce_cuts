import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vale_vantagens/core/errors/base_error.dart';
import 'package:vale_vantagens/core/result/result.dart';
import 'package:vale_vantagens/commons/entities/entities.dart';
import 'package:vale_vantagens/modules/discounts/domain/repositories/discounts_repository.dart';
import 'package:vale_vantagens/modules/discounts/domain/usecases/get_discounts_usecase.dart';
import 'package:vale_vantagens/modules/discounts/domain/usecases/impl/get_discounts_usecase_impl.dart';

class DiscountsRepositoryMock extends Mock implements DiscountsRepository {}

void main() {
  late final DiscountsRepository repository;
  late final GetDiscountsUseCase useCase;

  setUpAll(() {
    repository = DiscountsRepositoryMock();
    useCase = GetDiscountsUseCaseImpl(repository);
  });

  group('test get discounts use case', () {
    test('success', () async {
      when(() => repository.getDiscounts()).thenAnswer(
        (_) async => Result<BaseError, List<DiscountEntity>>(
          success: [],
        ),
      );

      final result = await useCase();
      expect(result.success, isA<List<DiscountEntity>>());
      expect(result.failure, isNull);
    });

    test('error', () async {
      when(() => repository.getDiscounts()).thenAnswer(
        (_) async => Result<BaseError, List<DiscountEntity>>(
          failure: BaseError('message'),
        ),
      );

      final result = await useCase();
      expect(result.success, isNull);
      expect(result.failure, isA<BaseError>());
    });
  });
}
