import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vale_vantagens/app_module.dart';
import 'package:vale_vantagens/app_widget.dart';
import 'package:vale_vantagens/commons/results/result.dart';

import 'commons/results/result_failure.dart';
import 'commons/results/result_success.dart';

void main() {
  final res = Result<ResultFailure, ResultSuccess<String>>(
    success: ResultSuccess<String>("tesrte"),
  );

  res.fold((e) => null, (s) => print(s.data));
  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
