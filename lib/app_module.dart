import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vale_vantagens/core/network/api_client.dart';
import 'package:vale_vantagens/core/network/api_client_impl.dart';

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
}
