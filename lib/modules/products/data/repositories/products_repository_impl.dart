import 'package:vale_vantagens/core/errors/base_error.dart';
import 'package:vale_vantagens/core/result/result.dart';
import 'package:vale_vantagens/modules/products/data/datasources/products_datasource.dart';
import 'package:vale_vantagens/modules/products/domain/entities/product_entity.dart';
import 'package:vale_vantagens/modules/products/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsDatasource datasource;
  const ProductsRepositoryImpl(this.datasource);
  @override
  Future<Result<BaseError, List<ProductEntity>>> getProducts() async {
    try {
      final result = await datasource.getProducts();
      return Result(
        success: result.map((model) => model.toEntity()).toList(),
      );
    } on BaseError catch (e) {
      return Result(failure: e);
    }
  }
}
