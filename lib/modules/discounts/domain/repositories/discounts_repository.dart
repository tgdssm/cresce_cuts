import 'package:vale_vantagens/commons/entities/discount_entity.dart';
import 'package:vale_vantagens/core/errors/base_error.dart';

import '../../../../core/result/result.dart';

abstract class DiscountsRepository {
  Future<Result<BaseError, List<DiscountEntity>>> getDiscounts();
}
