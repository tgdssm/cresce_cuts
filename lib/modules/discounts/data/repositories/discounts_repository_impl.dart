import 'package:vale_vantagens/commons/entities/discount_entity.dart';
import 'package:vale_vantagens/core/errors/base_error.dart';
import 'package:vale_vantagens/core/result/result.dart';
import 'package:vale_vantagens/modules/discounts/data/datasources/discounts_datasource.dart';
import 'package:vale_vantagens/modules/discounts/domain/repositories/discounts_repository.dart';

class DiscountsRepositoryImpl implements DiscountsRepository {
  final DiscountsDatasource datasource;
  const DiscountsRepositoryImpl(this.datasource);

  @override
  Future<Result<BaseError, List<DiscountEntity>>> getDiscounts() async {
    try {
      final result = await datasource.getDiscounts();
      return Result(success: result.map((e) => e.toEntity()).toList());
    } on BaseError catch (e) {
      return Result(failure: e);
    }
  }
}
