import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vale_vantagens/core/network/api_client.dart';
import 'package:vale_vantagens/core/network/dio_client_impl.dart';
import 'package:vale_vantagens/core/storage/hive_storage_impl.dart';
import 'package:vale_vantagens/modules/discounts/discounts_module.dart';
import 'package:vale_vantagens/modules/products/products_module.dart';
import 'package:vale_vantagens/modules/register_discount/register_discount_module.dart';

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
    i.add<Storage<String>>(
      () => const HiveStorageImpl<String>(boxName: 'discounts'),
    );
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.module(
      ProductsModule.root.path,
      module: ProductsModule(),
    );
    r.module(
      RegisterDiscountModule.root.path,
      module: RegisterDiscountModule(),
    );
    r.module(
      DiscountsModule.root.path,
      module: DiscountsModule(),
    );
    super.routes(r);
  }
}
