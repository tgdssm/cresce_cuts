import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:vale_vantagens/core/network/api_client.dart';
import 'package:vale_vantagens/core/network/dio_client_impl.dart';
import 'package:vale_vantagens/core/storage/hive_storage_impl.dart';
import 'package:vale_vantagens/modules/products/products_module.dart';

import 'commons/models/models.dart';
import 'core/storage/storage.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.add<Dio>(() => Dio());
    i.add<ApiClient>(
      () => DioClientImpl(
        i.get(),
      ),
    );
    i.add<Storage<DiscountModel>>(
      () => const HiveStorageImpl<DiscountModel>(boxName: 'discounts'),
    );
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.module(ProductsModule.root.path, module: ProductsModule());
    super.routes(r);
  }
}
