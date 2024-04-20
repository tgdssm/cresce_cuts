import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vale_vantagens/core/network/api_client.dart';
import 'package:vale_vantagens/core/network/api_client_impl.dart';
import 'package:vale_vantagens/modules/products/products_module.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.add<Dio>(() => Dio());
    i.add<ApiClient>(
      () => ApiClientImpl(
        i.get(),
      ),
    );
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.module(ProductsModule.root.path, module: ProductsModule());
    super.routes(r);
  }
}
