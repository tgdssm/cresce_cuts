import 'package:vale_vantagens/core/errors/base_error.dart';
import 'package:vale_vantagens/core/result/result.dart';
import 'package:vale_vantagens/modules/products/domain/entities/product_entity.dart';
import 'package:vale_vantagens/modules/products/domain/repositories/products_repository.dart';
import 'package:vale_vantagens/modules/products/domain/usecases/get_products_usecase.dart';

class GetProductsUseCaseImpl implements GetProductsUseCase {
  final ProductsRepository repository;
  const GetProductsUseCaseImpl(this.repository);
  @override
  Future<Result<BaseError, List<ProductEntity>>> call() async {
    return repository.getProducts();
  }
}
