import 'package:vale_vantagens/commons/entities/entities.dart';

import '../../../../core/errors/base_error.dart';
import '../../../../core/result/result.dart';

abstract class GetProductsUseCase {
  Future<Result<BaseError, List<ProductEntity>>> call();
}