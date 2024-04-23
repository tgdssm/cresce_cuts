import 'package:vale_vantagens/commons/entities/discount_entity.dart';
import 'package:vale_vantagens/core/errors/base_error.dart';
import 'package:vale_vantagens/core/result/result.dart';
import 'package:vale_vantagens/modules/register_discount/data/datasources/register_discount_datasource.dart';
import 'package:vale_vantagens/modules/register_discount/domain/repositories/register_discount_repository.dart';

class RegisterDiscountRepositoryImpl implements RegisterDiscountRepository {
  final RegisterDiscountDatasource datasource;
  const RegisterDiscountRepositoryImpl(this.datasource);
  @override
  Future<Result<BaseError, void>> register(DiscountEntity discount) async {
    try {
      await datasource.register(discount.toModel());
      return Result(success: null);
    } on BaseError catch (e) {
      return Result(failure: e);
    }
  }
}
