import 'package:flutter_modular/flutter_modular.dart';
import 'package:vale_vantagens/commons/models/discount_model.dart';
import 'package:vale_vantagens/core/storage/storage.dart';
import 'package:vale_vantagens/modules/register_discount/data/datasources/impl/register_discount_datasource_impl.dart';
import 'package:vale_vantagens/modules/register_discount/data/datasources/register_discount_datasource.dart';
import 'package:vale_vantagens/modules/register_discount/data/repositories/register_discount_repository_impl.dart';
import 'package:vale_vantagens/modules/register_discount/domain/repositories/register_discount_repository.dart';
import 'package:vale_vantagens/modules/register_discount/domain/usecases/impl/register_discount_usecase_impl.dart';
import 'package:vale_vantagens/modules/register_discount/domain/usecases/register_discount_usecase.dart';

import '../../core/navigation/base_path.dart';

class RegisterDiscountModule extends Module {
  static const root = BasePath('/register-discount');

  @override
  void binds(Injector i) {
    i.add<RegisterDiscountDatasource>(
      () => RegisterDiscountDatasourceImpl(
        i.get<Storage<DiscountModel>>(),
      ),
    );
    i.add<RegisterDiscountRepository>(
      () => RegisterDiscountRepositoryImpl(
        i.get<RegisterDiscountDatasource>(),
      ),
    );
    i.add<RegisterDiscountUseCase>(
      () => RegisterDiscountUseCaseImpl(
        i.get<RegisterDiscountRepository>(),
      ),
    );
    super.binds(i);
  }
}
