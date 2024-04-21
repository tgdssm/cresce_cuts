import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vale_vantagens/core/state_management/bloc.dart';
import 'package:vale_vantagens/core/state_management/consumer_widget.dart';
import 'package:vale_vantagens/core/state_management/states/base_state.dart';
import 'package:vale_vantagens/core/state_management/states/empty_state.dart';
import 'package:vale_vantagens/core/state_management/states/error_state.dart';
import 'package:vale_vantagens/core/state_management/states/loading_state.dart';
import 'package:vale_vantagens/core/state_management/states/success_state.dart';

class BlocMock extends Mock implements Bloc<BaseState> {}

void main() {
  late final Bloc<BaseState> bloc;
  setUpAll(() {
    bloc = BlocMock();
  });

  tearDown(() {
    bloc.dispose();
  });

  group('test consumer widget', () {
    testWidgets('Success', (widgetTester) async {
      final streamController = StreamController<BaseState>();

      streamController.sink.add(const SuccessState<String>('Success'));
      when(() => bloc.state).thenAnswer((_) => streamController.stream);
      await widgetTester.pumpWidget(MaterialApp(
        home: ConsumerWidget<BaseState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is SuccessState<String>) {
              return Text(state.data);
            }
            return Container();
          },
        ),
      ));

      await widgetTester.pump();
      expect(find.text('Success'), findsOneWidget);
    });
    testWidgets('Loading', (widgetTester) async {
      final streamController = StreamController<BaseState>();

      streamController.sink.add(LoadingState());
      when(() => bloc.state).thenAnswer((_) => streamController.stream);
      await widgetTester.pumpWidget(MaterialApp(
        home: ConsumerWidget<BaseState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is LoadingState) {
              return const Text('Loading');
            }
            return Container();
          },
        ),
      ));

      await widgetTester.pump();
      expect(find.text('Loading'), findsOneWidget);
    });
    testWidgets('Error', (widgetTester) async {
      final streamController = StreamController<BaseState>();

      streamController.sink.add(const ErrorState('Error'));
      when(() => bloc.state).thenAnswer((_) => streamController.stream);
      await widgetTester.pumpWidget(MaterialApp(
        home: ConsumerWidget<BaseState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is ErrorState) {
              return Text(state.message ?? '');
            }
            return Container();
          },
        ),
      ));

      await widgetTester.pump();
      expect(find.text('Error'), findsOneWidget);
    });
    testWidgets('Empty', (widgetTester) async {
      final streamController = StreamController<BaseState>();

      streamController.sink.add(EmptyState());
      when(() => bloc.state).thenAnswer((_) => streamController.stream);
      await widgetTester.pumpWidget(MaterialApp(
        home: ConsumerWidget<BaseState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is EmptyState) {
              return const Text('Empty');
            }
            return Container();
          },
        ),
      ));

      await widgetTester.pump();
      expect(find.text('Empty'), findsOneWidget);
    });
  });
}
