import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vale_vantagens/commons/entities/discount_entity.dart';
import 'package:vale_vantagens/core/errors/base_error.dart';
import 'package:vale_vantagens/commons/models/models.dart';
import 'package:vale_vantagens/modules/discounts/data/datasources/discounts_datasource.dart';
import 'package:vale_vantagens/modules/discounts/data/repositories/discounts_repository_impl.dart';
import 'package:vale_vantagens/modules/discounts/domain/repositories/discounts_repository.dart';

class DiscountsDatasourceMock extends Mock implements DiscountsDatasource {}

void main() {
  late DiscountsRepository repository;
  late DiscountsDatasource datasource;

  setUpAll(() {
    datasource = DiscountsDatasourceMock();
    repository = DiscountsRepositoryImpl(datasource);
  });

  group('test discounts repository', () {
    test('success', () async {
      when(() => datasource.getDiscounts()).thenAnswer(
        (_) async => <DiscountModel>[],
      );

      final result = await repository.getDiscounts();

      expect(result.success, isA<List<DiscountEntity>>());
      expect(result.failure, isNull);
    });

    test('error', () async {
      when(() => datasource.getDiscounts()).thenThrow(
        BaseError('Error'),
      );

      final result = await repository.getDiscounts();

      expect(result.success, isNull);
      expect(result.failure, isA<BaseError>());
    });
  });
}
