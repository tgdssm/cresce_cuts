import 'package:vale_vantagens/modules/register_discount/domain/repositories/register_discount_repository.dart';
import 'package:vale_vantagens/modules/register_discount/domain/usecases/register_discount_usecase.dart';

import '../../../../../commons/entities/discount_entity.dart';
import '../../../../../core/errors/base_error.dart';
import '../../../../../core/result/result.dart';

class RegisterDiscountUseCaseImpl implements RegisterDiscountUseCase {
  final RegisterDiscountRepository repository;
  const RegisterDiscountUseCaseImpl(this.repository);

  @override
  Future<Result<BaseError, bool>> call(DiscountEntity discount) async {
    return repository.register(discount);
  }
}
