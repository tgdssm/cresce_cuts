import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vale_vantagens/core/errors/base_error.dart';
import 'package:vale_vantagens/core/result/result.dart';
import 'package:vale_vantagens/modules/products/domain/entities/entities.dart';
import 'package:vale_vantagens/modules/products/domain/repositories/products_repository.dart';
import 'package:vale_vantagens/modules/products/domain/usecases/get_products_usecase.dart';
import 'package:vale_vantagens/modules/products/domain/usecases/impl/get_products_usecase_impl.dart';

final productList = [
  const ProductEntity(
    id: 1,
    title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
    price: 109.95,
    description:
        "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
    category: "men's clothing",
    image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
    rating: RatingEntity(rate: 3.9, count: 120),
  ),
];

class ProductsRepositoryMock extends Mock implements ProductsRepository {}

void main() {
  late final ProductsRepository repository;
  late final GetProductsUseCase useCase;

  setUpAll(() {
    repository = ProductsRepositoryMock();
    useCase = GetProductsUseCaseImpl(repository);
  });

  group('test get products', () {
    test('success', () async {
      when(() => repository.getProducts()).thenAnswer(
        (_) async => Result<BaseError, List<ProductEntity>>(
          success: productList,
        ),
      );

      final result = await useCase();
      expect(result.success, isA<List<ProductEntity>>());
      expect(result.failure, isNull);
      expect(result.success!.length, equals(1));
    });

    test('failure', () async {
      when(() => repository.getProducts()).thenAnswer(
        (_) async => Result<BaseError, List<ProductEntity>>(
          failure: BaseError('Error', 500),
        ),
      );

      final result = await useCase();
      expect(result.success, isNull);
      expect(result.failure!.message, 'Error');
      expect(result.failure!.code, 500);
    });
  });
}
