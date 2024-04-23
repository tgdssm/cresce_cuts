import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vale_vantagens/commons/models/discount_model.dart';
import 'package:vale_vantagens/core/errors/base_error.dart';
import 'package:vale_vantagens/core/storage/storage.dart';
import 'package:vale_vantagens/modules/register_discount/data/datasources/impl/register_discount_datasource_impl.dart';
import 'package:vale_vantagens/modules/register_discount/data/datasources/register_discount_datasource.dart';

class StorageMock extends Mock implements Storage<DiscountModel> {}

final model = DiscountModel(
  id: '1',
  name: 'test',
  discountType: DiscountType.price,
  price: 9.99,
  description: 'test',
  activationDate: DateTime.now(),
);

void main() {
  late RegisterDiscountDatasource datasource;
  late Storage<DiscountModel> storage;

  setUpAll(() {
    storage = StorageMock();
    datasource = RegisterDiscountDatasourceImpl(storage);
    registerFallbackValue(model);
  });

  group('test register discount datasource', () {
    test('success', () async {
      when(() => storage.init()).thenAnswer((_) async => () {});
      when(() =>
              storage.put(key: any(named: 'key'), value: any(named: 'value')))
          .thenAnswer((_) async => () {});

      expect(
        () async {
          await datasource.register(model);
        },
        isA<void>(),
      );
    });

    test('storage error', () async {
      when(() => storage.init()).thenAnswer((_) async => () {});
      when(() =>
              storage.put(key: any(named: 'key'), value: any(named: 'value')))
          .thenThrow(HiveError('Error'));

      expect(
        () async {
          await datasource.register(model);
        },
        throwsA(isA<BaseError>()),
      );
    });
  });
}
