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
import 'package:vale_vantagens/modules/discounts/discounts_module.dart';
import 'package:vale_vantagens/modules/discounts/ui/pages/discounts_bloc.dart';
import 'package:vale_vantagens/modules/discounts/ui/pages/discounts_page.dart';

class BlocMock extends Mock implements DiscountsBloc {}

void main() {
  late final DiscountsBloc bloc;
  setUpAll(() {
    bloc = BlocMock();
    Modular.bindModule(AppModule());
    Modular.bindModule(DiscountsModule());
    Modular.replaceInstance<DiscountsBloc>(bloc);
  });

  tearDown(() {
    bloc.dispose();
  });

  group('test discounts page', () {
    testWidgets('Success', (widgetTester) async {
      final streamController = StreamController<BaseState>();

      streamController.sink.add(const SuccessState<List<DiscountEntity>>([]));
      when(() => bloc.stream).thenAnswer((_) => streamController.stream);
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: DiscountsPage(),
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
          home: DiscountsPage(),
        ),
      );

      await widgetTester.pump();
      expect(find.byKey(const Key('DefaultLoadingWidget')), findsOneWidget);
    });
    testWidgets('Error', (widgetTester) async {
      final streamController = StreamController<BaseState>();

      streamController.sink.add(const ErrorState('Error'));
      when(() => bloc.stream).thenAnswer((_) => streamController.stream);
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: DiscountsPage(),
        ),
      );

      await widgetTester.pump();
      expect(find.byKey(const Key('DefaultError')), findsOneWidget);
    });
  });
}
