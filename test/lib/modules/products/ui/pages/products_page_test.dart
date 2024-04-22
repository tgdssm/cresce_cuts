import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vale_vantagens/app_module.dart';
import 'package:vale_vantagens/core/state_management/states/base_state.dart';
import 'package:vale_vantagens/core/state_management/states/error_state.dart';
import 'package:vale_vantagens/core/state_management/states/loading_state.dart';
import 'package:vale_vantagens/core/state_management/states/success_state.dart';
import 'package:vale_vantagens/commons/entities/entities.dart';
import 'package:vale_vantagens/modules/products/products_module.dart';
import 'package:vale_vantagens/modules/products/ui/pages/products_bloc.dart';
import 'package:vale_vantagens/modules/products/ui/pages/products_page.dart';

class BlocMock extends Mock implements ProductsBloc {}

void main() {
  late final ProductsBloc bloc;
  setUpAll(() {
    bloc = BlocMock();
    Modular.bindModule(AppModule());
    Modular.bindModule(ProductsModule());
    Modular.replaceInstance<ProductsBloc>(bloc);
  });

  tearDown(() {
    bloc.dispose();
  });

  group('test products page', () {
    testWidgets('Success', (widgetTester) async {
      final streamController = StreamController<BaseState>();

      streamController.sink.add(const SuccessState<List<ProductEntity>>([]));
      when(() => bloc.stream).thenAnswer((_) => streamController.stream);
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: ProductsPage(),
        ),
      );

      await widgetTester.pump();
      expect(find.byKey(const Key('SuccessWidget')), findsOneWidget);
    });
    testWidgets('Loading', (widgetTester) async {
      final streamController = StreamController<BaseState>();

      streamController.sink.add(LoadingState());
      when(() => bloc.stream).thenAnswer((_) => streamController.stream);
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: ProductsPage(),
        ),
      );

      await widgetTester.pump();
      expect(find.byKey(const Key('LoadingWidget')), findsOneWidget);
    });
    testWidgets('Error', (widgetTester) async {
      final streamController = StreamController<BaseState>();

      streamController.sink.add(const ErrorState('Error'));
      when(() => bloc.stream).thenAnswer((_) => streamController.stream);
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: ProductsPage(),
        ),
      );

      await widgetTester.pump();
      expect(find.byKey(const Key('DefaultError')), findsOneWidget);
    });
  });
}
