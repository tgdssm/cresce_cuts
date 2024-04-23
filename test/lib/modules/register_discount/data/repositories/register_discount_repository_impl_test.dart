import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vale_vantagens/core/errors/base_error.dart';
import 'package:vale_vantagens/commons/models/models.dart';
import 'package:vale_vantagens/modules/register_discount/data/datasources/register_discount_datasource.dart';
import 'package:vale_vantagens/modules/register_discount/data/repositories/register_discount_repository_impl.dart';
import 'package:vale_vantagens/modules/register_discount/domain/repositories/register_discount_repository.dart';

final model = DiscountModel(
  id: '1',
  name: 'test',
  discountType: DiscountType.price,
  price: 9.99,
  description: 'test',
  activationDate: DateTime.now(),
);

class RegisterDiscountDatasourceMock extends Mock
    implements RegisterDiscountDatasource {}

void main() {
  late RegisterDiscountRepository repository;
  late RegisterDiscountDatasourceMock datasource;

  setUpAll(() {
    datasource = RegisterDiscountDatasourceMock();
    repository = RegisterDiscountRepositoryImpl(datasource);
    registerFallbackValue(model);
  });

  group('test register discount repository', () {
    test('should return success when registration is successful', () async {
      when(() => datasource.register(any())).thenAnswer((_) async {});

      final result = await repository.register(model.toEntity());

      expect(result.failure, isNull);
    });

    test('should return failure when datasource throws a BaseError', () async {
      final baseError = BaseError("Error registering discount");
      when(() => datasource.register(any())).thenThrow(baseError);

      final result = await repository.register(model.toEntity());

      expect(result.failure, baseError);
    });
  });
}
