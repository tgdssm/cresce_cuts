import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vale_vantagens/core/errors/base_error.dart';
import 'package:vale_vantagens/modules/products/data/datasources/products_datasource.dart';
import 'package:vale_vantagens/commons/models/models.dart';
import 'package:vale_vantagens/modules/products/data/repositories/products_repository_impl.dart';
import 'package:vale_vantagens/commons/entities/entities.dart';
import 'package:vale_vantagens/modules/products/domain/repositories/products_repository.dart';

final productList = [
  ProductModel(
    id: 1,
    title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
    price: 109.95,
    description:
        "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
    category: "men's clothing",
    image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
    rating: RatingModel(rate: 3.9, count: 120),
  ),
];

class ProductsDatasourceMock extends Mock implements ProductsDatasource {}

void main() {
  late final ProductsDatasource datasource;
  late final ProductsRepository repository;

  setUpAll(() {
    datasource = ProductsDatasourceMock();
    repository = ProductsRepositoryImpl(datasource);
  });

  group('test get products', () {
    test('success', () async {
      when(() => datasource.getProducts()).thenAnswer(
        (_) async => productList,
      );

      final result = await repository.getProducts();
      expect(result.success, isA<List<ProductEntity>>());
      expect(result.failure, isNull);
      expect(result.success!.length, equals(1));
    });

    test('failure', () async {
      when(() => datasource.getProducts()).thenThrow(
        BaseError('Error', 500),
      );

      final result = await repository.getProducts();
      expect(result.success, isNull);
      expect(result.failure!.message, 'Error');
      expect(result.failure!.code, 500);
    });
  });
}
