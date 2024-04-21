import 'package:flutter_modular/flutter_modular.dart';
import 'package:vale_vantagens/core/navigation/base_path.dart';
import 'package:vale_vantagens/core/network/api_client.dart';
import 'package:vale_vantagens/modules/products/data/datasources/impl/products_datasource_impl.dart';
import 'package:vale_vantagens/modules/products/data/datasources/products_datasource.dart';
import 'package:vale_vantagens/modules/products/data/repositories/products_repository_impl.dart';
import 'package:vale_vantagens/modules/products/domain/repositories/products_repository.dart';
import 'package:vale_vantagens/modules/products/domain/usecases/get_products_usecase.dart';
import 'package:vale_vantagens/modules/products/domain/usecases/impl/get_products_usecase_impl.dart';
import 'package:vale_vantagens/modules/products/ui/pages/products_bloc.dart';
import 'package:vale_vantagens/modules/products/ui/pages/products_page.dart';

class ProductsModule extends Module {
  static const root = BasePath('//');

  @override
  void routes(RouteManager r) {
    r.child(root.path, child: (context) => const ProductsPage());
    super.routes(r);
  }

  @override
  void binds(Injector i) {
    i.add<ProductsDatasource>(
      () => ProductsDatasourceImpl(
        i.get<ApiClient>(),
      ),
    );
    i.add<ProductsRepository>(
      () => ProductsRepositoryImpl(
        i.get<ProductsDatasource>(),
      ),
    );
    i.add<GetProductsUseCase>(
      () => GetProductsUseCaseImpl(
        i.get<ProductsRepository>(),
      ),
    );
    i.addSingleton<ProductsBloc>(
      () => ProductsBloc(
        i.get<GetProductsUseCase>(),
      ),
    );
    super.binds(i);
  }
}
