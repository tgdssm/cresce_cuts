import 'package:flutter_modular/flutter_modular.dart';
import 'package:vale_vantagens/core/navigation/base_path.dart';
import 'package:vale_vantagens/modules/discounts/data/datasources/discounts_datasource.dart';
import 'package:vale_vantagens/modules/discounts/data/datasources/impl/discounts_datasouce_impl.dart';
import 'package:vale_vantagens/modules/discounts/data/repositories/discounts_repository_impl.dart';
import 'package:vale_vantagens/modules/discounts/domain/repositories/discounts_repository.dart';
import 'package:vale_vantagens/modules/discounts/domain/usecases/get_discounts_usecase.dart';
import 'package:vale_vantagens/modules/discounts/domain/usecases/impl/get_discounts_usecase_impl.dart';
import 'package:vale_vantagens/modules/discounts/ui/pages/discounts_bloc.dart';
import 'package:vale_vantagens/modules/discounts/ui/pages/discounts_page.dart';

import '../../core/storage/storage.dart';

class DiscountsModule extends Module {
  static const root = BasePath('/discounts');
  static const initial = BasePath('/', root);

  @override
  void routes(RouteManager r) {
    r.child(
      initial.path,
      child: (context) => const DiscountsPage(),
    );
    super.routes(r);
  }

  @override
  void binds(Injector i) {
    i.add<DiscountsDatasource>(
      () => DiscountsDatasourceImpl(
        i.get<Storage<String>>(),
      ),
    );
    i.add<DiscountsRepository>(
      () => DiscountsRepositoryImpl(
        i.get<DiscountsDatasource>(),
      ),
    );
    i.add<GetDiscountsUseCase>(
      () => GetDiscountsUseCaseImpl(
        i.get<DiscountsRepository>(),
      ),
    );
    i.addSingleton<DiscountsBloc>(
      () => DiscountsBloc(
        i.get<GetDiscountsUseCase>(),
      ),
    );
    super.binds(i);
  }
}
