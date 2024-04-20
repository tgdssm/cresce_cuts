import '../../../../core/errors/base_error.dart';
import '../../../../core/result/result.dart';
import '../entities/product_entity.dart';

abstract class GetProductsUseCase {
  Future<Result<BaseError, List<ProductEntity>>> call();
}