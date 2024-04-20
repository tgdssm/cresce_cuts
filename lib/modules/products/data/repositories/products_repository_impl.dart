import 'package:vale_vantagens/core/errors/base_error.dart';
import 'package:vale_vantagens/core/result/result.dart';
import 'package:vale_vantagens/modules/products/data/datasources/products_datasource.dart';
import 'package:vale_vantagens/modules/products/domain/entities/product_entity.dart';
import 'package:vale_vantagens/modules/products/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsDatasource datasource;
  const ProductsRepositoryImpl(this.datasource);
  @override
  Future<Result<BaseError, List<ProductEntity>>> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }
}
