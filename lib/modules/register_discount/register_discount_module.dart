import 'package:flutter_modular/flutter_modular.dart';
import 'package:vale_vantagens/commons/entities/entities.dart';
import 'package:vale_vantagens/core/storage/storage.dart';
import 'package:vale_vantagens/modules/register_discount/data/datasources/impl/register_discount_datasource_impl.dart';
import 'package:vale_vantagens/modules/register_discount/data/datasources/register_discount_datasource.dart';
import 'package:vale_vantagens/modules/register_discount/data/repositories/register_discount_repository_impl.dart';
import 'package:vale_vantagens/modules/register_discount/domain/repositories/register_discount_repository.dart';
import 'package:vale_vantagens/modules/register_discount/domain/usecases/impl/register_discount_usecase_impl.dart';
import 'package:vale_vantagens/modules/register_discount/domain/usecases/register_discount_usecase.dart';
import 'package:vale_vantagens/modules/register_discount/ui/pages/register_discount_bloc.dart';
import 'package:vale_vantagens/modules/register_discount/ui/pages/register_discount_page.dart';

import '../../core/navigation/base_path.dart';

class RegisterDiscountModule extends Module {
  static const root = BasePath('/register-discount');
  static const initial = BasePath('/', root);

  @override
  void routes(RouteManager r) {
    r.child(
      initial.path,
      child: (context) => RegisterDiscountPage(
        discount: r.args.data is DiscountEntity ? r.args.data : null,
        product: r.args.data is ProductEntity ? r.args.data : null,
      ),
    );
    super.routes(r);
  }

  @override
  void binds(Injector i) {
    i.add<RegisterDiscountDatasource>(
      () => RegisterDiscountDatasourceImpl(
        i.get<Storage<String>>(),
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
    i.addSingleton<RegisterDiscountBloc>(
      () => RegisterDiscountBloc(
        i.get<RegisterDiscountUseCase>(),
      ),
    );
    super.binds(i);
  }
}
