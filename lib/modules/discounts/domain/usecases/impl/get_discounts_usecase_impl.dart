import 'package:vale_vantagens/commons/entities/discount_entity.dart';
import 'package:vale_vantagens/core/errors/base_error.dart';
import 'package:vale_vantagens/core/result/result.dart';
import 'package:vale_vantagens/modules/discounts/domain/repositories/discounts_repository.dart';
import 'package:vale_vantagens/modules/discounts/domain/usecases/get_discounts_usecase.dart';

class GetDiscountsUseCaseImpl implements GetDiscountsUseCase {
  final DiscountsRepository repository;
  const GetDiscountsUseCaseImpl(this.repository);

  @override
  Future<Result<BaseError, List<DiscountEntity>>> call() async {
    return repository.getDiscounts();
  }
}
