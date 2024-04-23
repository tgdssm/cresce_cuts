import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vale_vantagens/commons/models/discount_model.dart';
import 'package:vale_vantagens/core/errors/base_error.dart';
import 'package:vale_vantagens/core/result/result.dart';
import 'package:vale_vantagens/commons/entities/entities.dart';
import 'package:vale_vantagens/modules/register_discount/domain/repositories/register_discount_repository.dart';
import 'package:vale_vantagens/modules/register_discount/domain/usecases/impl/register_discount_usecase_impl.dart';
import 'package:vale_vantagens/modules/register_discount/domain/usecases/register_discount_usecase.dart';

final entity = DiscountEntity(
  id: 1,
  name: 'test',
  discountType: DiscountType.price,
  price: 9.99,
  description: 'test',
  activationDate: DateTime.now(),
);

class RegisterDiscountRepositoryMock extends Mock
    implements RegisterDiscountRepository {}

void main() {
  late final RegisterDiscountRepository repository;
  late final RegisterDiscountUseCase useCase;

  setUpAll(() {
    repository = RegisterDiscountRepositoryMock();
    useCase = RegisterDiscountUseCaseImpl(repository);
  });

  group('test register discount use case', () {
    test('success', () async {
      when(() => repository.register(entity)).thenAnswer(
        (_) async => Result<BaseError, void>(
          success: null,
        ),
      );

      final result = await useCase(entity);
      expect(result.failure, isNull);
    });

    test('error', () async {
      when(() => repository.register(entity)).thenAnswer(
        (_) async => Result<BaseError, void>(
          failure: BaseError('Error'),
        ),
      );

      final result = await useCase(entity);
      expect(result.failure!.message, 'Error');
    });
  });
}
