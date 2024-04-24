import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vale_vantagens/app_module.dart';
import 'package:vale_vantagens/commons/entities/discount_entity.dart';
import 'package:vale_vantagens/commons/models/discount_model.dart';
import 'package:vale_vantagens/core/state_management/states/base_state.dart';
import 'package:vale_vantagens/modules/register_discount/register_discount_module.dart';
import 'package:vale_vantagens/modules/register_discount/ui/pages/components/default_text_field.dart';
import 'package:vale_vantagens/modules/register_discount/ui/pages/register_discount_bloc.dart';
import 'package:vale_vantagens/modules/register_discount/ui/pages/register_discount_page.dart';
import 'package:vale_vantagens/modules/register_discount/ui/pages/register_discount_states.dart';

class BlocMock extends Mock implements RegisterDiscountBloc {}

final entity = DiscountEntity(
  id: '1',
  name: '',
  description: 'test',
  discountType: DiscountType.price,
  image: 'test',
  price: 0,
  activationDate: DateTime.now(),
  inactivationDate: DateTime.now(),
  discountPercentage: 10,
);

void main() {
  late final RegisterDiscountBloc bloc;
  setUpAll(() {
    bloc = BlocMock();
    Modular.bindModule(AppModule());
    Modular.bindModule(RegisterDiscountModule());
    Modular.replaceInstance<RegisterDiscountBloc>(bloc);
  });

  tearDown(() {
    bloc.dispose();
  });

  group('test register discount page', () {
    testWidgets('DiscountPriceState', (widgetTester) async {
      final streamController = StreamController<BaseState>();

      streamController.sink.add(DiscountPriceState());
      when(() => bloc.stream).thenAnswer((_) => streamController.stream);
      await widgetTester.pumpWidget(
        MaterialApp(
          home: RegisterDiscountPage(
            discount: entity,
          ),
        ),
      );

      await widgetTester.pump();

      final priceOf = find.byKey(const Key('priceOf')).evaluate().first.widget
          as DefaultTextField;

      expect(priceOf.validator!('\$0.00'), 'Informe um valor');

      final priceTo = find.byKey(const Key('priceTo')).evaluate().first.widget
          as DefaultTextField;

      expect(priceTo.validator!('\$0.00'), 'Informe um valor');
      expect(find.byKey(const Key('percentage')), findsNothing);
    });

    testWidgets('DiscountPercentageState', (widgetTester) async {
      final streamController = StreamController<BaseState>();

      streamController.sink.add(DiscountPercentageState());
      when(() => bloc.stream).thenAnswer((_) => streamController.stream);
      await widgetTester.pumpWidget(
        MaterialApp(
          home: RegisterDiscountPage(
            discount: entity,
          ),
        ),
      );

      await widgetTester.pump();

      final priceOf = find.byKey(const Key('price')).evaluate().first.widget
          as DefaultTextField;

      expect(priceOf.validator!('\$0.00'), 'Informe um valor');

      final percentage = find
          .byKey(const Key('percentage'))
          .evaluate()
          .first
          .widget as DefaultTextField;

      expect(percentage.validator!(''), 'Preencha o campo');
      expect(find.byKey(const Key('product-price')), findsNothing);
    });

    testWidgets('DiscountTakePayState', (widgetTester) async {
      final streamController = StreamController<BaseState>();

      streamController.sink.add(DiscountTakePayState());
      when(() => bloc.stream).thenAnswer((_) => streamController.stream);
      await widgetTester.pumpWidget(
        MaterialApp(
          home: RegisterDiscountPage(
            discount: entity,
          ),
        ),
      );

      await widgetTester.pump();

      final price = find
          .byKey(const Key('product-price'))
          .evaluate()
          .first
          .widget as DefaultTextField;

      expect(price.validator!('\$0.00'), 'Informe um valor');

      final take = find.byKey(const Key('take')).evaluate().first.widget
          as DefaultTextField;

      expect(take.validator!('0'), 'Informe um valor');
      expect(find.byKey(const Key('priceOf')), findsNothing);
    });
  });
}
