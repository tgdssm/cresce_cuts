import '../../../../commons/entities/discount_entity.dart';
import '../../../../core/errors/base_error.dart';
import '../../../../core/result/result.dart';

abstract class RegisterDiscountUseCase {
  Future<Result<BaseError, void>> call(DiscountEntity discount);
}