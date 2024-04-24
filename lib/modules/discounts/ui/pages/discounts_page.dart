import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vale_vantagens/commons/entities/discount_entity.dart';
import 'package:vale_vantagens/commons/widgets/default_app_bar.dart';
import 'package:vale_vantagens/core/state_management/consumer_widget.dart';
import 'package:vale_vantagens/core/state_management/state_management.dart';
import 'package:vale_vantagens/modules/discounts/ui/pages/components/success_widget.dart';

import '../../../../commons/widgets/default_error.dart';
import '../../../../commons/widgets/loading_widget.dart';
import '../../../../core/state_management/states/error_state.dart';
import '../../../../core/state_management/states/loading_state.dart';
import '../../../../core/state_management/states/success_state.dart';
import 'discounts_bloc.dart';

class DiscountsPage extends StatefulWidget {
  const DiscountsPage({super.key});

  @override
  State<DiscountsPage> createState() => _DiscountsPageState();
}

class _DiscountsPageState
    extends StateManagement<DiscountsPage, DiscountsBloc> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'Descontos',
        onTapBackButton: () => Modular.to.pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: ConsumerWidget(
          bloc: bloc,
          builder: (context, state) {
            return switch (state) {
              LoadingState() => const DefaultLoadingWidget(),
              ErrorState() => DefaultError(
                  key: const Key('DefaultError'),
                  errorText: state.message,
                ),
              SuccessState<List<DiscountEntity>>() => SuccessWidget(
                  discounts: state.data,
                ),
              _ => Container(),
            };
          },
        ),
      ),
    );
  }
}
