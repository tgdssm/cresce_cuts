import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vale_vantagens/commons/models/discount_model.dart';
import 'package:vale_vantagens/core/errors/base_error.dart';
import 'package:vale_vantagens/core/storage/storage.dart';
import 'package:vale_vantagens/modules/discounts/data/datasources/discounts_datasource.dart';
import 'package:vale_vantagens/modules/discounts/data/datasources/impl/discounts_datasouce_impl.dart';

class StorageMock extends Mock implements Storage<String> {}

void main() {
  late DiscountsDatasource datasource;
  late Storage<String> storage;

  setUpAll(() {
    storage = StorageMock();
    datasource = DiscountsDatasourceImpl(storage);
  });

  group('test discounts datasource', () {
    test('success', () async {
      when(() => storage.init()).thenAnswer((_) async => () {});
      when(() => storage.getAll()).thenAnswer((_) async => <String>[]);
      when(() => storage.close()).thenAnswer((_) async => () {});

      final result = await datasource.getDiscounts();

      expect(
        result,
        isA<List<DiscountModel>>(),
      );
    });

    test('error', () async {
      when(() => storage.init()).thenAnswer((_) async => () {});
      when(() => storage.getAll()).thenThrow(HiveError('Error'));

      final result = datasource.getDiscounts();

      expect(
        result,
        throwsA(isA<BaseError>()),
      );
    });
  });
}
