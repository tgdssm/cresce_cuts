import 'package:vale_vantagens/core/errors/base_error.dart';
import 'package:vale_vantagens/commons/entities/entities.dart';

import '../../../../core/result/result.dart';

abstract class ProductsRepository {
  Future<Result<BaseError, List<ProductEntity>>> getProducts();
}